#!/bin/bash -l
# created: Jun 13th, 2023
# author : jolly
#SBATCH --job-name=G010_3_tar_dcm_del
#SBATCH --account=Project_2001640
#SBATCH --time 02:00:00
#SBATCH --partition=large
#SBATCH --ntasks=1
#SBATCH --nodes=1
#SBATCH --cpus-per-task=6
#SBATCH --mem=2g
#SBATCH -o done_%j
#SBATCH -e error_%j
#SBATCH --mail-type=END
#SBATCH --mail-user=meetajolly24@gmail.com

subid=SUBJECTIDPLACEHOLDER
job_name="$SLURM_JOB_NAME"  # Get the job name
echo "JobID: $SLURM_JOB_ID, Subject: $subid" #to see which job corresponds to which subject
# Write the job ID and subject ID to a file
current_date=$(date +"%Y-%m-%d")
site="G010"

echo "$current_date $job_name $SLURM_JOB_ID $subid" >> ${site}_tar_dcm_del_job_mapping.txt

#initialising the flag variable
rsfmri_extracted=false

#extract the first rsfMRI file for the subject
for file in /scratch/project_2001640/ABCD_fMRI/${site}_download/image03/${subid}_baselineYear1Arm1_ABCD-rsfMRI_*.tgz; do
    if ! $rsfmri_extracted; then
       tar zxvf "$file" -C /scratch/project_2001640/ABCD_fMRI/${site}_download
       echo $file" extracted" >> rsfmri_extracted_file_${subid}.txt
       rsfmri_extracted=true
    else
       echo "skipping additional rsfMRI files for subject $subid as they are empty"
    fi
done

#initialising the flag variable
t1_extracted=false

#extract the first T1 file for the subject
for file in /scratch/project_2001640/ABCD_fMRI/${site}_download/image03/${subid}_baselineYear1Arm1_ABCD-T1_*.tgz; do
    if ! $t1_extracted; then
       tar zxvf "$file"  -C /scratch/project_2001640/ABCD_fMRI/${site}_download
       echo $file" extracted" >> t1_extracted_file_${subid}.txt
       t1_extracted=true
    else
       echo "skipping additional T1 files for subject $subid as they are empty"
    fi
done



#dcm2bids
dcm2bids -d /scratch/project_2001640/ABCD_fMRI/${site}_download/sub-${subid}/ses-baselineYear1Arm1/anat/ -p ${subid} -c /scratch/project_2001640/ABCD_fMRI/csc_fmri/SW/config.json -o /scratch/project_2001640/ABCD_fMRI/${site}/BIDS -s baselineYear1Arm1 --forceDcm2niix
dcm2bids -d /scratch/project_2001640/ABCD_fMRI/${site}_download/sub-${subid}/ses-baselineYear1Arm1/func/ -p ${subid} -c /scratch/project_2001640/ABCD_fMRI/csc_fmri/SW/config.json -o  /scratch/project_2001640/ABCD_fMRI/${site}/BIDS -s baselineYear1Arm1 --forceDcm2niix

#deletion of tar
rm -r /scratch/project_2001640/ABCD_fMRI/${site}_download/sub-${subid}

