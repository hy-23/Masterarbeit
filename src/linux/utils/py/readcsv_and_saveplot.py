#!/home/students/yogeshappa/miniconda3/bin/python3

'''
Script reads the given csv file and plots a graph for every column against column_0 : 'epoch'.

Parameters:
    csv_file  <str>: Full file path to the csv_file.
    save_path <str>: Directory where the figures needs to be saved.
    title_pfx <str>: Prefix to the title of each plots.
    xlabel    <str>: Normally, is epoch. 
'''
import argparse
import pandas as pd
import matplotlib.pyplot as plt

# parse the commandline
parser = argparse.ArgumentParser()
parser.add_argument('--csv-file', type=str, required=True, help='Full file path to the csv_file')
parser.add_argument('--save-path', type=str, required=True, help='Directory location to save the figures')
parser.add_argument('--title-pfx', type=str, required=True, help='Prefix to the title of each plots')
parser.add_argument('--xlabel', type=str, default='epoch', help='x-axis label for each plots (default: epoch)')
args = parser.parse_args()

csv_file = args.csv_file
save_path = args.save_path
title_pfx = args.title_pfx
xlabel = args.xlabel

df = pd.read_csv(csv_file)

no_of_columns = len(df.columns)
for col in range(no_of_columns - 1):
    name = df.columns[col+1]
    data = list(df.iloc[:, col+1])
    title = title_pfx + '-' + name
    plt.plot(data)
    plt.xlabel(xlabel)
    plt.ylabel(name)
    plt.title(title)
    out_file = save_path + '/' + name + '.jpg'
    plt.savefig(out_file)
    plt.close()
