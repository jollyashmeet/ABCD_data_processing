#!/bin/bash
#August 2023, Ashmeet Jolly, FinnBrain Neurimaging Lab
#script for counting the number of subjects that are actually in the image03 folder
# Go to the directory containing the subject files

#cd "/scratch/project_2001640/ABCD_fMRI/G032/BIDS/derivatives/fmriprep" || exit 1
cd "/scratch/project_2001640/ABCD_fMRI/G010_download/image03" || exit 1
#cd "/scratch/project_2001640/ABCD_fMRI/G010/BIDS/derivatives/fmriprep_allas" || exit 1


# Create an associative array to store subject IDs and their counts
declare -A subject_counts

# Iterate through the files in the directory
for file in *; do
    # Extract the first 15 characters from the filename as the subject ID
    subject_id="${file:0:15}"
    
    # Increment the count for the subject ID in the associative array
    ((subject_counts["$subject_id"]++))
done

# Count the number of unique subject IDs
unique_subjects=0
for count in "${subject_counts[@]}"; do
    if ((count > 0)); then
        ((unique_subjects++))
    fi
done

# Print the result
echo "Number of unique subjects: $unique_subjects"
