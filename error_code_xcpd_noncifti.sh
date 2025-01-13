#!/bin/bash
#Jolly, 2024
#FinnBrain Neuroimaging Lab
#for xcpd 36P noncifti

site='P064'
# Directory containing error files
error_dir="/scratch/project_2001640/ABCD_fMRI/${site}"

# Error pattern to search for in error files
error_pattern1="IndexError: list index out of range"
error_pattern2="sqlalchemy.exc.OperationalError: (sqlite3.OperationalError) database or disk is full"
error_pattern3="FileNotFoundError: Dataset description DNE: /data/dataset_description.json"
error_pattern4="^\s*OSError: \[Errno 28\] No space left on device"
error_pattern5="^xcp_d failed: 2 raised. Re-raising first."

# File containing job mappings
job_mapping_file="/scratch/project_2001640/ABCD_fMRI/csc_fmri/scripts/downcmd_txt_files/${site}_xcpd_job_mapping_noncifti.txt"

# Output file for subjects with IndexError
output_file1="/scratch/project_2001640/ABCD_fMRI/csc_fmri/scripts/downcmd_txt_files/${site}_xcpd_noncifti_indexER.txt"
output_file2="/scratch/project_2001640/ABCD_fMRI/csc_fmri/scripts/downcmd_txt_files/${site}_xcpd_noncifti_sqlER.txt"
output_file3="/scratch/project_2001640/ABCD_fMRI/csc_fmri/scripts/downcmd_txt_files/${site}_xcpd_noncifti_fnotfER.txt"
output_file4="/scratch/project_2001640/ABCD_fMRI/csc_fmri/scripts/downcmd_txt_files/${site}_xcpd_noncifti_nospaceER.txt"
output_file_unknown="/scratch/project_2001640/ABCD_fMRI/csc_fmri/scripts/downcmd_txt_files/${site}_xcpd_noncifti_unknownER.txt"

# Initialize output files
touch "$output_file1" "$output_file2" "$output_file3" "$output_file4" "$output_file_unknown"

# Loop through error files
echo "for index error"
for error_file in "$error_dir"/error_*; do
    if grep -q "$error_pattern1" "$error_file"; then
        # Extract job number from error file name
        job_number=$(basename "$error_file" | sed 's/error_//')
        echo "$job_number"
        # Search for job number in job mapping file and extract subject ID
        subject_id=$(awk -v job="$job_number" '$3 == job {print $NF}' "$job_mapping_file")
        echo "$subject_id"
        # Append subject ID to output file
        if [ -n "$subject_id" ]; then
            echo "$subject_id" >> "$output_file1"
        fi
    fi
done


echo "for sql error"
for error_file in "$error_dir"/error_*; do
    if grep -q "$error_pattern2" "$error_file"; then
        # Extract job number from error file name
        job_number=$(basename "$error_file" | sed 's/error_//')
        echo "$job_number"
        # Search for job number in job mapping file and extract subject ID
        subject_id=$(awk -v job="$job_number" '$3 == job {print $NF}' "$job_mapping_file")
        echo "$subject_id"
        # Append subject ID to output file
        if [ -n "$subject_id" ]; then
            echo "$subject_id" >> "$output_file2"
        fi
    fi
done


echo "for file not found error"
for error_file in "$error_dir"/error_*; do
    if grep -q "$error_pattern3" "$error_file"; then
        # Extract job number from error file name
        job_number=$(basename "$error_file" | sed 's/error_//')
        echo "$job_number"
        # Search for job number in job mapping file and extract subject ID
        subject_id=$(awk -v job="$job_number" '$3 == job {print $NF}' "$job_mapping_file")
        echo "$subject_id"
        # Append subject ID to output file
        if [ -n "$subject_id" ]; then
            echo "$subject_id" >> "$output_file3"
        fi
    fi
done


echo "for no space left on device error"
for error_file in "$error_dir"/error_*; do
    if grep -q "$error_pattern4" "$error_file"; then
        # Extract job number from error file name
        job_number=$(basename "$error_file" | sed 's/error_//')
        echo "$job_number"
        # Search for job number in job mapping file and extract subject ID
        subject_id=$(awk -v job="$job_number" '$3 == job {print $NF}' "$job_mapping_file")
        echo "$subject_id"
        # Append subject ID to output file
        if [ -n "$subject_id" ]; then
            echo "$subject_id" >> "$output_file4"
        fi
    fi
done

echo "for unknown error"
for error_file in "$error_dir"/error_*; do
    if grep -q "$error_pattern5" "$error_file"; then
        # Extract job number from error file name
        job_number=$(basename "$error_file" | sed 's/error_//')
        echo "$job_number"
# Check if the error file does not contain any other error pattern
        if ! grep -qE "$error_pattern1|$error_pattern2|$error_pattern3|$error_pattern4" "$error_file"; then
            # Search for job number in job mapping file and extract subject ID
            subject_id=$(awk -v job="$job_number" '$3 == job {print $NF}' "$job_mapping_file")
            echo "$subject_id"
            # Append subject ID to unknown error output file
            if [ -n "$subject_id" ]; then
                echo "$subject_id" >> "$output_file_unknown"
            fi
        fi
    fi
done

cd /scratch/project_2001640/ABCD_fMRI/csc_fmri/scripts/downcmd_txt_files/

sort ${site}_xcpd_noncifti_indexER.txt | uniq > ${site}_xcpd_noncifti_indexERR.txt 
rm ${site}_xcpd_noncifti_indexER.txt


sort ${site}_xcpd_noncifti_sqlER.txt | uniq > ${site}_xcpd_noncifti_sqlERR.txt 
rm ${site}_xcpd_noncifti_sqlER.txt


sort ${site}_xcpd_noncifti_fnotfER.txt | uniq > ${site}_xcpd_noncifti_fnotfERR.txt 
rm ${site}_xcpd_noncifti_fnotfER.txt


sort ${site}_xcpd_noncifti_nospaceER.txt | uniq > ${site}_xcpd_noncifti_nospaceERR.txt 
rm ${site}_xcpd_noncifti_nospaceER.txt


sort ${site}_xcpd_noncifti_unknownER.txt | uniq > ${site}_xcpd_noncifti_unknownERR.txt 
rm ${site}_xcpd_noncifti_unknownER.txt


#remove NDAR prefix so that the python file can read it
sed -i 's/^NDAR//' "/scratch/project_2001640/ABCD_fMRI/csc_fmri/scripts/downcmd_txt_files/${site}_xcpd_noncifti_indexERR.txt"
sed -i 's/^NDAR//' "/scratch/project_2001640/ABCD_fMRI/csc_fmri/scripts/downcmd_txt_files/${site}_xcpd_noncifti_sqlERR.txt"
sed -i 's/^NDAR//' "/scratch/project_2001640/ABCD_fMRI/csc_fmri/scripts/downcmd_txt_files/${site}_xcpd_noncifti_fnotfERR.txt"
sed -i 's/^NDAR//' "/scratch/project_2001640/ABCD_fMRI/csc_fmri/scripts/downcmd_txt_files/${site}_xcpd_noncifti_nospaceERR.txt"
sed -i 's/^NDAR//' "/scratch/project_2001640/ABCD_fMRI/csc_fmri/scripts/downcmd_txt_files/${site}_xcpd_noncifti_unknownERR.txt"
