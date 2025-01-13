#!/usr/bin/env python
# -*- coding: UTF-8 -*-

###################################################################################################
# (c) 2017-2023 MRCTurku, Department Diagnostic of Radiology, University of Turku                 #
# All rights reserved, Proprietary and confidential                                               #
# version 1.0.0 by: Harri Merisaari haanme@utu.fi                                                 #
###################################################################################################

import numpy as np
from argparse import ArgumentParser
import sys
import os
import shutil
from glob import glob
import json
import copy

# Directory where result data are located
experiment_dir = ''


preparation_pairs = {}
preparation_pairs['PhaseEncodingAxis'] = "PhaseEncodingDirection"
preparation_pairs['EstimatedTotalReadoutTime'] = "TotalReadoutTime"
preparation_pairs['EstimatedEffectiveEchoSpacing'] = "EffectiveEchoSpacing"

#
# Editing of json file
# 
# param filename: full path to json file that is being edited
#
def prepare_json_fMRI(filename):
    with open(filename) as json_file:
        # Load key-value pairs from the json file
        data = json.load(json_file)
        # Copy all contents as they are to data_out (i e deep copy instead of shallow copy)
        data_out = copy.deepcopy(data)
	# Go through individual key-value pairs of json file
        for key in data.keys():
            if key in preparation_pairs.keys():
                print((key, data[key]))
                data_out[preparation_pairs[key]] = data[key]
    # Create json object from key-value pairs in data_out
    json_object = json.dumps(data_out, indent=4)
    # Write the object, overwriting filename, editing the same json and not creating a new json
    with open(filename, "w") as outfile:
        outfile.write(json_object)



###############
# Main script #
###############
if __name__ == "__main__":
    # Parse input arguments into args structure
    parser = ArgumentParser()
    parser.add_argument("--folder", dest="folder", help="BIDS base folder", required=True)
    parser.add_argument("--subjid", dest="subjid", help="BIDS subject ID", required=True)
    parser.add_argument("--ses", dest="ses", help="BIDS session ID", required=True)
    args = parser.parse_args()
    basefolder = args.folder
    subjid = args.subjid
    ses = args.ses

    sdir = basefolder + os.sep + subjid + os.sep + ses

    # Anonymize all json files in all folders
    if not os.path.isdir(sdir + os.sep + 'anat'):
        print(sdir + os.sep + 'anat is missing')
        sys.exit(1)
    if not os.path.isdir(sdir + os.sep + 'func'):
        print(sdir + os.sep + 'func is missing')
        sys.exit(1)

    # Fix jsons for TOPUP of fMRI
    # AP direction is j, PA direction is j-
    if os.path.exists(sdir + os.sep + 'func' + os.sep + subjid + '_' + ses + '_task-rest_bold.json'):
        prepare_json_fMRI(sdir + os.sep + 'func' + os.sep + subjid + '_' + ses + '_task-rest_bold.json')
    else:
        print(sdir + os.sep + 'func' + os.sep + subjid + '_' + ses + '_task-rest_bold.json is missing')

    sys.exit(0)
