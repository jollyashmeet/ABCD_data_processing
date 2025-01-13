#!/bin/bash
#July 6th, 2023
#Jolly
#to check which subjects not properly preprocessed and removing them to preprocess again

site="P023"
#module load python-data
parent_dir="/scratch/project_2001640/ABCD_fMRI/${site}_check/BIDS/derivatives/fmriprep"

date_run=$(/usr/bin/date '+Year+%Y_Month%m_Day%d_H%H_M%M_S%S') #record the date of run
# Go to the parent directory
cd "$parent_dir" || exit 1

#this is incase you want to extract the files and folders from the _output folders, + when u have to download locally for QC
#extracting the contents of the created subject_dir for each individual subject
# Find sub-directories with "_output" suffix
#for output_dir in "$parent_dir"/*_output; do
 #   if [ -d "$output_dir" ]; then
        # Get the name of the "_output" sub-directory
  #      output_name=$(basename "$output_dir")
   #     echo output_name
        # Move the contents of the "_output" sub-directory to the parent directory
    #    mv -u "$output_dir"/* "$parent_dir"   #this just moves the sub-dir and .html file but not logs and sourcedata of that subject for some reason

        # Remove the "_output" sub-directory
     #   rmdir "$output_dir"   #the directory is not removed because the sub-directories are not empty

      #  echo "Extracted contents from '$output_name' and removed '$output_name'"   #hence this does not print
    #fi
#done

# Create the result file
incorrect_counts="Subject ID\tNo. of anat\tNo. of func\n"
correct_counts="Subject ID\tNo. of anat\tNo. of func\n"

#this is in case you didn't have to make an output folder in the first place because of freesurfer
# Iterate through each sub-directory in fmriprep
#for fmriprep_dir in fmriprep/*/; do
    # Get the sub-directory name
 #   sub_dir=$(basename "$fmriprep_dir")

    # Check if the sub-directory has 'ses' directory
  #  ses_dir="${fmriprep_dir}ses-baselineYear1Arm1"
   # if [ -d "$ses_dir" ]; then
        # Count the number of files in 'anat' and 'func' directories
    #    anat_count=$(find "$ses_dir/anat" -type f | wc -l)
     #   func_count=$(find "$ses_dir/func" -type f | wc -l)
        
      #  echo "Subject: $sub_dir, anat_count: $anat_count, func_count: $func_count"
        
        # Check if counts don't match expected values
       # if [ "$anat_count" -ne 66 ] || [ "$func_count" -ne 46 ]; then
        #    counts+="$sub_dir\t$anat_count\t$func_count\n"
        #else
         #   correct_counts+="$sub_dir\t$anat_count\t$func_count\n"
        #fi
    #else
         # If 'ses' directory is missing, append only the sub-directory name to the counts variable
    #    counts+="$sub_dir\t$anat_count\t$func_count\n"
    #fi
#done


#this is again if you had the output folder
# Iterate through each sub-directory in fmriprep
#for fmriprep_dir in fmriprep/*/; do
    # Get the sub-directory name
 #   sub_dir=$(basename "$fmriprep_dir")
    
    # Check if the sub-directory starts with "sub-" and does not end with "_output"
  #  if [[ "$sub_dir" == sub-* && "$sub_dir" != *_output ]]; then
        # Check if the sub-directory has 'ses' directory
   #     ses_dir="${fmriprep_dir}ses-baselineYear1Arm1"
    #    if [ -d "$ses_dir" ]; then
            # Count the number of files in 'anat' and 'func' directories
     #       anat_count=$(find "$ses_dir/anat" -type f | wc -l)
      #      func_count=$(find "$ses_dir/func" -type f | wc -l)

       #     echo "Subject: $sub_dir, anat_count: $anat_count, func_count: $func_count"

            # Check if counts don't match expected values
        #    if [ "$anat_count" -ne 66 ] || [ "$func_count" -ne 46 ]; then
         #       incorrect_counts+="$sub_dir\t$anat_count\t$func_count\n"
          #  else
           #     correct_counts+="$sub_dir\t$anat_count\t$func_count\n"
            #fi
        #else
            # If 'ses' directory is missing, append only the sub-directory name to the counts variable
         #   incorrect_counts+="$sub_dir\t$anat_count\t$func_count\n"
        #fi
    #else
        # This sub-directory does not meet the criteria, you can skip it
     #   echo "Skipping invalid sub-directory: $sub_dir"
    #fi
#done

#this is in case you don't extract folders and files from the output folder
# Iterate through each sub-directory ending with '_output'
for sub_output_dir in *_output/; do
    # Check if the subdirectory has an fmriprep directory
    fmriprep_dir="${sub_output_dir}"

    # Check if the fmriprep directory exists
    if [ -d "$fmriprep_dir" ]; then
        # Iterate through the fmriprep directories
        for fmriprep_sub_dir in "${fmriprep_dir}"/*/; do
            # Get the sub-directory name
            sub_dir=$(basename "$fmriprep_sub_dir")

            # Check if the sub-directory starts with "sub-"
            if [[ "$sub_dir" == sub-* ]]; then
                # Check if the sub-directory has 'ses' directory
                ses_dir="${fmriprep_sub_dir}ses-baselineYear1Arm1"
                if [ -d "$ses_dir" ]; then
                    # Count the number of files in 'anat' and 'func' directories
                    anat_count=$(find "$ses_dir/anat" -type f | wc -l)
                    func_count=$(find "$ses_dir/func" -type f | wc -l)

                    echo "Subject: $sub_dir, anat_count: $anat_count, func_count: $func_count"

                    # Check if counts don't match expected values
                    if [ "$anat_count" -ne 66 ] || [ "$func_count" -ne 46 ]; then
                        incorrect_counts+="$sub_dir\t$anat_count\t$func_count\n"
                    else
                        correct_counts+="$sub_dir\t$anat_count\t$func_count\n"
                    fi
                else
                    # If 'ses' directory is missing, append only the sub-directory name to the counts variable
                    incorrect_counts+="$sub_dir\t$anat_count\t$func_count\n"
                fi
            else
                # This sub-directory does not meet the criteria, you can skip it
                echo "Skipping invalid sub-directory: $sub_dir"
            fi
        done
    else
        echo "No fmriprep directory found in $sub_output_dir"
    fi
done


# Write the counts variable to the result file
echo -e "$incorrect_counts" >> "/scratch/project_2001640/ABCD_fMRI/csc_fmri/scripts/downcmd_txt_files/${date_run}_fmriprep_counts_tst.txt"
echo -e "$incorrect_counts" >> "/scratch/project_2001640/ABCD_fMRI/csc_fmri/scripts/downcmd_txt_files/${site}_faulty_fmriprep_tst.txt"
echo -e "$correct_counts" >> "/scratch/project_2001640/ABCD_fMRI/csc_fmri/scripts/downcmd_txt_files/${site}_complete_fmriprep_tst.txt"
num_entries=$(awk '/^sub-/ && !/_output$/' "/scratch/project_2001640/ABCD_fMRI/csc_fmri/scripts/downcmd_txt_files/${date_run}_fmriprep_counts_tst.txt" | wc -l)
echo "Number of subjects that did not go through fmriprep successfully: $num_entries"
echo "File counts check completed."

######for allas######
#for removing the output directories themselves if faulty. only put the ones that are successful in allas.
# Read the result file and remove the corresponding subdirectories and files in fmriprep
#while IFS=$'\t' read -r sub_dir anat_count func_count; do
   # Skip the header line
 #   if [ "$sub_dir" == "Subject ID" ]; then
  #      continue
   # fi

    #if [ -z "$sub_dir" ] || [ -z "$anat_count" ] || [ -z "$func_count" ]; then
     #   continue  # Skip empty or invalid lines
    #fi
    
    # Debugging lines
    #echo "DEBUG: sub_dir=$sub_dir, anat_count=$anat_count, func_count=$func_count"

    #if [ "$anat_count" != "-" ] && [ "$anat_count" -ne 66 ] || [ "$func_count" != "-" ] && [ "$func_count" -ne 46 ]; then
     #   fmriprep_dir=$parent_dir/${sub_dir}_output
      #  if [ -d "$fmriprep_dir" ]; then
       #     rm -r "$fmriprep_dir"
        #    echo "Removed directory: $fmriprep_dir"
        #fi
    #fi
#done < "/scratch/project_2001640/ABCD_fMRI/csc_fmri/scripts/downcmd_txt_files/${date_run}_fmriprep_counts.txt"

#echo "File and directory removal completed."


# Remove the 'sub-NDAR' string from the beginning of each row in the Subject ID column to make the selection file subject ID uniform for the template
#sed -i 's/^sub-NDAR//' "/scratch/project_2001640/ABCD_fMRI/csc_fmri/scripts/downcmd_txt_files/${date_run}_fmriprep_counts.txt"
#sed -i 's/^sub-NDAR//' "/scratch/project_2001640/ABCD_fMRI/csc_fmri/scripts/downcmd_txt_files/${site}_complete_fmriprep.txt"
#sed -i 's/^sub-NDAR//' "/scratch/project_2001640/ABCD_fMRI/csc_fmri/scripts/downcmd_txt_files/${site}_faulty_fmriprep.txt"

#extracting just the subjects for the python status file
#awk 'NR>1 {print $1}' /scratch/project_2001640/ABCD_fMRI/csc_fmri/scripts/downcmd_txt_files/${site}_complete_fmriprep.txt > /scratch/project_2001640/ABCD_fMRI/csc_fmri/scripts/downcmd_txt_files/temp.txt && mv /scratch/project_2001640/ABCD_fMRI/csc_fmri/scripts/downcmd_txt_files/temp.txt /scratch/project_2001640/ABCD_fMRI/csc_fmri/scripts/downcmd_txt_files/${site}_complete_fmriprep.txt
#awk 'NR>1 {print $1}' /scratch/project_2001640/ABCD_fMRI/csc_fmri/scripts/downcmd_txt_files/${site}_faulty_fmriprep.txt > /scratch/project_2001640/ABCD_fMRI/csc_fmri/scripts/downcmd_txt_files/temp.txt && mv /scratch/project_2001640/ABCD_fMRI/csc_fmri/scripts/downcmd_txt_files/temp.txt /scratch/project_2001640/ABCD_fMRI/csc_fmri/scripts/downcmd_txt_files/${site}_faulty_fmriprep.txt


#run the python script to write to the database.txt file
#python3 /scratch/project_2001640/ABCD_fMRI/csc_fmri/scripts/python_status.py

