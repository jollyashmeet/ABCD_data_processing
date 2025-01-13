#!/bin/bash
#script to put preprocessed data into allas
#October, 2023
#Jolly, FinnBrain Neuroimaging Lab

#module load allas

site="P043"


#for mriqc
#bucket_name="2001640-puhti-SCRATCH"
#input_file="/scratch/project_2001640/ABCD_fMRI/site_data/${site}_site.txt"

#while IFS=$'\t' read -ra fields; do
 #   subject_id="${fields[0]}"  # Extract the subject ID from the first field
    # Create directory structure for the subject on the cloud storage
  #  subject_dir="ABCD_fMRI/${site}/mriqc/sub-NDAR$subject_id"
# Use the a-put command to create the directory in the cloud storage
   # a-put sub-NDAR$subject_id/ sub-NDAR$subject_id*_T1w.html sub-NDAR$subject_id*_bold.html -b 2001640-puhti-SCRATCH/ABCD_fMRI/${site}/mriqc -o sub-NDAR$subject_id
#done < "$input_file"


#for fmriprep

#bucket_name="2001640-puhti-SCRATCH"
#input_file="/scratch/project_2001640/ABCD_fMRI/site_data/${site}_site.txt"

#while IFS=$'\t' read -ra fields; do
 #   subject_id="${fields[0]}"  # Extract the subject ID from the first field

    # Create directory structure for the subject on the cloud storage
  #  subject_dir="ABCD_fMRI/${site}/fmriprep/sub-NDAR$subject_id"
# Use the a-put command to create the directory in the cloud storage
###use the following incase you just have output folders in fmriprep
   # a-put sub-NDAR$subject_id*_output/ -b 2001640-puhti-SCRATCH/ABCD_fMRI/${site}/fmriprep -o sub-NDAR$subject_id
####use this if you have extracted from output folders
#    a-put sub-NDAR$subject_id.html -b 2001640-puhti-SCRATCH/ABCD_fMRI/G010/fmriprep -o sub-NDAR$subject_id
#    a-put sub-NDAR$subject_id_output/ -b 2001640-puhti-SCRATCH/ABCD_fMRI/G010/fmriprep -o sub-NDAR$subject_id
#done < "$input_file"


#for xcpd_36P_cifti

#bucket_name="2001640-puhti-SCRATCH"
#input_file="/scratch/project_2001640/ABCD_fMRI/site_data/${site}_site.txt"

#while IFS=$'\t' read -ra fields; do
 #   subject_id="${fields[0]}"  # Extract the subject ID from the first field
    # Create directory structure for the subject on the cloud storage
  #  subject_dir="ABCD_fMRI/${site}/xcpd_36P_cifti/sub-NDAR$subject_id"
# Use the a-put command to create the directory in the cloud storage
   # echo a-put sub-NDAR$subject_id/ sub-NDAR$subject_id.html sub-NDAR$subject_id*_ses-baselineYear1Arm1_executive_summary.html -b 2001640-puhti-SCRATCH/ABCD_fMRI/${site}/xcpd_36P_cifti -o sub-NDAR$subject_id
    #a-put sub-NDAR$subject_id/ sub-NDAR$subject_id.html sub-NDAR$subject_id*_ses-baselineYear1Arm1_executive_summary.html -b 2001640-puhti-SCRATCH/ABCD_fMRI/${site}/xcpd_36P_cifti -o sub-NDAR$subject_id

#done < "$input_file"

#for xcpd_36P_noncifti

bucket_name="2001640-puhti-SCRATCH"
input_file="/scratch/project_2001640/ABCD_fMRI/site_data/${site}_site.txt"

while IFS=$'\t' read -ra fields; do
    subject_id="${fields[0]}"  # Extract the subject ID from the first field
    # Create directory structure for the subject on the cloud storage
    subject_dir="ABCD_fMRI/${site}/xcpd_36P_noncifti/sub-NDAR$subject_id"
# Use the a-put command to create the directory in the cloud storage
    a-put sub-NDAR$subject_id/ sub-NDAR$subject_id.html sub-NDAR$subject_id*_ses-baselineYear1Arm1_executive_summary.html -b 2001640-puhti-SCRATCH/ABCD_fMRI/${site}/xcpd_36P_noncifti -o sub-NDAR$subject_id
done < "$input_file"
