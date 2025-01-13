#!/usr/bin/env python3


#data downloading status
import os

# Check if error_subjects.txt file exists
if os.path.exists("/scratch/project_2001640/ABCD_fMRI/csc_fmri/scripts/downcmd_txt_files/G031_error_download.txt"):
    with open("/scratch/project_2001640/ABCD_fMRI/csc_fmri/scripts/downcmd_txt_files/G031_error_download.txt", "r") as f:
        error_subjects = [line.strip() for line in f.readlines()]
else:
    error_subjects = []

# Read the complete subjects list from the file
with open("/scratch/project_2001640/ABCD_fMRI/csc_fmri/scripts/downcmd_txt_files/G031_complete_download.txt", "r") as f:
    complete_subjects = [line.strip() for line in f.readlines()]

# Combine the two lists to get all subjects
all_subjects = error_subjects + complete_subjects

# Create a dictionary to store the status for each subject
subject_status = {subject: "ERROR" if subject in error_subjects else "Success" for subject in all_subjects}


# Read the existing content of the output text file
with open("/scratch/project_2001640/ABCD_fMRI/csc_fmri/G031_database.txt", "r") as f:
    lines = f.readlines()

# Update the second column based on subject status
for i, line in enumerate(lines[1:], start=1):  # Start from the second line (skip header)
    columns = line.strip().split("\t")  # Split line into columns
    subject_id = columns[0]  # Get the subject ID from the first column
    status = subject_status.get(subject_id, "N/A")
    columns[1] = status  # Update the second column with status
    lines[i] = "\t".join(columns) + "\n"  # Update the line with new columns

# Write the updated lines back to the output text file
with open("/scratch/project_2001640/ABCD_fMRI/csc_fmri/G031_database.txt", "w") as f:
    f.writelines(lines)


#data sufficiency
# Check if faulty_subjects.txt file exists
if os.path.exists("/scratch/project_2001640/ABCD_fMRI/csc_fmri/scripts/downcmd_txt_files/G031_missing_t1.txt"):
    with open("/scratch/project_2001640/ABCD_fMRI/csc_fmri/scripts/downcmd_txt_files/G031_missing_t1.txt", "r") as f:
        missing_t1_subjects = [line.strip() for line in f.readlines() if line.strip() != '']
else:
    missing_t1_subjects = []

if os.path.exists("/scratch/project_2001640/ABCD_fMRI/csc_fmri/scripts/downcmd_txt_files/G031_missing_rsfmri.txt"):
    with open("/scratch/project_2001640/ABCD_fMRI/csc_fmri/scripts/downcmd_txt_files/G031_missing_rsfmri.txt", "r") as f:
        missing_rs_subjects = [line.strip() for line in f.readlines() if line.strip() != '']
else:
    missing_rs_subjects = []

if os.path.exists(f"/scratch/project_2001640/ABCD_fMRI/csc_fmri/scripts/downcmd_txt_files/G031_missing_both.txt"):
    with open(f"/scratch/project_2001640/ABCD_fMRI/csc_fmri/scripts/downcmd_txt_files/G031_missing_both.txt", "r") as f:
        missing_both_subjects = [line.strip() for line in f.readlines() if line.strip() != '']
else:
        missing_both_subjects = []

# Check if non_faulty_subjects.txt file exists
if os.path.exists("/scratch/project_2001640/ABCD_fMRI/csc_fmri/scripts/downcmd_txt_files/G031_non_faulty_subs.txt"):
    with open("/scratch/project_2001640/ABCD_fMRI/csc_fmri/scripts/downcmd_txt_files/G031_non_faulty_subs.txt", "r") as f:
        non_faulty_subs = [line.strip() for line in f.readlines() if line.strip() != '']  # Filter out empty lines
else:
    non_faulty_subs = []

# Combine the three lists to get all subjects
all_subjects = missing_t1_subjects + missing_rs_subjects + missing_both_subjects + non_faulty_subs

#writing error codes: error 1.1 = missing t1, error 1.2 = missing rs

#print("missing_t1_subjects:", missing_t1_subjects)
#print("missing_rs_subjects:", missing_rs_subjects)
#print("non_faulty_subs:", non_faulty_subs)

# Create a dictionary to store the status for each subject
subject_status = {subject: "ERROR(1.1)" if subject in missing_t1_subjects else "ERROR(1.2)" if subject in missing_rs_subjects else "ERROR(1.3)" if subject in missing_both_subjects else "Success" for subject in all_subjects}

#subject_status = {subject:  "ERROR(1.2)" if subject in missing_rs_subjects else "SUCCESS" for subject in all_subjects}
#print("subject_status:", subject_status)

# Read the existing content of the output text file
with open("/scratch/project_2001640/ABCD_fMRI/csc_fmri/G031_database.txt", "r") as f:
    lines = f.readlines()

# Update the third column based on subject status
for i, line in enumerate(lines[1:], start=1):  # Start from the second line (skip header)
    columns = line.strip().split("\t")  # Split line into columns
    subject_id = columns[0]  # Get the subject ID from the first column
    status = subject_status.get(subject_id, "N/A")
    columns[2] = status  # Update the third column with status
    lines[i] = "\t".join(columns) + "\n"  # Update the line with new columns

# Write the updated lines back to the output text file
with open("/scratch/project_2001640/ABCD_fMRI/csc_fmri/G031_database.txt", "w") as f:
    f.writelines(lines)

#dcm2bids status

#check if incomplete dcm2bids exists and then read the sub list from the file
if os.path.exists("/scratch/project_2001640/ABCD_fMRI/csc_fmri/scripts/downcmd_txt_files/G031_dcm2bids_incomplete_file.txt"):
    with open("/scratch/project_2001640/ABCD_fMRI/csc_fmri/scripts/downcmd_txt_files/G031_dcm2bids_incomplete_file.txt", "r") as f:
        dcm2bids_incomp_subjects = [line.strip() for line in f.readlines()]
else:
    dcm2bids_incomp_subjects = []

#check if complete dcm2bids exists and then read the sub list from file
if os.path.exists("/scratch/project_2001640/ABCD_fMRI/csc_fmri/scripts/downcmd_txt_files/G031_dcm2bids_complete_file.txt"):
    with open("/scratch/project_2001640/ABCD_fMRI/csc_fmri/scripts/downcmd_txt_files/G031_dcm2bids_complete_file.txt", "r") as f:
        dcm2bids_comp_subjects = [line.strip() for line in f.readlines()]
else:
    dcm2bids_comp_subjects = []

# Combine the two lists to get all subjects
all_subjects = dcm2bids_incomp_subjects + dcm2bids_comp_subjects
#print('all subjects:', all_subjects)

# Create a dictionary to store the status for each subject
subject_status = {subject: "ERROR" if subject in dcm2bids_incomp_subjects else "Success" for subject in all_subjects}


# Read the existing content of the output text file
with open("/scratch/project_2001640/ABCD_fMRI/csc_fmri/G031_database.txt", "r") as f:
    lines = f.readlines()

# Update the fourth column based on subject status
for i, line in enumerate(lines[1:], start=1):  # Start from the second line (skip header)
    columns = line.strip().split("\t")  # Split line into columns
    subject_id = columns[0]  # Get the subject ID from the first column
    status = subject_status.get(subject_id, "N/A")
    columns[3] = status  # Update the fourth column with status
    lines[i] = "\t".join(columns) + "\n"  # Update the line with new columns

# Write the updated lines back to the output text file
with open("/scratch/project_2001640/ABCD_fMRI/csc_fmri/G010_database.txt", "w") as f:
    f.writelines(lines)


#mriqc status

#check if faulty mriqc file exists and then read the sub list from the file
if os.path.exists("/scratch/project_2001640/ABCD_fMRI/csc_fmri/scripts/downcmd_txt_files/G031_faulty_mriqc_file.txt"):
    with open("/scratch/project_2001640/ABCD_fMRI/csc_fmri/scripts/downcmd_txt_files/G031_faulty_mriqc_file.txt", "r") as f:
        faulty_mriqc_subjects = [line.strip() for line in f.readlines()]
else:
    faulty_mriqc_subjects = []

#check if complete mriqc exists and then read the sub list from file
if os.path.exists("/scratch/project_2001640/ABCD_fMRI/csc_fmri/scripts/downcmd_txt_files/G031_non_faulty_mriqc.txt"):
    with open("/scratch/project_2001640/ABCD_fMRI/csc_fmri/scripts/downcmd_txt_files/G031_non_faulty_mriqc.txt", "r") as f:
        non_faulty_mriqc_subjects = [line.strip() for line in f.readlines()]
else:
    non_faulty_mriqc_subjects = []

# Combine the two lists to get all subjects
all_subjects = faulty_mriqc_subjects + non_faulty_mriqc_subjects
#print('all subjects:', all_subjects)

# Create a dictionary to store the status for each subject
subject_status = {subject: "ERROR" if subject in faulty_mriqc_subjects else "Success" for subject in all_subjects}


# Read the existing content of the output text file
with open("/scratch/project_2001640/ABCD_fMRI/csc_fmri/G010_database.txt", "r") as f:
    lines = f.readlines()

# Update the fifth column based on subject status
for i, line in enumerate(lines[1:], start=1):  # Start from the second line (skip header)
    columns = line.strip().split("\t")  # Split line into columns
    subject_id = columns[0]  # Get the subject ID from the first column
    status = subject_status.get(subject_id, "N/A")
    columns[4] = status  # Update the fifth column with status
    lines[i] = "\t".join(columns) + "\n"  # Update the line with new columns

# Write the updated lines back to the output text file
with open("/scratch/project_2001640/ABCD_fMRI/csc_fmri/G031_database.txt", "w") as f:
    f.writelines(lines)


#fmriprep status

#check if faulty fmriprep file exists and then read the sub list from the file
if os.path.exists("/scratch/project_2001640/ABCD_fMRI/csc_fmri/scripts/downcmd_txt_files/G031_faulty_fmriprep.txt"):
    with open("/scratch/project_2001640/ABCD_fMRI/csc_fmri/scripts/downcmd_txt_files/G031_faulty_fmriprep.txt", "r") as f:
        faulty_fmriprep_subjects = [line.strip() for line in f.readlines()]
else:
    faulty_fmriprep_subjects = []

#check if complete fmriprep exists and then read the sub list from file
if os.path.exists("/scratch/project_2001640/ABCD_fMRI/csc_fmri/scripts/downcmd_txt_files/G031_complete_fmriprep.txt"):
    with open("/scratch/project_2001640/ABCD_fMRI/csc_fmri/scripts/downcmd_txt_files/G031_complete_fmriprep.txt", "r") as f:
        non_faulty_fmriprep_subjects = [line.strip() for line in f.readlines()]
else:
    non_faulty_fmriprep_subjects = []

# Combine the two lists to get all subjects
all_subjects = faulty_fmriprep_subjects + non_faulty_fmriprep_subjects
#print('all subjects:', all_subjects)

# Create a dictionary to store the status for each subject
subject_status = {subject: "ERROR" if subject in faulty_fmriprep_subjects else "Success" for subject in all_subjects}


# Read the existing content of the output text file
with open("/scratch/project_2001640/ABCD_fMRI/csc_fmri/G031_database.txt", "r") as f:
    lines = f.readlines()

# Update the sixth column based on subject status
for i, line in enumerate(lines[1:], start=1):  # Start from the second line (skip header)
    columns = line.strip().split("\t")  # Split line into columns
    subject_id = columns[0]  # Get the subject ID from the first column
    status = subject_status.get(subject_id, "N/A")
    columns[5] = status  # Update the sixth column with status
    lines[i] = "\t".join(columns) + "\n"  # Update the line with new columns

# Write the updated lines back to the output text file
with open("/scratch/project_2001640/ABCD_fMRI/csc_fmri/G031_database.txt", "w") as f:
    f.writelines(lines)


