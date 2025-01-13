#!/bin/bash
# Feb, 2024
# Check if the subjects went through xcp_d with --cifti flag successfully
# ABCD study, Ashmeet Jolly

site="P064"
# Define the directory where the subject folders are located
subjects_dir="/scratch/project_2001640/ABCD_fMRI/${site}/BIDS/derivatives/xcpd_cifti"

# Create a variable to store the path of the non-faulty MRIQC file
non_faulty_xcpd_cifti_file="/scratch/project_2001640/ABCD_fMRI/csc_fmri/scripts/downcmd_txt_files/${site}_non_faulty_xcpd_cifti.txt"

# Create a variable to store the path of the faulty MRIQC file
faulty_xcpd_cifti_file="/scratch/project_2001640/ABCD_fMRI/csc_fmri/scripts/downcmd_txt_files/${site}_faulty_xcpd_cifti.txt"

# Check if the directories exist
if [ ! -d "$(dirname "$non_faulty_xcpd_cifti_file")" ]; then
    echo "Directory $(dirname "$non_faulty_xcpd_cifti_file") does not exist."
fi

if [ ! -d "$(dirname "$faulty_xcpd_cifti_file")" ]; then
    echo "Directory $(dirname "$faulty_xcpd_cifti_file") does not exist."
fi

# Initialize a flag to check if all conditions are met
all_conditions_met=true
# Iterate through all sub-directories
for subject_dir in "$subjects_dir"/*; do
    if [ -d "$subject_dir" ]; then
        subject_name=$(basename "$subject_dir")
# Exclude 'atlases' directory
        if [ "$subject_name" = "atlases" ]; then
            continue
        fi
        if [ "$subject_name" = "dataset_description.json" ]; then
            continue
        fi
        if [ "$subject_name" = "desc-linc_qc.json" ]; then
            continue
        fi

        # Extract the first 19 characters from the subject name
        subject_id="${subject_name:0:19}"
        if [[ -d "$subjects_dir/$subject_id" && -f "$subjects_dir/${subject_id}.html" ]]; then
           # Check if the additional conditions are met
            if [ -d "$subjects_dir/$subject_id/ses-baselineYear1Arm1/anat" ]; then
                num_files_anat=$(ls -1 "$subjects_dir/$subject_id/ses-baselineYear1Arm1/anat" | wc -l)
                if [ "$num_files_anat" -eq 38 ]; then
                    # Check if the "func" directory exists
                    if [ -d "$subjects_dir/$subject_id/ses-baselineYear1Arm1/func" ]; then
                        num_files_func=$(ls -1 "$subjects_dir/$subject_id/ses-baselineYear1Arm1/func" | wc -l)
                        if [ "$num_files_func" -eq 240 ]; then
                            # All conditions are met, append this subject to the non-faulty subjects file
                            echo "All conditions met for $subject_id"
                            echo $subject_id >> "$non_faulty_xcpd_cifti_file"
                        else
                            echo "Number of files in func directory is not 240 for $subject_id"
                            all_conditions_met=false
                            echo $subject_id >> "$faulty_xcpd_cifti_file"  # Add subject ID to faulty file
                        fi
                    else
                        echo "$subjects_dir/$subject_id/ses-baselineYear1Arm1/func directory does not exist for $subject_id"
                        all_conditions_met=false
                        echo $subject_id >> "$faulty_xcpd_cifti_file"  # Add subject ID to faulty file
                    fi
                else
                    echo "Number of files in anat directory is not 2 for $subject_id"
                    all_conditions_met=false
                    echo $subject_id >> "$faulty_xcpd_cifti_file"  # Add subject ID to faulty file
                fi
            else
                echo "$subjects_dir/$subject_id/ses-baselineYear1Arm1/anat directory does not exist for $subject_id"
                all_conditions_met=false
                echo $subject_id >> "$faulty_xcpd_cifti_file"  # Add subject ID to faulty file
            fi
        else
            # At least one condition is not met, append this subject to the faulty subjects file
            echo "Conditions not met for $subject_id"
            echo $subject_id >> "$faulty_xcpd_cifti_file"
            # Set the flag to false
            all_conditions_met=false
        fi
###removal of faulty####
        # Delete the subject directory and associated files if listed in the faulty file
        if grep -q "$subject_id" "$faulty_xcpd_cifti_file"; then
            echo "Removing subject directory and associated files for $subject_id"
            rm -rf "$subjects_dir/$subject_id"*
        fi
    fi
done

# Remove prefix from non-faulty and faulty subject files
sed -i 's/sub-NDAR//' "$non_faulty_xcpd_cifti_file"
sed -i 's/sub-NDAR//' "$faulty_xcpd_cifti_file"


# Filter out duplicate subject IDs from non-faulty and faulty files
awk '!seen[$1]++' "$non_faulty_xcpd_cifti_file" > temp_non_faulty.txt
mv temp_non_faulty.txt "$non_faulty_xcpd_cifti_file"

awk '!seen[$1]++' "$faulty_xcpd_cifti_file" > temp_faulty.txt
mv temp_faulty.txt "$faulty_xcpd_cifti_file"

#run the python script to write to the database.txt file
#python3 python_status.py
