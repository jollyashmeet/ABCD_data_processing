#!/bin/bash -l
# created: Jun 13th, 2023
# author : jolly
#SBATCH --job-name=QTAB_partlycloudy
#SBATCH --account=Project_2001640
#SBATCH --time 15:00:00
#SBATCH --partition=small
#SBATCH --ntasks=1
#SBATCH --nodes=1
#SBATCH --cpus-per-task=4
#SBATCH --mem=64g
#SBATCH -o done_%j
#SBATCH -e error_%j
#SBATCH --mail-type=END
#SBATCH --mail-user=meetajolly24@gmail.com


subid=SUBJECTIDPLACEHOLDER
job_name="$SLURM_JOB_NAME"  # Get the job name
echo "JobID: $SLURM_JOB_ID, Subject: $subid" #to see which job corresponds to which subject
# Write the job ID and subject ID to a file
current_date=$(date +"%Y-%m-%d")
#echo "$current_date $job_name $SLURM_JOB_ID $subid" >> ${site}_mriqc_fmriprep_job_mapping.txt

# Define the path to the completed subjects file

#for fmriprep
#separate output files for each subject to have separate fsaverage folders and work dir
mkdir -p /scratch/project_2001640/QTAB/work/${subid}
mkdir -p /scratch/project_2001640/QTAB/derivatives/fmriprep/${subid}_output

#fmriprep
apptainer exec --cleanenv -B /scratch/project_2001640/QTAB/:/data:ro -B /scratch/project_2001640/QTAB/derivatives/fmriprep/${subid}_output:/output -B /scratch/project_2001640/QTAB/work/${subid}:/work -B /scratch/project_2001640/ABCD_fMRI/license.txt:/opt/freesurfer/license.txt /scratch/project_2001640/fmriprep_sif/fmriprep:22.1.1.sif sh -c "unset PYTHONPATH; export HOME=/home/fmriprep; fmriprep /data /output participant --participant_label ${subid} --skip_bids_validation --use-aroma --bids-filter-file /data/bids_filter.json --cifti-output 91k --use-syn-sdc --output-spaces MNI152NLin2009cAsym MNI152NLin6Asym MNI152NLin6Asym:res-2 fsnative fsaverage6 fsaverage5 fsLR --write-graph --task-id partlycloudy" &

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
directory_to_empty="/scratch/project_2001640/QTAB/work/"${subid}

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


