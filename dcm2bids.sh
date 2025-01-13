
# $1 means 1st argument to the script
subid=NDARINVZ95YA2ZB
ses="baselineYear1Arm1"

cd /scratch/project_2001640/ABCD_fMRI/S011_download/image03
# extract tar gzip archive file which was downloaded from NDA
tar zxvf ${subid}_${ses}_ABCD-T1_*.tgz   -C /scratch/project_2001640/ABCD_fMRI/S011_download
tar zxvf ${subid}_${ses}_ABCD-rsfMRI_*.tgz  -C /scratch/project_2001640/ABCD_fMRI/S011_download

# create output BIDS folder
#echo mkdir -p BIDS/sub-${subid}/ses-${ses}/anat/
#echo mkdir -p BIDS/sub-${subid}/ses-${ses}/func/
# convert with dcm2bids
#echo dcm2bids -d /scratch/project_2001640/ABCD_fMRI/data/image03/sub-${subid}/ses-${ses}/anat/ -p ${subid} -c SW/config.json -o BIDS -s ${ses} --forceDcm2niix
#echo dcm2bids -d /scratch/project_2001640/ABCD_fMRI/data/image03/sub-${subid}/ses-${ses}/func/ -p ${subid} -c SW/config.json -o BIDS -s ${ses} --forceDcm2niix

dcm2bids -d /scratch/project_2001640/ABCD_fMRI/S011_download/sub-${subid}/ses-baselineYear1Arm1/func/ -p ${subid} -c /scratch/project_2001640/ABCD_fMRI/csc_fmri/SW/config.json -o /scratch/project_2001640/ABCD_fMRI/S011/BIDS_test -s baselineYear1Arm1 --forceDcm2niix
dcm2bids -d /scratch/project_2001640/ABCD_fMRI/S011_download/sub-${subid}/ses-baselineYear1Arm1/anat/ -p ${subid} -c /scratch/project_2001640/ABCD_fMRI/csc_fmri/SW/config.json -o /scratch/project_2001640/ABCD_fMRI/S011/BIDS_test -s baselineYear1Arm1 --forceDcm2niix
#dcm2bids -d /scratch/project_2001640/ABCD_fMRI/data/image03/sub-${subid}/ses-${ses}/func/ -p ${subid} -c SW/config.json -o BIDS -s ${ses} --forceDcm2niix
#dcm2bids -d /scratch/project_2001640/ABCD_fMRI/data/image03/sub-${subid}/ses-${ses}/anat/ -p ${subid} -c SW/config.json -o BIDS -s ${ses} --forceDcm2niix
