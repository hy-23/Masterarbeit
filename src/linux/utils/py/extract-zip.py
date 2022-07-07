#!/home/student/yogeshappa/miniconda3/bin/python3

"""
Script to extract zip files in the given directory.
All the zip files in the directory are extracted and saved in their own respective directories.
The source zip files are retained as it is.

Parameters:
    file_path <str>: Is a directory that contains the zip files to be extracted.
    
Author: Harsha Yogeshappa, M.Sc
Version: 1.0
"""

import os
import zipfile
import argparse

# parse the commandline
parser = argparse.ArgumentParser()
parser.add_argument('--file-path', type=str, required=True, help='path for the zip files')
args = parser.parse_args()

# list everything in the path; both directories and files.
dirlist = os.listdir(args.file_path)
'''
args.file_path
├───brain0.zip
├───brain1.zip
├───brain2.zip
├───brain3.zip
├───brain4.zip
├───brain5.zip
├───brain6.zip
├───brain7.zip
├───brain8.zip
├───brain9.zip
├─── ......
├─── ......
├─── ......
├───brain19.zip
├───harsha.txt
└───xyz
'''

# Of all the directories and files, filter only .zip files
files = [file for file in dirlist if (os.path.isfile(os.path.join(args.file_path, file)) and file.endswith('.zip'))]
'''
args.file_path
├───brain0.zip
├───brain1.zip
├───brain2.zip
├───brain3.zip
├───brain4.zip
├───brain5.zip
├───brain6.zip
├───brain7.zip
├───brain8.zip
├───brain9.zip
├─── ......
├─── ......
├─── ......
└───brain19.zip
'''

# iterate through each zip file and extract them into their own directories.
for f in files:
    '''
    f are only .zip files
    '''
    zip_file_path = os.path.join(args.file_path, f) # e.g., f = brain0.zip
    tar_file_path = os.path.join(args.file_path, f[:-4]) # e.g., f[:-4] = brain0
    with zipfile.ZipFile(zip_file_path, 'r') as zip_ref:
        zip_ref.extractall(tar_file_path)
