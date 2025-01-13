#!/bin/bash
site="P064"
# Make a list of objects and save it
# fmriprep
a-list 2001640-puhti-SCRATCH/ABCD_fMRI/${site}/fmriprep > object_list_${site}_fmriprep

# mriqc
# a-list 2001640-puhti-SCRATCH/ABCD_fMRI/${site}/mriqc > object_list_${site}_mriqc

# Use the list in a for loop
while read -r ob; do
  # Extract the subject name from the object path
  subject_id=$(basename "$ob" | cut -d. -f1)  # Remove file extension
  subject_name="${subject_id}_output"
  
  # Define the local path where the subject will be downloaded
  local_path="/scratch/project_2001640/ABCD_fMRI/${site}/BIDS/derivatives/fmriprep/${subject_name}"
  
  # Check if the subject has already been downloaded
  if [ -e "$local_path" ]; then
    echo "Subject $subject_name already downloaded. Skipping."
  else
    echo "Downloading $subject_name..."
    a-get "$ob"
  fi
done < object_list_${site}_fmriprep

# Remove the object list
rm object_list_${site}_fmriprep

