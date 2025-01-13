#!/bin/bash -l
# created: Jun 13th, 2023
# author : jolly
#SBATCH --job-name=P064_xcpd_36P_noncifti
#SBATCH --account=Project_2001640
#SBATCH --time 02:30:00
#SBATCH --partition=large
#SBATCH --ntasks=1
#SBATCH --nodes=1
#SBATCH --cpus-per-task=6
#SBATCH --mem=20g
#SBATCH -o done_%j
#SBATCH -e error_%j
#SBATCH --mail-type=END
#SBATCH --mail-user=meetajolly24@gmail.com

site="P064"

subid=SUBJECTIDPLACEHOLDER
job_name="$SLURM_JOB_NAME"  # Get the job name
echo "JobID: $SLURM_JOB_ID, Subject: $subid" #to see which job corresponds to which subject
# Write the job ID and subject ID to a file
current_date=$(date +"%Y-%m-%d")

#cifti job mapping
#echo "$current_date $job_name $SLURM_JOB_ID $subid" >> /scratch/project_2001640/ABCD_fMRI/csc_fmri/scripts/downcmd_txt_files/${site}_xcpd_job_mapping_cifti.txt

#noncifti job mapping
echo "$current_date $job_name $SLURM_JOB_ID $subid" >> /scratch/project_2001640/ABCD_fMRI/csc_fmri/scripts/downcmd_txt_files/${site}_xcpd_job_mapping_noncifti.txt

# Define the path to the completed subjects file

#separate output files for each subject to have separate work dir
mkdir -p /scratch/project_2001640/wrk/sub-${subid}

#xcpd #removed fd thresh in both commands for no scrubbing

#with cifti flag
#deleted clean work dir ##fd thresh = 0 #added --atlases
#apptainer exec -B /scratch/project_2001640/ABCD_fMRI/${site}/BIDS/derivatives/fmriprep/sub-${subid}_output:/data:ro -B /scratch/project_2001640/ABCD_fMRI/${site}/BIDS/derivatives/xcpd_cifti:/output:rw -B /scratch/project_2001640/wrk/sub-${subid}:/work:rw -B /scratch/project_2001640/ABCD_fMRI:/ABCD_fMRI -B /scratch/project_2001640/ABCD_fMRI/license.txt:/opt/freesurfer/license.txt -B /scratch/project_2001640/ABCD_fMRI/work:/home/xcp_d/.cache:rw /scratch/project_2001640/xcp_sif/xcp_d:0.7.0.sif sh -c "export HOME=/home/xcp_d; export USER=xcp_d; xcp_d /data /output participant --participant_label sub-${subid} --input-type fmriprep --despike --nuisance-regressors 36P --fd-thresh 0 --cifti --lower-bpf 0.01 --upper-bpf 0.08 --head_radius 50 --atlases 4S1056Parcels 4S156Parcels 4S256Parcels 4S356Parcels 4S456Parcels 4S556Parcels 4S656Parcels 4S756Parcels 4S856Parcels 4S956Parcels Glasser Gordon HCP Tian -w /work --sm 6 --bids-filter-file /ABCD_fMRI/xcp_d_config.json" &

#without cifti flag #noncifti
#deleted clean work dir
##adding --fd-thresh 0 for testing ##decided on fd thresh = 0 ##added --atlases
apptainer exec -B /scratch/project_2001640/ABCD_fMRI/${site}/BIDS/derivatives/fmriprep/sub-${subid}_output:/data:ro -B /scratch/project_2001640/ABCD_fMRI/${site}/BIDS/derivatives/xcpd_noncifti:/output:rw -B /scratch/project_2001640/wrk/sub-${subid}:/work:rw -B /scratch/project_2001640/ABCD_fMRI:/ABCD_fMRI -B /scratch/project_2001640/ABCD_fMRI/license.txt:/opt/freesurfer/license.txt  -B /scratch/project_2001640/ABCD_fMRI/work:/home/xcp_d/.cache:rw /scratch/project_2001640/xcp_sif/xcp_d:0.7.0.sif sh -c "export HOME=/home/xcp_d; export USER=xcp_d; xcp_d /data /output participant --participant_label sub-${subid} --input-type fmriprep --despike --nuisance-regressors 36P --fd-thresh 0 --lower-bpf 0.01 --upper-bpf 0.08 --head_radius 50 --atlases 4S1056Parcels 4S156Parcels 4S256Parcels 4S356Parcels 4S456Parcels 4S556Parcels 4S656Parcels 4S756Parcels 4S856Parcels 4S956Parcels Glasser Gordon HCP Tian -w /work --sm 6 --bids-filter-file /ABCD_fMRI/xcp_d_config.json" &

wait ## Wait for background processes to finish

# Specify the job ID you want to monitor to empty the work dir
job_id=$SLURM_JOB_ID # Replace with your job ID

# Function to check if the job is completed
is_job_completed() {
    local status
#sacct -u jollyash --state=RUNNING
    status=$(sacct | grep "$job_id" | grep "COMPLETED" | wc -l)
    echo $status
    if [ "$status" -eq "0" ]; then
        return 0  # Job is completed
    else
        return 1  # Job is not completed
    fi
}

# Directory to empty when the job is completed
directory_to_empty="/scratch/project_2001640/wrk/sub-"${subid}

# Check if the job is completed
if is_job_completed "$job_id"; then
    # Job is completed, delete the contents of the directory
    echo "Ashmeet's script: Job $job_id is completed."
    echo "Ashmeet's script: Emptying directory: $directory_to_empty"
    rm -r "$directory_to_empty"/*  # This will delete all files and sub-directories
    echo "Ashmeet's script: Directory $directory_to_empty is now empty."
else
    # Job is not completed
    echo "Ashmeet's script: Job $job_id is still running or has not completed."
fi


