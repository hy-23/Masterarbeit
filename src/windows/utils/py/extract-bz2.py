#! python

"""
Script to extract zip files in the given directory.
All the zip files in the directory are extracted and saved in their own respective directories.
The source zip files are retained as it is.

Parameters:
    file_path <str>: Is a directory that contains the bz2 files to be extracted.
    
Author: Harsha Yogeshappa, M.Sc
Version: 1.0
"""

import os
import bz2
import argparse

# parse the commandline
parser = argparse.ArgumentParser()
parser.add_argument('--file-path', type=str, required=True, help='path for the zip files')
args = parser.parse_args()

# list everything in the path; both directories and files.
src_file_path = args.file_path;
dirlist = os.listdir(src_file_path)


# Of all the directories and files, filter only .bz2 files
files = [file for file in dirlist if (os.path.isfile(os.path.join(src_file_path, file)) and file.endswith('.bz2'))]


# iterate through each zip file and extract them into their own directories.
for f in files:
    '''
    f are only .bz2 files
    '''
    bz2_file_path = os.path.join(src_file_path, f) # e.g., f = brain0.lsm.bz2
    lsm_file_path = os.path.join(src_file_path, f[:-4]) # e.g., f[:-4] = brain0.lsm

    # ref: https://stackoverflow.com/a/16963578/8314782
    zipfile = bz2.BZ2File(bz2_file_path) # open the file
    data = zipfile.read() # get the decompressed data
    lsm_file_path = os.path.join(src_file_path, f[:-4]) # assuming the filepath ends with .bz2
    with open(lsm_file_path, 'wb') as zip_ref:
        zip_ref.write(data)