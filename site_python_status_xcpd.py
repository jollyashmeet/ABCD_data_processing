#script that will be integrated into each status script that will write the statuses to the database.txt file for xcpd
#Jolly, FinnBrain Neuroimaging Lab
#April, 2024


#!/usr/bin/env python

#data downloading status
import os
import sys

# Define an array of site names
sites = ["G010", "G087", "S013", "S012", "S042", "S014", "G075", "G031", "G032", "S022", "S053", "S065", "S076", "S086", "S011", "S090", "S021", "S020", "P023", "P043", "P064"]

# Create a dictionary to store the status for each subject
subject_status = {}

#creating a function to add status to the corresponding column
def write_database(column_index):
   if column_index <1:
      raise Exception("The column index cannot be smaller than 1")
   # Read the existing content of the output text file
   with open(f"/scratch/project_2001640/ABCD_fMRI/csc_fmri/{site}_database_xcpd.txt", "r") as f:
       lines = f.readlines()

   # Update the second column based on subject status
   for i, line in enumerate(lines[1:], start=1):  # Start from the second line (skip header)
       columns = line.strip().split("\t")  # Split line into columns
       subject_id = columns[0]  # Get the subject ID from the first column
       status = subject_status.get(subject_id, "N/A")
       columns[column_index] = status  # Update the second column with status
       lines[i] = "\t".join(columns) + "\n"  # Update the line with new columns

   # Write the updated lines back to the output text file
   with open(f"/scratch/project_2001640/ABCD_fMRI/csc_fmri/{site}_database_xcpd.txt", "w") as f:
        f.writelines(lines)

#xcpd_36P_cifti

# Create a dictionary to store the status for each subject
subject_status = {}

all_subjects=None
# Loop through each site
for site in sites:
    # Check if index_error_faulty_subjects.txt file exists
    if os.path.exists(f"/scratch/project_2001640/ABCD_fMRI/csc_fmri/scripts/downcmd_txt_files/{site}_xcpd_cifti_indexERR.txt"):
        with open(f"/scratch/project_2001640/ABCD_fMRI/csc_fmri/scripts/downcmd_txt_files/{site}_xcpd_cifti_indexERR.txt", "r") as f:
         indexERR_subjects = [line.strip() for line in f.readlines() if line.strip() != '']
    else:
         indexERR_subjects = []

    # Check if sql_error_faulty_subjects.txt file exists
    if os.path.exists(f"/scratch/project_2001640/ABCD_fMRI/csc_fmri/scripts/downcmd_txt_files/{site}_xcpd_cifti_sqlERR.txt"):
        with open(f"/scratch/project_2001640/ABCD_fMRI/csc_fmri/scripts/downcmd_txt_files/{site}_xcpd_cifti_sqlERR.txt", "r") as f:
         sqlERR_subjects = [line.strip() for line in f.readlines() if line.strip() != '']
    else:
         sqlERR_subjects = []

    # Check if fnotf_error_faulty_subjects.txt file exists
    if os.path.exists(f"/scratch/project_2001640/ABCD_fMRI/csc_fmri/scripts/downcmd_txt_files/{site}_xcpd_cifti_fnotfERR.txt"):
        with open(f"/scratch/project_2001640/ABCD_fMRI/csc_fmri/scripts/downcmd_txt_files/{site}_xcpd_cifti_fnotfERR.txt", "r") as f:
         fnotfERR_subjects = [line.strip() for line in f.readlines() if line.strip() != '']
    else:
         fnotfERR_subjects = []

    # Check if nospace_error_faulty_subjects.txt file exists
    if os.path.exists(f"/scratch/project_2001640/ABCD_fMRI/csc_fmri/scripts/downcmd_txt_files/{site}_xcpd_cifti_nospaceERR.txt"):
        with open(f"/scratch/project_2001640/ABCD_fMRI/csc_fmri/scripts/downcmd_txt_files/{site}_xcpd_cifti_nospaceERR.txt", "r") as f:
         nospaceERR_subjects = [line.strip() for line in f.readlines() if line.strip() != '']
    else:
         nospaceERR_subjects = []

    # Check if voxel_error_faulty_subjects.txt file exists
    if os.path.exists(f"/scratch/project_2001640/ABCD_fMRI/csc_fmri/scripts/downcmd_txt_files/{site}_xcpd_cifti_voxelERR.txt"):
        with open(f"/scratch/project_2001640/ABCD_fMRI/csc_fmri/scripts/downcmd_txt_files/{site}_xcpd_cifti_voxelERR.txt", "r") as f:
         voxelERR_subjects = [line.strip() for line in f.readlines() if line.strip() != '']
    else:
         voxelERR_subjects = []

    # Check if assertion_error_faulty_subjects.txt file exists
    if os.path.exists(f"/scratch/project_2001640/ABCD_fMRI/csc_fmri/scripts/downcmd_txt_files/{site}_xcpd_cifti_asERR.txt"):
        with open(f"/scratch/project_2001640/ABCD_fMRI/csc_fmri/scripts/downcmd_txt_files/{site}_xcpd_cifti_asERR.txt", "r") as f:
         asERR_subjects = [line.strip() for line in f.readlines() if line.strip() != '']
    else:
         asERR_subjects = []

    # Check if unknown_error_faulty_subjects.txt file exists
    if os.path.exists(f"/scratch/project_2001640/ABCD_fMRI/csc_fmri/scripts/downcmd_txt_files/{site}_xcpd_cifti_unknownERR.txt"):
        with open(f"/scratch/project_2001640/ABCD_fMRI/csc_fmri/scripts/downcmd_txt_files/{site}_xcpd_cifti_unknownERR.txt", "r") as f:
         unknownERR_subjects = [line.strip() for line in f.readlines() if line.strip() != '']
    else:
         unknownERR_subjects = []

    # Check if non_faulty_subjects.txt file exists
    if os.path.exists(f"/scratch/project_2001640/ABCD_fMRI/csc_fmri/scripts/downcmd_txt_files/{site}_non_faulty_xcpd_cifti.txt"):
        with open(f"/scratch/project_2001640/ABCD_fMRI/csc_fmri/scripts/downcmd_txt_files/{site}_non_faulty_xcpd_cifti.txt", "r") as f:
         non_faulty_subs = [line.strip() for line in f.readlines() if line.strip() != '']  # Filter out empty lines
    else:
         non_faulty_subs = []

#writing error codes: Error (1.1) = IndexError: list index out of range, Error (1.2) = sql, Error (1.3) = dataset_description.json file not found, Error (1.4) = no space left on device

    # Combine the two lists to get all subjects
    site_subjects = indexERR_subjects + sqlERR_subjects + fnotfERR_subjects + nospaceERR_subjects + voxelERR_subjects + asERR_subjects + unknownERR_subjects + non_faulty_subs
    if all_subjects is None:
        all_subjects = site_subjects
    else:
        all_subjects += site_subjects

  # Create a dictionary to store the status for each subject
    #subject_status_site = {subject: "Error(1.1)" if subject in indexERR_subjects else "Error(1.2)" if subject in sqlERR_subjects else "Error(1.3)" if subject in fnotfERR_subjects else "Error(1.4)" if subject in nospaceERR_subjects else "Success" for subject in site_subjects}
  # Create a dictionary to store the status for each subject
    subject_status_site = {
        subject: "Success" if subject in non_faulty_subs else "Error(1.1)" if subject in indexERR_subjects else "Error(1.2)" if subject in sqlERR_subjects else "Error(1.3)" if subject in fnotfERR_subjects else "Error(1.4)" if subject in nospaceERR_subjects
 else "Error(1.5)" if subject in voxelERR_subjects else "Error(1.6)" if subject in asERR_subjects else "Error(999)" if subject in unknownERR_subjects else "N/A" for subject in site_subjects}

 # Merge the subject statuses for this site into the overall subject_status dictionary
    subject_status.update(subject_status_site)

write_database(1)


#xcpd_36P_noncifti

# Create a dictionary to store the status for each subject
subject_status = {}

all_subjects=None
# Loop through each site
for site in sites:
    # Check if index_error_faulty_subjects.txt file exists
    if os.path.exists(f"/scratch/project_2001640/ABCD_fMRI/csc_fmri/scripts/downcmd_txt_files/{site}_xcpd_noncifti_indexERR.txt"):
        with open(f"/scratch/project_2001640/ABCD_fMRI/csc_fmri/scripts/downcmd_txt_files/{site}_xcpd_noncifti_indexERR.txt", "r") as f:
         indexERR_subjects = [line.strip() for line in f.readlines() if line.strip() != '']
    else:
         indexERR_subjects = []

    # Check if sql_error_faulty_subjects.txt file exists
    if os.path.exists(f"/scratch/project_2001640/ABCD_fMRI/csc_fmri/scripts/downcmd_txt_files/{site}_xcpd_noncifti_sqlERR.txt"):
        with open(f"/scratch/project_2001640/ABCD_fMRI/csc_fmri/scripts/downcmd_txt_files/{site}_xcpd_noncifti_sqlERR.txt", "r") as f:
         sqlERR_subjects = [line.strip() for line in f.readlines() if line.strip() != '']
    else:
         sqlERR_subjects = []

    # Check if fnotf_error_faulty_subjects.txt file exists
    if os.path.exists(f"/scratch/project_2001640/ABCD_fMRI/csc_fmri/scripts/downcmd_txt_files/{site}_xcpd_noncifti_fnotfERR.txt"):
        with open(f"/scratch/project_2001640/ABCD_fMRI/csc_fmri/scripts/downcmd_txt_files/{site}_xcpd_noncifti_fnotfERR.txt", "r") as f:
         fnotfERR_subjects = [line.strip() for line in f.readlines() if line.strip() != '']
    else:
         fnotfERR_subjects = []

    # Check if nospace_error_faulty_subjects.txt file exists
    if os.path.exists(f"/scratch/project_2001640/ABCD_fMRI/csc_fmri/scripts/downcmd_txt_files/{site}_xcpd_noncifti_nospaceERR.txt"):
        with open(f"/scratch/project_2001640/ABCD_fMRI/csc_fmri/scripts/downcmd_txt_files/{site}_xcpd_noncifti_nospaceERR.txt", "r") as f:
         nospaceERR_subjects = [line.strip() for line in f.readlines() if line.strip() != '']
    else:
         nospaceERR_subjects = []

    # Check if unknown_error_faulty_subjects.txt file exists
    if os.path.exists(f"/scratch/project_2001640/ABCD_fMRI/csc_fmri/scripts/downcmd_txt_files/{site}_xcpd_noncifti_unknownERR.txt"):
        with open(f"/scratch/project_2001640/ABCD_fMRI/csc_fmri/scripts/downcmd_txt_files/{site}_xcpd_noncifti_unknownERR.txt", "r") as f:
         unknownERR_subjects = [line.strip() for line in f.readlines() if line.strip() != '']
    else:
         unknownERR_subjects = []

    # Check if non_faulty_subjects.txt file exists
    if os.path.exists(f"/scratch/project_2001640/ABCD_fMRI/csc_fmri/scripts/downcmd_txt_files/{site}_non_faulty_xcpd_noncifti.txt"):
        with open(f"/scratch/project_2001640/ABCD_fMRI/csc_fmri/scripts/downcmd_txt_files/{site}_non_faulty_xcpd_noncifti.txt", "r") as f:
         non_faulty_subs = [line.strip() for line in f.readlines() if line.strip() != '']  # Filter out empty lines
    else:
         non_faulty_subs = []

#writing error codes: Error (1.1) = IndexError: list index out of range, Error (1.2) = sql, Error (1.3) = dataset_description.json file not found, Error (1.4) = no space left on device. Error (999) = unknown error

    # Combine the two lists to get all subjects
    site_subjects = indexERR_subjects + sqlERR_subjects + fnotfERR_subjects + nospaceERR_subjects + unknownERR_subjects + non_faulty_subs
    if all_subjects is None:
        all_subjects = site_subjects
    else:
        all_subjects += site_subjects

  # Create a dictionary to store the status for each subject
    #subject_status_site = {subject: "Error(1.1)" if subject in indexERR_subjects else "Error(1.2)" if subject in sqlERR_subjects else "Error(1.3)" if subject in fnotfERR_subjects else "Error(1.4)" if subject in nospaceERR_subjects else "Success" for subject in site_subjects}
  # Create a dictionary to store the status for each subject
    subject_status_site = {
        subject: "Success" if subject in non_faulty_subs else "Error(2.1)" if subject in indexERR_subjects else "Error(2.2)" if subject in sqlERR_subjects else "Error(2.3)" if subject in fnotfERR_subjects else "Error(2.4)" if subject in nospaceERR_subjects 
else "Error(999)" if subject in unknownERR_subjects else "N/A" for subject in site_subjects}

 # Merge the subject statuses for this site into the overall subject_status dictionary
    subject_status.update(subject_status_site)

write_database(2)







