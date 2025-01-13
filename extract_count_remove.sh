#!/bin/bash
#October, 2023
#script that deletes those subjects from the image03 dir that  have been extracted.

# Directory containing .tgz files
source_dir="/scratch/project_2001640/ABCD_fMRI/P064_download/image03"

# Directory to check for subject IDs
check_dir="/scratch/project_2001640/ABCD_fMRI/P064_download"

# Get a list of subject IDs from .tgz filenames in the source directory
subject_ids=($(find "$source_dir" -type f -name 'NDAR*.tgz' | sed -E 's/.*NDAR([^_]+)_.*/\1/'))

# Iterate through the subject IDs
for id in "${subject_ids[@]}"; do
    # Check if a directory with the same subject ID exists in the check directory
    if [ -d "$check_dir/sub-NDAR$id" ]; then
        # Delete the .tgz files with the matching subject ID
        find "$source_dir" -type f -name "NDAR${id}_*.tgz" -exec rm {} \;
        echo "Deleted .tgz files with subject ID NDAR$id"
    fi
done
