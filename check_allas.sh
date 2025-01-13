#!/bin/bash
#script to put preprocessed data into allas
#October, 2023
#Jolly, FinnBrain Neuroimaging Lab

#to check if the objects that should be in allas exist
#module load allas

site='P043'
#a-list 2001640-puhti-SCRATCH/ABCD_fMRI/${site}/xcpd_36P_cifti > /scratch/project_2001640/ABCD_fMRI/csc_fmri/scripts/downcmd_txt_files/${site}_alist_xcpd_36P_cifti.txt
a-list 2001640-puhti-SCRATCH/ABCD_fMRI/${site}/xcpd_36P_noncifti > /scratch/project_2001640/ABCD_fMRI/csc_fmri/scripts/downcmd_txt_files/${site}_alist_xcpd_36P_noncifti.txt
#a-list 2001640-puhti-SCRATCH/ABCD_fMRI/${site}/mriqc > /scratch/project_2001640/ABCD_fMRI/csc_fmri/scripts/downcmd_txt_files/${site}_alist_mriqc.txt
#a-list 2001640-puhti-SCRATCH/ABCD_fMRI/${site}/fmriprep > /scratch/project_2001640/ABCD_fMRI/csc_fmri/scripts/downcmd_txt_files/${site}_alist_fmriprep.txt

#for xcpd_36P_cifti
# Path to the text file with full paths
#alist_file="/scratch/project_2001640/ABCD_fMRI/csc_fmri/scripts/downcmd_txt_files/${site}_alist_xcpd_36P_cifti.txt"

#making sure that the fmriprep file has only unique subjects
#sort /scratch/project_2001640/ABCD_fMRI/csc_fmri/scripts/downcmd_txt_files/${site}_complete_fmriprep.txt | uniq > /scratch/project_2001640/ABCD_fMRI/csc_fmri/scripts/downcmd_txt_files/${site}_complete_fmriprep_uniq.txt


# Path to the text file with subject IDs (without sub-NDAR prefix)
#comp_fmriprep_file="/scratch/project_2001640/ABCD_fMRI/csc_fmri/scripts/downcmd_txt_files/${site}_complete_fmriprep_uniq.txt"
#echo "no. of subjects in the site to be processed:" $(wc -l /scratch/project_2001640/ABCD_fMRI/csc_fmri/scripts/downcmd_txt_files/${site}_complete_fmriprep_uniq.txt)

# Extract unique subjects from the file with paths
#unique_subjects_from_alist=$(awk -F/ '/\.tar$/ {sub(/\.tar$/, "", $NF); print $NF}' "$alist_file" | cut -d_ -f2 | sort -u)

#echo  "unique subjects in a-list:"    $unique_subjects_from_alist
#num_sub_in_alist=$(echo $unique_subjects_from_alist | wc -w)
#echo "number of unique subjects in a-list:"
#echo $num_sub_in_alist

# Extract subjects from the file with IDs
#subjects_from_ids=$(awk '{print "sub-NDAR"$1}' "$comp_fmriprep_file")
#echo "subjects extracted from complete fmriprep:"   $subjects_from_ids
#num_sub_from_ids=$(echo $subjects_from_ids | wc -w)
#echo "number of NDAR$subjects extracted from site file:"
#echo $num_sub_from_ids

# Find missing subjects
#missing_subjects=$(comm -13 <(echo "$unique_subjects_from_alist" | sort) <(echo "$subjects_from_ids" | sort))

# Count the number of missing subjects
#num_missing_subjects=$(echo "$missing_subjects" | wc -l)

# Print the missing subjects and count
#if [ "$num_missing_subjects" -eq 0 ]; then
 # echo "No subjects are missing."
#else
 # echo "Missing subjects:"
  #echo "$missing_subjects"
  #echo "Number of missing subjects: $num_missing_subjects"
#fi

###to delete the subjects in xcpd_cifti that are already backed up in allas

# Main directory where the subject directories are located
#main_directory="/scratch/project_2001640/ABCD_fMRI/${site}/BIDS/derivatives/xcpd_cifti"

# Loop through each unique subject from the alist
#for subject in $unique_subjects_from_alist; do
    # Define the subdirectory path
 #   subdirectory="${main_directory}/${subject}"
  #  sub_html1="${main_directory}/${subject}.html"
   # sub_html2="${main_directory}/${subject}_ses-baselineYear1Arm1_executive_summary.html"
    
    # Check if the subdirectory exists before removing
    #if [ -d "$subdirectory" ]; then
     #   echo "Removing directory: $subdirectory"
      #  rm -r "$subdirectory"
    #else
     #   echo "Directory not found: $subdirectory"
    #fi

    # Check and remove sub_html1 if it exists
    #if [ -f "$sub_html1" ]; then
     #   echo "Removing html file: $sub_html1"
      #  rm -f "$sub_html1"
    #fi

    # Check and remove sub_html2 if it exists
    #if [ -f "$sub_html2" ]; then
     #   echo "Removing html file: $sub_html2"
      #  rm -f "$sub_html2"
    #fi
#done


#for xcpd_36P_noncifti
# Path to the text file with full paths
alist_file="/scratch/project_2001640/ABCD_fMRI/csc_fmri/scripts/downcmd_txt_files/${site}_alist_xcpd_36P_noncifti.txt"

#making sure that the fmriprep file has only unique subjects
sort /scratch/project_2001640/ABCD_fMRI/csc_fmri/scripts/downcmd_txt_files/${site}_complete_fmriprep.txt | uniq > /scratch/project_2001640/ABCD_fMRI/csc_fmri/scripts/downcmd_txt_files/${site}_complete_fmriprep_uniq.txt

# Path to the text file with subject IDs (without sub-NDAR prefix)
comp_fmriprep_file="/scratch/project_2001640/ABCD_fMRI/csc_fmri/scripts/downcmd_txt_files/${site}_complete_fmriprep_uniq.txt"
echo "no. of subjects in the site to be processed:" $(wc -l /scratch/project_2001640/ABCD_fMRI/csc_fmri/scripts/downcmd_txt_files/${site}_complete_fmriprep_uniq.txt)

# Extract unique subjects from the file with paths
unique_subjects_from_alist=$(awk -F/ '/\.tar$/ {sub(/\.tar$/, "", $NF); print $NF}' "$alist_file" | cut -d_ -f2 | sort -u)

echo  "unique subjects in a-list:"    $unique_subjects_from_alist
num_sub_in_alist=$(echo $unique_subjects_from_alist | wc -w)
echo "number of unique subjects in a-list:"
echo $num_sub_in_alist

# Extract subjects from the file with IDs
subjects_from_ids=$(awk '{print "sub-NDAR"$1}' "$comp_fmriprep_file")
echo "subjects extracted from site:"   $subjects_from_ids
num_sub_from_ids=$(echo $subjects_from_ids | wc -w)
echo "number of NDAR$subjects extracted from site file:"
echo $num_sub_from_ids

# Find missing subjects
missing_subjects=$(comm -13 <(echo "$unique_subjects_from_alist" | sort) <(echo "$subjects_from_ids" | sort))

# Count the number of missing subjects
num_missing_subjects=$(echo "$missing_subjects" | wc -l)

# Print the missing subjects and count
if [ "$num_missing_subjects" -eq 0 ]; then
  echo "No subjects are missing."
else
  echo "Missing subjects:"
  echo "$missing_subjects"
  echo "Number of missing subjects: $num_missing_subjects"
fi

###to delete the subjects in xcpd_noncifti that are already backed up in allas

# Main directory where the subject directories are located
#main_directory="/scratch/project_2001640/ABCD_fMRI/${site}/BIDS/derivatives/xcpd_noncifti"

# Loop through each unique subject from the alist
#for subject in $unique_subjects_from_alist; do
    # Define the subdirectory path
 #   subdirectory="${main_directory}/${subject}"
  #  sub_html1="${main_directory}/${subject}.html"
   # sub_html2="${main_directory}/${subject}_ses-baselineYear1Arm1_executive_summary.html"
    
    # Check if the subdirectory exists before removing
    #if [ -d "$subdirectory" ]; then
     #   echo "Removing directory: $subdirectory"
      #  rm -r "$subdirectory"
    #else
     #   echo "Directory not found: $subdirectory"
    #fi

    # Check and remove sub_html1 if it exists
    #if [ -f "$sub_html1" ]; then
     #   echo "Removing html file: $sub_html1"
      #  rm -f "$sub_html1"
    #fi

    # Check and remove sub_html2 if it exists
    #if [ -f "$sub_html2" ]; then
     #   echo "Removing html file: $sub_html2"
      #  rm -f "$sub_html2"
    #fi
#done


#for mriqc

# Path to the text file with full paths
#alist_file="/scratch/project_2001640/ABCD_fMRI/csc_fmri/scripts/downcmd_txt_files/${site}_alist_mriqc.txt"

# Path to the text file with subject IDs (without sub-NDAR prefix)
#site_file="/scratch/project_2001640/ABCD_fMRI/csc_fmri/scripts/downcmd_txt_files/${site}_final_data.txt"
#echo "no. of subjects in the site to be processed:" $(wc -l /scratch/project_2001640/ABCD_fMRI/csc_fmri/scripts/downcmd_txt_files/${site}_final_data.txt)

# Extract unique subjects from the file with paths
#unique_subjects_from_alist=$(awk -F/ '{sub(/\.tar$/, "", $5); print $5}' "$alist_file" | cut -d_ -f2 | sort -u)
#echo  "unique subjects in a-list:"    $unique_subjects_from_alist
#num_sub_in_alist=$(echo $unique_subjects_from_alist | wc -w)
#echo "number of unique subjects in a-list:"
#echo $num_sub_in_alist

# Extract subjects from the file with IDs
#subjects_from_ids=$(awk '{print "sub-NDAR"$1}' "$site_file")
#echo "subjects extracted from site:"   $subjects_from_ids
#num_sub_from_ids=$(echo $subjects_from_ids | wc -w)
#echo "number of NDAR$subjects extracted from site file:"
#echo $num_sub_from_ids

# Find missing subjects
#missing_subjects=$(comm -13 <(echo "$unique_subjects_from_alist" | sort) <(echo "$subjects_from_ids" | sort))

# Count the number of missing subjects
#num_missing_subjects=$(echo "$missing_subjects" | wc -l)

# Print the missing subjects and count
#if [ "$num_missing_subjects" -eq 0 ]; then
 # echo "No subjects are missing."
#else
 # echo "Missing subjects:"
  #echo "$missing_subjects"
  #echo "Number of missing subjects: $num_missing_subjects"
#fi

#for fmriprep

# Path to the text file with full paths
#alist_file="/scratch/project_2001640/ABCD_fMRI/csc_fmri/scripts/downcmd_txt_files/${site}_alist_fmriprep.txt"

# Path to the text file with subject IDs (without sub-NDAR prefix)
#site_file="/scratch/project_2001640/ABCD_fMRI/csc_fmri/scripts/downcmd_txt_files/${site}_final_data.txt"
#echo "no. of subjects in the site to be processed:" $(wc -l /scratch/project_2001640/ABCD_fMRI/csc_fmri/scripts/downcmd_txt_files/${site}_final_data.txt)

# Extract unique subjects from the file with paths

#for when you have not extracted from the output folder
#??? check if the following command works ##it works
#unique_subjects_from_alist=$(awk -F/ '{gsub(/\.tar$/, "", $NF); if ($NF ~ /^sub-NDAR/ && $NF !~ /_output$/) print $NF}' "$alist_file" | sort -u)

#for when you have extracted from the output folder
#unique_subjects_from_alist=$(awk -F/ '{sub(/\.tar$|\.html$/, "", $5); if ($5 ~ /^sub-NDAR/ && $5 !~ /_output$/) print $5}' "$alist_file" | sort -u)

#echo "unique subjects in a-list:"   $unique_subjects_from_alist
#num_sub_in_alist=$(echo $unique_subjects_from_alist | wc -w)
#echo "number of unique subjects in a-list:"
#echo $num_sub_in_alist

# Extract subjects from the file with IDs
#subjects_from_ids=$(awk '{print "sub-NDAR"$1}' "$site_file")
#echo "subjects extracted from site:"   $subjects_from_ids
#num_sub_from_ids=$(echo $subjects_from_ids | wc -w)
#echo "number of NDAR$subjects extracted from site file:"
#echo $num_sub_from_ids

# Find missing subjects
#missing_subjects=$(comm -13 <(echo "$unique_subjects_from_alist" | sort) <(echo "$subjects_from_ids" | sort))

# Count the number of missing subjects
#num_missing_subjects=$(echo "$missing_subjects" | wc -l)

# Print the missing subjects and count
#if [ "$num_missing_subjects" -eq 0 ]; then
 # echo "No subjects are missing."
#else
 # echo "Missing subjects:"
  #echo "$missing_subjects"
  #echo "Number of missing subjects: $num_missing_subjects"
#fi

###to delete the subjects that are already backed up in allas

#for fmriprep


# Main directory where the subject directories are located
#main_directory="/scratch/project_2001640/ABCD_fMRI/${site}/BIDS/derivatives/fmriprep"

# Loop through each unique subject from the alist
#for subject in $unique_subjects_from_alist; do
    # Define the subdirectory path
 #   subdirectory="${main_directory}/${subject}_output"

    # Check if the subdirectory exists before removing
  #  if [ -d "$subdirectory" ]; then
   #     echo "Removing directory: $subdirectory"
    #    rm -r "$subdirectory"
    #else
     #   echo "Directory not found: $subdirectory"
    #fi
#done

