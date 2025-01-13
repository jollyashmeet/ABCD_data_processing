#!/bin/bash
#Jolly, 2024
#April, 2024
#script to create the database text file for xcp_d


# Check if the input file exists
#G010
#G087
#G031
#G075
#G032
#S090
#S086
#S065
#S013
#S076
#S022
#S042
#S053
#S020
#S012
#S014
#S011
#S021
#P064
#P023
#P043
site="P064"
input_file="/scratch/project_2001640/ABCD_fMRI/csc_fmri/scripts/downcmd_txt_files/${site}_complete_fmriprep.txt"
if [ ! -f "$input_file" ]; then
    echo "Input file '$input_file' not found."
    exit 1
fi

# Check if the output file exists, if not, create it
output_file="/scratch/project_2001640/ABCD_fMRI/csc_fmri/database_xcpd.txt"
if [ ! -f "$output_file" ]; then
    echo -e "Subject IDs\txcp_d(36P)_cifti(1)\txcp_d(36P)_noncifti(2)\txcp_d(AROMA)_cifti(3)\txcp_d(AROMA)_noncifti(4)" > "$output_file"
fi

# Read the existing subjects from the output file
existing_subjects=($(tail -n +2 "$output_file" | cut -d' ' -f1))

# Read unique new subjects from the input file
new_subjects=($(awk '!/subject|Subject/ && !seen[$1]++ { print $1 }' "$input_file"))

# Filter out existing subjects from new subjects
filtered_subjects=()
for subject in "${new_subjects[@]}"; do
    if ! [[ " ${existing_subjects[*]} " =~ " ${subject} " ]]; then
        filtered_subjects+=("$subject")
    fi
done

#Append new subjects and corresponding columns to the output file
for subject in "${filtered_subjects[@]}"; do
    echo -e "$subject\tN/A\tN/A\tN/A\tN/A" >> "$output_file"
done


echo "Script completed."

