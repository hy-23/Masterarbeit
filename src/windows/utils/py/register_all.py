import os
import argparse
import numpy as np
import voxelmorph as vxm
import tensorflow as tf
import time

# parse the commandline
parser = argparse.ArgumentParser()
parser.add_argument('--file-list', type=str, required=True, help='file that holds the path for the npz files')
parser.add_argument('-g', '--gpu', help='GPU number(s) - if not supplied, CPU is used')
parser.add_argument('--multichannel', action='store_true',
                    help='specify that data has multiple channels')
parser.add_argument('--fixed', required=True, help='fixed image (target) filename')
parser.add_argument('--model', required=True, help='keras model for nonlinear registration')
parser.add_argument('--warp', help='output warp deformation filename')
parser.add_argument('--out-path', required=True, help='moved image (target) save directory')
args = parser.parse_args()

predict_files = vxm.py.utils.read_file_list(args.file_list)
assert len(predict_files) > 0, 'Could not find any data.'


for i in range(len(predict_files)):
    # tensorflow device handling
    device, nb_devices = vxm.tf.utils.setup_device(args.gpu)
    
    # load moving and fixed images
    add_feat_axis = not args.multichannel
    moving = vxm.py.utils.load_volfile(predict_files[i], add_batch_axis=True, add_feat_axis=add_feat_axis)
    print('Harsha, moving volfile is loaded.')
    fixed, fixed_affine = vxm.py.utils.load_volfile(
        args.fixed, add_batch_axis=True, add_feat_axis=add_feat_axis, ret_affine=True)
    print('Harsha, fixed volfile is loaded.')
    inshape = moving.shape[1:-1]
    nb_feats = moving.shape[-1]
    
    t0 = time.time()
    with tf.device(device):
        print("Harsha, device name: {}".format(device))
        # load model and predict
        config = dict(inshape=inshape, input_model=None)
        warp = vxm.networks.VxmDense.load(args.model, **config).register(moving, fixed)
        print('Harsha, registeration of moving and fixed is done.')
        moved = vxm.networks.Transform(inshape, nb_feats=nb_feats).predict([moving, warp])
        print('Harsha, Transformation is done.')
    t1 = time.time()
    print('Harsha, time for registration is {}'.format(t1-t0))
    
    # save warp
    if args.warp:
        vxm.py.utils.save_volfile(warp.squeeze(), args.warp, fixed_affine)
        print('Harsha, warp is getting saved.')
    
    head_tail = os.path.split(predict_files[i])
    moved_file = os.path.join(args.out_path, 'moved_'+head_tail[-1])
    print()
    print("Harsha, I predicted {}".format(head_tail[-1]))
    print()
    # save moved image
    vxm.py.utils.save_volfile(moved.squeeze(), moved_file, fixed_affine)
    print('Harsha, saving moved image.')
