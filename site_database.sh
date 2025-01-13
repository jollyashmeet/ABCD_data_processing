#!/bin/bash
#Mar, 2024
#Ashmeet Jolly, FinnBrain Neuroimaging Lab
#Script to create individual database files for all the sites

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
site="P043"
# Check if the input file exists
input_file="/scratch/project_2001640/ABCD_fMRI/site_data/${site}_site.txt"
if [ ! -f "$input_file" ]; then
    echo "Input file '$input_file' not found."
    exit 1
fi

# Check if the output file exists, if not, create it
output_file="/scratch/project_2001640/ABCD_fMRI/csc_fmri/${site}_database.txt"
if [ ! -f "$output_file" ]; then
    #echo -e "Subject IDs\tDownload(0)\tDataSufficiency(1)\tdcm2bids(2)\tMRIQC(3)\tfMRI(4)\tFSL_aroma(5))\txcp-D[cifti](6)\txcp-D[non-cifti](7)\tCustom_processing(8)" > "$output_file"
    echo -e "Subject IDs\tDownload(0)\tDataSufficiency(1)\tdcm2bids(2)\tMRIQC(3)\tfMRIprep(4)" > "$output_file"
fi

# Read the existing subjects from the output file
existing_subjects=($(tail -n +2 "$output_file" | cut -d' ' -f1))

# Read the new subjects from the first column of the input file
new_subjects=($(cut -f1 "$input_file"))

# Filter out existing subjects from new subjects
filtered_subjects=()
for subject in "${new_subjects[@]}"; do
    if ! [[ " ${existing_subjects[*]} " =~ " ${subject} " ]]; then
        filtered_subjects+=("$subject")
    fi
done

#Append new subjects and corresponding columns to the output file
for subject in "${filtered_subjects[@]}"; do
    echo -e "$subject\tN/A\tN/A\tN/A\tN/A\tN/A" >> "$output_file"

done
