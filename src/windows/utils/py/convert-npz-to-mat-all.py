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
import os

# parse the commandline
parser = argparse.ArgumentParser()
parser.add_argument('--file-path', type=str, required=True, help='file path for npz files')
args = parser.parse_args()

# path where all the npz files are there.
src_file_path = args.file_path

# list everything in the path; both directories and files.
dirlist = os.listdir(src_file_path)

# list of npz files in the src_file_path
npz_file = [file for file in dirlist if (os.path.isfile(os.path.join(src_file_path, file)) and file.endswith('.npz'))]

for npz_idx in range(len(npz_file)):
    src = os.path.join(src_file_path, npz_file[npz_idx])
    dst = src.replace('.npz', '.mat')
    npz = np.load(src)
    a = npz['vol']

    name = os.path.split(src)[-1]
    var_name = os.path.splitext(name)[-2] # split name and extension.
    mdic = {var_name : a}

    savemat(dst, mdic)

