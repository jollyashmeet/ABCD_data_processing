#!/bin/bash
#script to check whether all BIDS format files have .json file and .nii.gz file in both anat and func folders
#August, 2023; Ashmeet Jolly

site="G010"
parent_dir="/scratch/project_2001640/ABCD_fMRI/${site}/BIDS"
date_run=$(/usr/bin/date '+Year+%Y_Month%m_Day%d_H%H_M%M_S%S') #record the date of run

# Create the result file
dcm2bids_incomplete_file="/scratch/project_2001640/ABCD_fMRI/csc_fmri/scripts/downcmd_txt_files/${site}_dcm2bids_incomplete_file.txt"
dcm2bids_complete_file="/scratch/project_2001640/ABCD_fMRI/csc_fmri/scripts/downcmd_txt_files/${site}_dcm2bids_complete_file.txt"

echo "Subject ID" > "$dcm2bids_incomplete_file"
echo "Subject ID" > "$dcm2bids_complete_file"

# Go to the parent directory
cd "$parent_dir" || exit 1

# Iterate through each sub-directory in BIDS
for sub_dir in */; do
    ses_dir="${sub_dir}/ses-baselineYear1Arm1"
    if [ -d "$ses_dir" ]; then
        anat_dir="${ses_dir}/anat"
        func_dir="${ses_dir}/func"
        if [ -d "$anat_dir" ] && [ -d "$func_dir" ]; then
            # Extract the 'NDAR********' portion from sub_dir and write it to the incomplete file
            subject_id=$(echo "$sub_dir" | grep -oP 'NDAR\K[0-9A-Z]+')
            anat_count=$(find "$anat_dir" -maxdepth 1 -type f -name "*.json" -o -name "*.nii.gz" | wc -l)
            func_count=$(find "$func_dir" -maxdepth 1 -type f -name "*.json" -o -name "*.nii.gz" | wc -l)
            if [ "$anat_count" -ne 2 ] || [ "$func_count" -ne 2 ]; then
                echo "$sub_dir $anat_count $func_count" >> "$dcm2bids_incomplete_file"
            else
               # Extract the 'INV********' portion from sub_dir and write it to the complete file
                subject_id=$(echo "$sub_dir" | grep -oP 'sub-NDAR\K[0-9A-Z]+')
                echo "$subject_id" >> "$dcm2bids_complete_file"
            fi
        else
            echo "$sub_dir is missing either anat or func directory" >> "$dcm2bids_incomplete_file"
        fi
    else
        echo "$sub_dir is missing ses directory" >> "$dcm2bids_incomplete_file"
    fi

done

# Extract lines starting with "sub-NDAR", remove "sub-" prefix and save to a new file
# Filter lines containing "sub-NDAR" and extract subject IDs
grep 'INV' "$dcm2bids_complete_file" > temp_file.txt
mv temp_file.txt "$dcm2bids_complete_file"
grep 'sub-NDAR' "$dcm2bids_incomplete_file" | sed 's/sub-NDAR//; s/ is missing.*//; s:/$::' > tmp_file.txt

# Replace the original file with the extracted subject IDs
mv tmp_file.txt "$dcm2bids_incomplete_file"
echo "dcm2bids counts check completed."


#run the python script to write to the database.txt file
#python3 /scratch/project_2001640/ABCD_fMRI/csc_fmri/scripts/python_status.py
