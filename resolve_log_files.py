#!/usr/bin/env python

####################################################################
# Python 2.7 script for checking which subjects were not downloaded properly from NDA #
####################################################################

# Directory where result data are located
experiment_dir = ''
subjectname = ''

from argparse import ArgumentParser
import sys
from glob import glob
import os
import shutil
import numpy as np


def check_exists(name,filename,files_missing):
    if not os.path.exists(filename):
        print(name + ' does not exist [' + filename + ']')
        files_missing = files_missing + 1
    return files_missing

if __name__ == "__main__":
    # Parse input arguments into args structure
    parser = ArgumentParser()
    parser.add_argument('--downloadcmd_dir')
    parser.add_argument('--downloadcmd_logdir')
    parser.add_argument('--subjid')
    parser.add_argument('--output', help='print 0[default]=Nunber of download requests, 1=Number of skipped files, 2=Number of errors, 3=Filenames in progress report, 4=Folders in progress report', default='0')
    args = parser.parse_args()
    
    d_dir = args.downloadcmd_dir
    dlog_dir = args.downloadcmd_logdir
    subjid = args.subjid
    output = int(float(args.output))
    
    case_dirs = glob(d_dir + '/*')
    progress_report = []
    progress_dir = []
    for case_dir in case_dirs:
        if not os.path.isdir(case_dir):
            continue
        case_file = case_dir + os.sep + 'download-progress-report.csv'
        if not os.path.isfile(case_file):
            continue
        file = open(case_file, 'r')
        lines = file.readlines()
        file.close()
        for index, line in enumerate(lines):
            if subjid in line:
                progress_dir.append(case_dir)
                progress_report.append(line.split(',')[1])
                break
        if len(progress_report) > 0:
            break
    if output == 3:
        if len(progress_report) == 0:
            print('N/A')
        for r in progress_report:
            print(r)
    if output == 4:
        if len(progress_dir) == 0:
            print('N/A')
        for r in progress_dir:
            print(r)
    case_files = glob(dlog_dir + '/*_log.txt')
    #print(case_files)
    skipped_files = []
    download_requests = []
    errors = []
    for case_file in case_files:
        if not os.path.isfile(case_file):
            continue
        #print('Reading:' + case_file)
        file = open(case_file, 'r')
        lines = file.readlines()
        file.close()
        for index, line in enumerate(lines):
            if subjid in line:
                #print("Line {}: {}".format(index, line.strip()))
                if 'Skipping' in line:
                    skipped_files.append(int(float(line.split('Skipping')[1].split(' ')[1])))
                if 'Total download requests' in line:
                    download_requests.append(int(float(line.split('Total download requests')[1].split(' ')[1])))
                if 'Total errors encountered:' in line:
                    errors.append(int(float(line.split('Total errors encountered:')[1].split(' ')[1])))
    if output == 0:
        if len(download_requests) == 0:
            print('N/A')        
        for r in download_requests:
            print(r)
    if output == 1:
        if len(skipped_files) == 0:
            print('N/A')        
        for r in skipped_files:
            print(r)
    if output == 2:
        if len(errors) == 0:
            print('N/A')        
        for r in errors:
            print(r)
            
