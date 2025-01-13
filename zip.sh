#!/bin/bash
#script to put preprocessed data into allas
#October, 2023
#Jolly, FinnBrain Neuroimaging Lab

base_dir="/scratch/project_2001640/ABCD_fMRI/G010/BIDS/derivatives/fmriprep"
output_dir="/scratch/project_2001640/ABCD_fMRI/G010/BIDS/derivatives/fmriprep_zipped"  # This is where the zip files will be saved

# Loop through each entry in the base directory
for entry in "$base_dir"/sub-NDAR*; do
    # Check if it's a directory
    if [ -d "$entry" ]; then
        # Extract the subject name (e.g., sub-NDAR123)
        subject_name=$(basename "$entry")

        # Check if the corresponding files exist
        if [ -f "$base_dir/$subject_name.html" ] && [ -d "$base_dir/$subject_name"_output ] && [ -d "$base_dir/$subject_name" ]; then
            # Create a zip archive for the subject and include all files and sub-directories
            #mkdir -p "$output_dir/$subject_name.zip"

            zip -r "$output_dir/$subject_name.zip" "$entry" "$base_dir/$subject_name.html" "$base_dir/$subject_name"_output "$base_dir/$subject_name"

            echo "Created zip archive for $subject_name"
        fi
    fi
done

