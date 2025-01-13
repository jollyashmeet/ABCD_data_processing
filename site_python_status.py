#script that will be integrated into each status script that will write the statuses to the database.txt file for each site
#Jolly, FinnBrain Neuroimaging Lab
#August, 2023


#!/usr/bin/env python

#data downloading status
import os
import sys

# Define the site name
#G010, G087, G031, G075, G032, S090, S086, S065, S013, S076, S022, S042, S053, S020, S012, S014, S011, S021, P064, P023, P043
site = "P043"

# Create a dictionary to store the status for each subject
subject_status = {}

# Create a function to add status to the corresponding column
def write_database(column_index):
    if column_index < 1:
        raise Exception("The column index cannot be smaller than 1")
    # Read the existing content of the output text file
    with open(f"/scratch/project_2001640/ABCD_fMRI/csc_fmri/{site}_database.txt", "r") as f:
        lines = f.readlines()

    # Update the specified column based on subject status
    for i, line in enumerate(lines[1:], start=1):  # Start from the second line (skip header)
        columns = line.strip().split("\t")  # Split line into columns
        subject_id = columns[0]  # Get the subject ID from the first column
        status = subject_status.get(subject_id, "N/A")
        columns[column_index] = status  # Update the specified column with status
        lines[i] = "\t".join(columns) + "\n"  # Update the line with new columns

    # Write the updated lines back to the output text file
    with open(f"/scratch/project_2001640/ABCD_fMRI/csc_fmri/{site}_database.txt", "w") as f:
        f.writelines(lines)

all_subjects=None
# Loop through each site
for site in [site]:
    # Check if error_subjects.txt file exists
    if os.path.exists(f"/scratch/project_2001640/ABCD_fMRI/csc_fmri/scripts/downcmd_txt_files/{site}_error_download.txt"):
        with open(f"/scratch/project_2001640/ABCD_fMRI/csc_fmri/scripts/downcmd_txt_files/{site}_error_download.txt", "r") as f:
         error_subjects = [line.strip() for line in f.readlines()]
    else:
         error_subjects = []

    # Read the complete subjects list from the file
    with open(f"/scratch/project_2001640/ABCD_fMRI/csc_fmri/scripts/downcmd_txt_files/{site}_complete_download.txt", "r") as f:
        complete_subjects = [line.strip() for line in f.readlines()]

    # Combine the two lists to get all subjects
    site_subjects = error_subjects + complete_subjects
    if all_subjects is None:
       all_subjects = site_subjects
    else:
       all_subjects += site_subjects
       #print("all_subjects:", all_subjects)
   # Create a dictionary to store the status for each subject
    subject_status_site = {subject: "ERROR" if subject in error_subjects else "Success" for subject in site_subjects}

     # Merge the subject statuses for this site into the overall subject_status dictionary
    subject_status.update(subject_status_site)
#print(subject_status)
#sys.exit(0)

write_database(1)

#data sufficiency status: t1 and rs-fmri

# Create a dictionary to store the status for each subject
subject_status = {}

all_subjects=None
# Loop through each site
for site in [site]:
    # Check if faulty_subjects.txt file exists
    if os.path.exists(f"/scratch/project_2001640/ABCD_fMRI/csc_fmri/scripts/downcmd_txt_files/{site}_missing_t1.txt"):
        with open(f"/scratch/project_2001640/ABCD_fMRI/csc_fmri/scripts/downcmd_txt_files/{site}_missing_t1.txt", "r") as f:
         missing_t1_subjects = [line.strip() for line in f.readlines() if line.strip() != '']
    else:
         missing_t1_subjects = []

    if os.path.exists(f"/scratch/project_2001640/ABCD_fMRI/csc_fmri/scripts/downcmd_txt_files/{site}_missing_rsfmri.txt"):
        with open(f"/scratch/project_2001640/ABCD_fMRI/csc_fmri/scripts/downcmd_txt_files/{site}_missing_rsfmri.txt", "r") as f:
         missing_rs_subjects = [line.strip() for line in f.readlines() if line.strip() != '']
    else:
         missing_rs_subjects = []

    if os.path.exists(f"/scratch/project_2001640/ABCD_fMRI/csc_fmri/scripts/downcmd_txt_files/{site}_missing_both.txt"):
        with open(f"/scratch/project_2001640/ABCD_fMRI/csc_fmri/scripts/downcmd_txt_files/{site}_missing_both.txt", "r") as f:
         missing_both_subjects = [line.strip() for line in f.readlines() if line.strip() != '']
    else:
         missing_both_subjects = []


    # Check if non_faulty_subjects.txt file exists
    if os.path.exists(f"/scratch/project_2001640/ABCD_fMRI/csc_fmri/scripts/downcmd_txt_files/{site}_non_faulty_subs.txt"):
        with open(f"/scratch/project_2001640/ABCD_fMRI/csc_fmri/scripts/downcmd_txt_files/{site}_non_faulty_subs.txt", "r") as f:
         non_faulty_subs = [line.strip() for line in f.readlines() if line.strip() != '']  # Filter out empty lines
    else:
         non_faulty_subs = []

    #writing error codes: error 1.1 = missing t1, error 1.2 = missing rs. error 1.3 = missing both

    # Combine the two lists to get all subjects
    site_subjects = missing_t1_subjects + missing_rs_subjects + missing_both_subjects + non_faulty_subs
    if all_subjects is None:
        all_subjects = site_subjects
    else:
        all_subjects += site_subjects
    #print("missing_t1_subjects:", missing_t1_subjects)
    #print("missing_rs_subjects:", missing_rs_subjects)
    #print("all_subjects:", all_subjects)

  # Create a dictionary to store the status for each subject
    subject_status_site = {subject: "ERROR(1.1)" if subject in missing_t1_subjects else "ERROR(1.2)" if subject in missing_rs_subjects else "ERROR(1.3)" if subject in missing_both_subjects else "Success" for subject in site_subjects}

 # Merge the subject statuses for this site into the overall subject_status dictionary
    subject_status.update(subject_status_site)

#subject_status = {subject:  "ERROR(1.2)" if subject in missing_rs_subjects else "SUCCESS" for subject in all_subjects}
#print("subject_status:", subject_status)

write_database(2)


#dcm2bids status

# Create a dictionary to store the status for each subject
subject_status = {}

all_subjects=None
#check if incomplete dcm2bids exists and then read the sub list from the file
for site in [site]:
    if os.path.exists(f"/scratch/project_2001640/ABCD_fMRI/csc_fmri/scripts/downcmd_txt_files/{site}_dcm2bids_incomplete_file.txt"):
        with open(f"/scratch/project_2001640/ABCD_fMRI/csc_fmri/scripts/downcmd_txt_files/{site}_dcm2bids_incomplete_file.txt", "r") as f:
         dcm2bids_incomp_subjects = [line.strip() for line in f.readlines()]
    else:
         dcm2bids_incomp_subjects = []

      #check if complete dcm2bids exists and then read the sub list from file
    if os.path.exists(f"/scratch/project_2001640/ABCD_fMRI/csc_fmri/scripts/downcmd_txt_files/{site}_dcm2bids_complete_file.txt"):
        with open(f"/scratch/project_2001640/ABCD_fMRI/csc_fmri/scripts/downcmd_txt_files/{site}_dcm2bids_complete_file.txt", "r") as f:
         dcm2bids_comp_subjects = [line.strip() for line in f.readlines()]
    else:
         dcm2bids_comp_subjects = []

       # Combine the two lists to get all subjects
    site_subjects = dcm2bids_incomp_subjects + dcm2bids_comp_subjects
#    print(site_subjects)
#    if all_subjects is None:
 #       all_subjects = site_subjects
  #  else:
   #     all_subjects += site_subjects

      # Create a dictionary to store the status for each subject
    subject_status_site = {subject: "ERROR" if subject in dcm2bids_incomp_subjects else "Success" for subject in site_subjects}
#    print(subject_status)
       # Merge the subject statuses for this site into the overall subject_status dictionary
    subject_status.update(subject_status_site)

write_database(3)


#mriqc status

# Create a dictionary to store the status for each subject
subject_status = {}

#all_subjects=None
#check if faulty mriqc file exists and then read the sub list from the file
for site in [site]:
    if os.path.exists(f"/scratch/project_2001640/ABCD_fMRI/csc_fmri/scripts/downcmd_txt_files/{site}_faulty_mriqc_file.txt"):
        with open(f"/scratch/project_2001640/ABCD_fMRI/csc_fmri/scripts/downcmd_txt_files/{site}_faulty_mriqc_file.txt", "r") as f:
         faulty_mriqc_subjects = [line.strip() for line in f.readlines()]
    else:
         faulty_mriqc_subjects = []

#check if complete mriqc exists and then read the sub list from file
    if os.path.exists(f"/scratch/project_2001640/ABCD_fMRI/csc_fmri/scripts/downcmd_txt_files/{site}_non_faulty_mriqc.txt"):
        with open(f"/scratch/project_2001640/ABCD_fMRI/csc_fmri/scripts/downcmd_txt_files/{site}_non_faulty_mriqc.txt", "r") as f:
         non_faulty_mriqc_subjects = [line.strip() for line in f.readlines()]
    else:
         non_faulty_mriqc_subjects = []

    # Combine the two lists to get all subjects
    site_subjects = faulty_mriqc_subjects + non_faulty_mriqc_subjects
#print('all subjects:', all_subjects)

# Create a dictionary to store the status for each subject
    subject_status_site = {subject: "ERROR" if subject in faulty_mriqc_subjects else "Success" for subject in site_subjects}
    # Merge the subject statuses for this site into the overall subject_status dictionary
    subject_status.update(subject_status_site)

write_database(4)



#fmriprep status

# Create a dictionary to store the status for each subject
subject_status = {}

#check if faulty fmriprep file exists and then read the sub list from the file
for site in [site]:
    if os.path.exists(f"/scratch/project_2001640/ABCD_fMRI/csc_fmri/scripts/downcmd_txt_files/{site}_faulty_fmriprep.txt"):
        with open(f"/scratch/project_2001640/ABCD_fMRI/csc_fmri/scripts/downcmd_txt_files/{site}_faulty_fmriprep.txt", "r") as f:
         faulty_fmriprep_subjects = [line.strip() for line in f.readlines()]
    else:
         faulty_fmriprep_subjects = []

#check if complete fmriprep exists and then read the sub list from file
    if os.path.exists(f"/scratch/project_2001640/ABCD_fMRI/csc_fmri/scripts/downcmd_txt_files/{site}_complete_fmriprep.txt"):
        with open(f"/scratch/project_2001640/ABCD_fMRI/csc_fmri/scripts/downcmd_txt_files/{site}_complete_fmriprep.txt", "r") as f:
         non_faulty_fmriprep_subjects = [line.strip() for line in f.readlines()]
    else:
         non_faulty_fmriprep_subjects = []

# Combine the two lists to get all subjects
    site_subjects = faulty_fmriprep_subjects + non_faulty_fmriprep_subjects
#print('all subjects:', all_subjects)

# Create a dictionary to store the status for each subject
    subject_status_site = {subject: "ERROR" if subject in faulty_fmriprep_subjects else "Success" for subject in site_subjects}

    # Merge the subject statuses for this site into the overall subject_status dictionary
    subject_status.update(subject_status_site)

write_database(5)




