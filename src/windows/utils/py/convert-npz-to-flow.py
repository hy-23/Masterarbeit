import argparse
import os
import numpy as np
import neurite as ne

# parse the commandline
parser = argparse.ArgumentParser()
parser.add_argument('--file-path', type=str, required=True, help='file path for warp npz files')
parser.add_argument('--name', type=str, required=True, help='file name of the warp npz files')
parser.add_argument('--scale', type=int, required=True, help='scale down factor to visualize neurite flow')
parser.add_argument('--slice-num', type=int, required=True, help='slice number whose flow needs to be visualized')
args = parser.parse_args()

src = os.path.join(args.file_path, args.name)
npz = np.load(src)
a = npz['vol']
b = a[:,:,args.slice_num,:2]
c = b[1::args.scale, 1::args.scale, :] / args.scale
ne.plot.flow([c], width=5)