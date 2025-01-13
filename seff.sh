#!/bin/bash
#Jolly
#October, 2023
#FinnBrain Neuroimaging Lab

site="S065"
# Input file with date, job ID, and subject ID

#mriqc and fmriprep
#input_file="/scratch/project_2001640/ABCD_fMRI/${site}/${site}_mriqc_fmriprep_job_mapping.txt"
#input_file="/scratch/project_2001640/ABCD_fMRI/csc_fmri/scripts/downcmd_txt_files/${site}_mriqc_fmriprep_job_mapping.txt"

#dcm2bids and extraction
#input_file="/scratch/project_2001640/ABCD_fMRI/${site}/${site}_tar_dcm_del_job_mapping.txt"
input_file="/scratch/project_2001640/ABCD_fMRI/csc_fmri/scripts/downcmd_txt_files/${site}_tar_dcm_del_job_mapping.txt"

# Output file to store seff results
#dcm2bids and extraction
output_file="/scratch/project_2001640/ABCD_fMRI/csc_fmri/scripts/downcmd_txt_files/${site}_tar_dcm_del_seff.txt"

#mriqc anf fmriprep
#output_file="/scratch/project_2001640/ABCD_fMRI/csc_fmri/scripts/downcmd_txt_files/${site}_mriqc_fmriprep_seff.txt"

awk '{$1=$2=""; gsub(/^[ \t]+/, "", $0); print}' $input_file > mod_input_file.txt
#cat $input_file

# Create the header line in the output file
echo -e "Job ID\tSubject ID\tCluster\tUser/Group\tState\tNodes\tCores per node\tCPU Utilized\tCPU Efficiency\tJob Wall-clock time\tMemory Utilized\tMemory Efficiency\tJob consumed CSC billing units\tBilled project\tCPU BU\tMem BU" > "$output_file"

# Loop through each line in the input file
while IFS=$'\t' read -r job_id subject_id; do
    # Run seff and capture its output
    seff_output=$(seff "$job_id")

    # Extract values from seff output
    cluster=$(echo "$seff_output" | grep "Cluster:" | awk '{print $2}')
    user_group=$(echo "$seff_output" | grep "User/Group:" | awk '{print $2"/"$3}')
    state=$(echo "$seff_output" | grep "State:" | awk '{print $2}')
    nodes=$(echo "$seff_output" | grep "Nodes:" | awk '{print $2}')
    cores_per_node=$(echo "$seff_output" | grep "Cores per node:" | awk '{print $4}')
    cpu_utilized=$(echo "$seff_output" | grep "CPU Utilized:" | awk '{print $3}')
    cpu_efficiency=$(echo "$seff_output" | grep "CPU Efficiency:" | awk '{print $3}')
    job_wall_time=$(echo "$seff_output" | grep "Job Wall-clock time:" | awk '{print $4}')
    memory_utilized=$(echo "$seff_output" | grep "Memory Utilized:" | awk '{print $3}')
    memory_efficiency=$(echo "$seff_output" | grep "Memory Efficiency:" | awk '{print $3}')
    job_consumed=$(echo "$seff_output" | grep "Job consumed" | awk '{print $4" "$5" "$6" "$7" "$8}')
    billed_project=$(echo "$seff_output" | grep "Billed project:" | awk '{print $2}')
    cpu_bu=$(echo "$seff_output" | grep "CPU BU:" | awk '{print $3}')
    mem_bu=$(echo "$seff_output" | grep "Mem BU:" | awk '{print $3}')

    # Append the values to the output file
    echo -e "$job_id\t$subject_id\t$cluster\t$user_group\t$state\t$nodes\t$cores_per_node\t$cpu_utilized\t$cpu_efficiency\t$job_wall_time\t$memory_utilized\t$memory_efficiency\t$job_consumed\t$billed_project\t$cpu_bu\t$mem_bu" >> "$output_file"

done < "/scratch/project_2001640/ABCD_fMRI/csc_fmri/scripts/mod_input_file.txt"

