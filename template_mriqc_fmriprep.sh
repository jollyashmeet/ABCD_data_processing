#!/bin/bash -l
# created: Jun 13th, 2023
# author : jolly
#SBATCH --job-name=G010_mri_fmriprep
#SBATCH --account=Project_2001640
#SBATCH --time 15:00:00
#SBATCH --partition=large
#SBATCH --ntasks=1
#SBATCH --nodes=1
#SBATCH --cpus-per-task=6
#SBATCH --mem=64g
#SBATCH -o done_%j
#SBATCH -e error_%j
#SBATCH --mail-type=END
#SBATCH --mail-user=meetajolly24@gmail.com

site="G010"

subid=SUBJECTIDPLACEHOLDER
job_name="$SLURM_JOB_NAME"  # Get the job name
echo "JobID: $SLURM_JOB_ID, Subject: $subid" #to see which job corresponds to which subject
# Write the job ID and subject ID to a file
current_date=$(date +"%Y-%m-%d")
echo "$current_date $job_name $SLURM_JOB_ID $subid" >> ${site}_mriqc_fmriprep_job_mapping.txt

# Define the path to the completed subjects file

#for fmriprep
#separate output files for each subject to have separate fsaverage folders and work dir
mkdir -p /scratch/project_2001640/ABCD_fMRI/work/sub-${subid}
mkdir -p /scratch/project_2001640/ABCD_fMRI/${site}/BIDS/derivatives/fmriprep/sub-${subid}_output

#correction for philips scanner
#python3 /scratch/project_2001640/ABCD_fMRI/csc_fmri/scripts/step1_prepare_jsons.py --folder /scratch/project_2001640/ABCD_fMRI/${site}/BIDS/ --subjid sub-${subid} --ses ses-baselineYear1Arm1

#mriqc
apptainer exec --cleanenv -B /scratch/project_2001640/ABCD_fMRI/${site}/BIDS:/data:ro -B /scratch/project_2001640/ABCD_fMRI/${site}/BIDS/derivatives/mriqc:/out -B /scratch/project_2001640/ABCD_fMRI/work/sub-${subid}:/work /scratch/project_2001640/mriqc_sif/mriqc23.1.0.sif sh -c "unset PYTHONPATH; export HOME=/home/mriqc; mriqc /data /out participant --participant_label sub-${subid} -m T1w bold" &

#fmriprep
apptainer exec --cleanenv -B /scratch/project_2001640/ABCD_fMRI/${site}/BIDS:/data:ro -B /scratch/project_2001640/ABCD_fMRI/${site}/BIDS/derivatives/fmriprep/sub-${subid}_output:/output -B /scratch/project_2001640/ABCD_fMRI/work/sub-${subid}:/work -B /scratch/project_2001640/ABCD_fMRI/license.txt:/opt/freesurfer/license.txt /scratch/project_2001640/fmriprep_sif/fmriprep23.1.3.sif sh -c "unset PYTHONPATH; export HOME=/home/fmriprep; fmriprep /data /output participant --participant_label sub-${subid} --skip_bids_validation --cifti-output 91k --use-syn-sdc --output-spaces MNI152NLin2009cAsym MNI152NLin6Asym MNI152NLin6Asym:res-2 fsnative fsaverage6 fsaverage5 fsLR --write-graph --project-goodvoxels" &

#fmriprep wajiha
#/scratch/project_2001640/ABCD_fMRI/wajiha_BIDS/CSC/sub-01
#wajiha_list=('sub-01' 'sub-02' 'sub-03' 'sub-04' 'sub-05' 'sub-06' 'sub-07')


####### WAJIHA #######
#for subid in "${wajiha_list[@]}"; do
#apptainer exec --cleanenv -B /scratch/project_2001640/ABCD_fMRI/wajiha_BIDS/CSC:/data:ro -B /scratch/project_2001640/ABCD_fMRI/wajiha_BIDS/derivatives/fmriprep_CSC:/output -B /scratch/project_2001640/ABCD_fMRI/work:/work -B /scratch/project_2001640/ABCD_fMRI/license.txt:/opt/freesurfer/license.txt /scratch/project_2001640/fmriprep_sif/fmriprep23.1.3.sif sh -c "unset PYTHONPATH; export HOME=/home/fmriprep; fmriprep /data /output participant --participant_label ${subid} --skip_bids_validation --cifti-output 91k --use-syn-sdc --output-spaces MNI152NLin2009cAsym MNI152NLin6Asym MNI152NLin6Asym:res-2 fsnative fsaverage6 fsaverage5 fsLR --write-graph --project-goodvoxels"
#done
###### WAJIHA #######


#xcp-d - cifti 36P
#apptainer exec -B /scratch/project_2001640/ABCD_fMRI/G054/BIDS/derivatives/fmriprep/:/data:ro -B /scratch/project_2001640/ABCD_fMRI/G054/BIDS/derivatives/xcp_d:/output:rw -B /scratch/project_2001640/wrk:/work:rw -B /scratch/project_2001640/ABCD_fMRI:/ABCD_fMRI -B /scratch/project_2001640/ABCD_fMRI/license.txt:/opt/freesurfer/license.txt  -B /scratch/project_2001640/ABCD_fMRI/work:/home/xcp_d/.cache:rw /scratch/project_2001640/xcp_sif/xcp_d-04.0.sif sh -c "export HOME=/home/xcp_d; export USER=xcp_d; xcp_d /data /output participant --participant_label $subid --input-type fmriprep --despike --nuisance-regressors 36P --cifti --fd-thresh 0.2 --lower-bpf 0.01 --upper-bpf 0.08 --head_radius 50 -w /work --sm 6 --clean-workdir --bids-filter-file /ABCD_fMRI/xcp_d_config.json"
#xcp-d - non-cifti 36P
#apptainer exec -B /scratch/project_2001640/ABCD_fMRI/G054/BIDS/derivatives/fmriprep/:/data:ro -B /scratch/project_2001640/ABCD_fMRI/G054/BIDS/derivatives/xcp_d_non_cifti:/output:rw -B /scratch/project_2001640/wrk:/work:rw -B /scratch/project_2001640/ABCD_fMRI:/ABCD_fMRI -B /scratch/project_2001640/ABCD_fMRI/license.txt:/opt/freesurfer/license.txt  -B /scratch/project_2001640/ABCD_fMRI/work:/home/xcp_d/.cache:rw /scratch/project_2001640/xcp_sif/xcp_d-04.0.sif sh -c "export HOME=/home/xcp_d; export USER=xcp_d; xcp_d /data /output participant --participant_label $subid --input-type fmriprep --despike --nuisance-regressors 36P --fd-thresh 0.2 --lower-bpf 0.01 --upper-bpf 0.08 --head_radius 50 -w /work --sm 6 --clean-workdir --bids-filter-file /ABCD_fMRI/xcp_d_config.json"

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
directory_to_empty="/scratch/project_2001640/ABCD_fMRI/work/sub-"${subid}

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


