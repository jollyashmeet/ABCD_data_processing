#!/bin/bash
# August, 2023
# Check if the subjects went through MRIQC successfully
# ABCD study, Ashmeet Jolly

site="G010"
# Define the directory where the subject folders are located
subjects_dir="/scratch/project_2001640/ABCD_fMRI/${site}/BIDS/derivatives/mriqc"

# Go to the specified directory
#cd /scratch/project_2001640/ABCD_fMRI/G054/BIDS/derivatives/mriqc || exit 1

# Create a variable to store the path of the non-faulty MRIQC file
non_faulty_mriqc_file="/scratch/project_2001640/ABCD_fMRI/csc_fmri/scripts/downcmd_txt_files/${site}_non_faulty_mriqc.txt"

# Create a variable to store the path of the faulty MRIQC file
faulty_mriqc_file="/scratch/project_2001640/ABCD_fMRI/csc_fmri/scripts/downcmd_txt_files/${site}_faulty_mriqc.txt"

# Check if the directories exist
if [ ! -d "$(dirname "$non_faulty_mriqc_file")" ]; then
    echo "Directory $(dirname "$non_faulty_mriqc_file") does not exist."
fi

if [ ! -d "$(dirname "$faulty_mriqc_file")" ]; then
    echo "Directory $(dirname "$faulty_mriqc_file") does not exist."
fi

# Initialize a flag to check if all conditions are met
all_conditions_met=true


# Iterate through all sub-directories
for subject_dir in "$subjects_dir"/*; do
    if [ -d "$subject_dir" ]; then
        subject_name=$(basename "$subject_dir")
        # Extract the first 19 characters from the subject name
        subject_id="${subject_name:0:19}"
	#echo $subject_id
        # Add debugging output
        #echo "Subject Directory: $subjects_dir/$subject_id"
        #echo "T1w File: $subjects_dir/${subject_id}_ses-baselineYear1Arm1_T1w.html"
        #echo "Bold File: $subjects_dir/${subject_id}_ses-baselineYear1Arm1_task-rest_bold.html"

        # Check if all three conditions are met for this subject
#        if [ -d "$subjects_dir/$subject_id" ]; then
 #          echo "condition 1 met"
  #      fi
   #     if [ -f "$subjects_dir/${subject_id}_ses-baselineYear1Arm1_T1w.html" ]; then
    #       echo "condition 2 met"
     #   fi
      #  if [ -f "$subjects_dir/${subject_id}_ses-baselineYear1Arm1_task-rest_bold.html" ]; then
       #    echo "condition 3 met"
        #fi
        #if [[ (-d "$subjects_dir/$subject_id") && (-f "$subjects_dir/${subject_id}_ses-baselineYear1Arm1_T1w.html") ]]; then
            # All conditions are met, append this subject to the non-faulty subjects file
         #   echo "conditions 1 and 2 met for $subject_id"
        #fi
        if [[ -d "$subjects_dir/$subject_id" && -f "$subjects_dir/${subject_id}_ses-baselineYear1Arm1_T1w.html" && -f "$subjects_dir/${subject_id}_ses-baselineYear1Arm1_task-rest_bold.html" ]]; then
            # All conditions are met, append this subject to the non-faulty subjects file
            echo "All conditions met for $subject_id"
            echo $subject_id >> "$non_faulty_mriqc_file"
        else
            # At least one condition is not met, append this subject to the faulty subjects file
            echo "Conditions not met for $subject_id"
            echo $subject_id >> "$faulty_mriqc_file"
            # Set the flag to false
            all_conditions_met=false
        fi
    fi
done

# Check if the files were created
if [ -f "$non_faulty_mriqc_file" ]; then
    echo "Non-faulty MRIQC file created at $non_faulty_mriqc_file."
else
    echo "Non-faulty MRIQC file was not created."
fi

if [ -f "$faulty_mriqc_file" ]; then
    echo "Faulty MRIQC file created at $faulty_mriqc_file."
else
    echo "Faulty MRIQC file was not created."
fi

sed -i 's/sub-NDAR//' "$non_faulty_mriqc_file"
sed -i 's/sub-NDAR//' "$faulty_mriqc_file"

#run the python script to write to the database.txt file
#python3 python_status.py
