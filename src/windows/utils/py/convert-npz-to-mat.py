#! python

"""
Script to convert npz files to mat files.

Parameters:
    file_path <str>: Is a directory that contains the zip files to be extracted.
    
Author: Harsha Yogeshappa, M.Sc
Version: 1.0
"""
import argparse
import numpy as np
from scipy.io import savemat

# parse the commandline
parser = argparse.ArgumentParser()
parser.add_argument('--npz-file', type=str, required=True, help='npz filename with directory')
parser.add_argument('--out-file', type=str, required=True, help='mat filename with directory')
parser.add_argument('--var-name', type=str, required=True, help='name of the variable in mat')
args = parser.parse_args()

npz = np.load(args.npz_file)
a = npz['vol']

mdic = {args.var_name : a}

savemat(args.out_file, mdic)

