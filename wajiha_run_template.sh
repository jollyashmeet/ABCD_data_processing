#!/bin/sh
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

no_of_subjects=$(wc -l $selectionfile | awk '{print $1}') #counts the number of lines in the selectionfile using wc command and extracts the number using awk
echo $no_of_subjects " subjects to be processed"

#go through lines in the selection file
for round in $(seq $no_of_subjects)
do
    subject_id=$(sed -n "$round"p $selectionfile | awk '{print $1}') #extracts src_subject_id from the selection file by retrieving the value in the first column of the corresponding line using sed and awk commands
    configfile="$log_dir/sbatch_files/${subject_id}.sh"
    echo "Creating "$configfile
    sed "s/SUBJECTIDPLACEHOLDER/$subject_id/g" $templatefile > $configfile
    cmd=$(echo sbatch $configfile)
    echo "Sending subject: $subject_id $templatefile "
    echo $cmd
    ret=$(eval $cmd) #this is the command that actually runs the $cmd
done


