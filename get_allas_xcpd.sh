#!/bin/bash
site="S020"
# Make a list of objects and save it
# fmriprep
a-list 2001640-puhti-SCRATCH/ABCD_fMRI/${site}/xcpd_36P_noncifti > object_list_${site}_xcpd_noncifti

# Use the list in a for loop
while read -r ob; do
  #only process files with a .tar extension
  if [[ "$ob" == *.tar ]]; then

      # Extract the subject name from the object path
    subject_id=$(basename "$ob" | cut -d. -f1)  # Remove file extension
    subject_name="${subject_id}"
  
  # Define the local path where the subject will be downloaded
    local_path="/scratch/project_2001640/ABCD_fMRI/${site}/test/${subject_name}"
  
  # Check if the subject has already been downloaded
    if [ -e "$local_path" ]; then
      echo "Subject $subject_name already downloaded. Skipping."
    else
      echo "Downloading $subject_name..."
      a-get "$ob"
    fi
  else
    echo "skipping non-tar file: $ob"
  fi
done < object_list_${site}_xcpd_noncifti

# Remove the object list
rm object_list_${site}_xcpd_noncifti


