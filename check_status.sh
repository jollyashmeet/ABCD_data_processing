#2023, ABCD Data, FinnBrain Neuroimaging Lab
#Ashmeet Jolly, 2023
#script to check whether all subjects have been downloaded

selectionfile=$1 #assigns the value of the first command-line argument to this variable
date_run=$(date '+Year+%Y_Month%m_Day%d_H%H_M%M_S%S') #record the date of run

if [ -z "$selectionfile" ] #checks if this variable is empty using the -z conditional expression, and if it is empty, the script prints an error message and exits with a status code of 1
then
    echo "Namelist file was not given"
    exit 1
fi

no_of_subjects=$(wc -l $selectionfile | awk '{print $1}') #counts the number of lines in the selectionfile using wc command and extracts the number using awk
echo $no_of_subjects " subjects to be processed"

site="G010"

downcmd_dir="/users/jollyash/NDA/nda-tools/downloadcmd/packages/1223598/.download-progress"
module load python-data #doing this to load all the packages in the python script


#go through lines in the selection file
for round in $(seq $no_of_subjects)
do
    src_subject_id=$(sed -n "$round"p $selectionfile | awk '{print $1}') #extracts src_subject_id from the selection file by retrieving the value in the first column of the corresponding line using sed and awk commands
    mri_info_visitid=$(sed -n "$round"p $selectionfile | awk '{print $2}')
    eventname=$(sed -n "$round"p $selectionfile | awk '{print $3}')
    no_download_requests=$(python3 resolve_log_files.py --downloadcmd_dir $downcmd_dir --downloadcmd_logdir ./downcmd_txt_files --subjid NDAR$src_subject_id --output 0)
    no_download_requests=$(echo $no_download_requests | awk -F' ' '{print $1}')
    echo $no_download_requests
    if [[ "0" == "$no_download_requests" ]]
    then
        echo "0 requests"
        if ! grep -q "$src_subject_id" /scratch/project_2001640/ABCD_fMRI/csc_fmri/scripts/downcmd_txt_files/${site}_error_download.txt; then
           echo "$src_subject_id" >> /scratch/project_2001640/ABCD_fMRI/csc_fmri/scripts/downcmd_txt_files/${site}_error_download.txt
        fi

        #echo "$src_subject_id" >> /scratch/project_2001640/ABCD_fMRI/csc_fmri/scripts/downcmd_txt_files/G054_error_download.txt #to put all the list of subjects that had error in downloading in a text file
        no_skipped_files=$(python3 resolve_log_files.py --downloadcmd_dir $downcmd_dir --downloadcmd_logdir ./downcmd_txt_files --subjid NDAR$src_subject_id --output 1)
        no_skipped_files=$(echo $no_skipped_files | awk -F' ' '{print $1}')
        if [[ "$no_skipped_files" -gt "0" ]]
        then
            echo ">0 skipped"
            #if ! grep -q "$src_subject_id" /scratch/project_2001640/ABCD_fMRI/csc_fmri/scripts/downcmd_txt_files/G010_error_download.txt; then
             #  echo "$src_subject_id" >> /scratch/project_2001640/ABCD_fMRI/csc_fmri/scripts/downcmd_txt_files/G010_error_download.txt
            #fi
            #no_errors=$(python3 resolve_log_files.py --downloadcmd_dir $downcmd_dir --downloadcmd_logdir . --subjid NDAR$src_subject_id --output 2)
            actual_folders=$(python3 resolve_log_files.py --downloadcmd_dir $downcmd_dir --downloadcmd_logdir ./downcmd_txt_files --subjid NDAR$src_subject_id --output 4)
            actual_folders=$(echo $actual_folders | awk -F' ' '{print $1}')
            echo $actual_folders > ./downcmd_txt_files/${site}_folders_to_be_deleted.txt
        fi
    else
        echo ">0 requests"
        if ! grep -q "$src_subject_id" /scratch/project_2001640/ABCD_fMRI/csc_fmri/scripts/downcmd_txt_files/${site}_complete_download.txt; then
            echo "$src_subject_id" >> /scratch/project_2001640/ABCD_fMRI/csc_fmri/scripts/downcmd_txt_files/${site}_complete_download.txt
        fi

        #echo "$src_subject_id" >> /scratch/project_2001640/ABCD_fMRI/csc_fmri/scripts/downcmd_txt_files/G054_complete_download.txt #to put all the list of subjects that completed in downloading in a text file
    fi
done


#so if no of download request is 0,and no of skipped files is > 0, and no of errors is 0, then we list the folders to be deleted, then we go through the list and delete the entire folders so that downloadcmd would download it

#modifying the folders to be deleted file
if [ -f "./downcmd_txt_files/${site}_folders_to_be_deleted.txt" ]; then
    temp_file="./downcmd_txt_files/${site}_folders_to_be_deleted.tmp"
    while IFS= read -r line; do
        folder=$(echo "$line" | rev | cut -c 1-36 | rev)
        echo "$folder" >> "$temp_file"
    done < "./downcmd_txt_files/${site}_folders_to_be_deleted.txt"
    mv "$temp_file" "./downcmd_txt_files/${site}_folders_to_be_deleted.txt"
fi


#run the python script to write to the database.txt file
#python3 python_status.py
