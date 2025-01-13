#!/bin/sh
###################################################################################################
# ABCD study, commands to run the template file in csc_fmri/sbatch_template/template.sh                           #
# Harri Merisaari, Ashmeet Jolly
###################################################################################################

date_run=$(/usr/bin/date '+Year%Y_Month%m_Day%d_H%H_M%M_S%S') #record the date of run
echo "Date string:"$date_run

selectionfile=$1 #assigns the value of the first command-line argument to this variable
if [ -z "$selectionfile" ] #checks if this variable is empty using the -z conditional expression, and if it is empty, the script prints an error message and exits with a status code of 1
then
    echo "Namelist file was not given"
    exit 1
fi
templatefile=$2 #assigns the value of the first command-line argument to this variable
if [ -z "$templatefile" ] #checks if this variable is empty using the -z conditional expression, and if it is empty, the script prints an error message and exits with a status code of 1
then
    echo "sbatch template file was not given"
    exit 1
fi

tbasename=$(echo $templatefile | awk -F'/' '{print $NF}')
tbasename=$(echo $tbasename | awk -F'.' '{print $1}')
echo "Template file basename "$tbasename
log_dir="./log_files/run_template_sbatch_"$tbasename
if [ ! -d "$log_dir" ]; then
   mkdir -p $log_dir
fi
echo "Using"$log_dir" as log dir"
if [ ! -d "$log_dir/sbatch_files" ]; then
   mkdir -p $log_dir/sbatch_files
fi
echo "Using"$log_dir/sbatch_files" as place to store sbatch files"

#Do I need to make a filter of subjects that already have been processed if I make a separate text file for that in the fmriprep status file?
# Define the path to the completed subjects file
#completed_subjects_file="/scratch/project_2001640/ABCD_fMRI/csc_fmri/scripts/downcmd_txt_files/G054_completed_fmriprep.txt"

# Extract the unique identifier from the subid
#unique_identifier="${subid#NDAR}"

# Check if the unique identifier exists in the completed subjects file
#if grep -q "^$unique_identifier" "$completed_subjects_file"; then
 #   echo "Subject $subid has already been preprocessed."
#else
 #   mkdir -p /scratch/project_2001640/ABCD_fMRI/G054/BIDS/derivatives/fmriprep/sub-${subid}_output
#fi


no_of_subjects=$(wc -l $selectionfile | awk '{print $1}') #counts the number of lines in the selectionfile using wc command and extracts the number using awk
echo $no_of_subjects " subjects to be processed"

#go through lines in the selection file
for round in $(seq $no_of_subjects)
do
    src_subject_id=$(sed -n "$round"p $selectionfile | awk '{print $1}') #extracts src_subject_id from the selection file by retrieving the value in the first column of the corresponding line using sed and awk commands
    mri_info_visitid=$(sed -n "$round"p $selectionfile | awk '{print $2}')
    eventname=$(sed -n "$round"p $selectionfile | awk '{print $3}')

    #replace string SUBJECTPLACEHOLDER with subjectid in templatefile and write changed contents to scripts
    #the template file is the one that Jetro made in the ABCD_fMRI for example, and that is the second parameter
    configfile="$log_dir/sbatch_files/${src_subject_id}_${date_run}.sh"
    echo "Creating "$configfile
    sed "s/SUBJECTIDPLACEHOLDER/NDAR$src_subject_id/g" $templatefile > $configfile

    cmd=$(echo sbatch $configfile)
    echo "Sending subject: $src_subject_id $templatefile "
    echo "Sending subject: $src_subject_id $templatefile " >> $log_dir/${date_run}_submitted_jobs.txt
    echo $cmd
    ret=$(eval $cmd) #this is the command that actually runs the $cmd
done

