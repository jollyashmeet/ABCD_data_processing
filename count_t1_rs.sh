#counting resting state and T1
#Ashmeet Jolly
##2023, ABCD Data, FinnBrain Neuroimaging Lab

#module load python-data
selectionfile=$1 #assigns the value of the first command-line argument to this variable
#creating a variable to store the counts
counts="Subject ID\\tNo. of T1\\tNo. of rsfMRI\\n"

if [ -z "$selectionfile" ] #checks if this variable is empty using the -z conditional expression, and if it is empty, the script prints an error message and exits with a status code of 1
then
    echo "Namelist file was not given"
    exit 1
fi

site="G010"

output_dir="/scratch/project_2001640/ABCD_fMRI/${site}_download/image03"

date_run=$(/usr/bin/date '+Year+%Y_Month%m_Day%d_H%H_M%M_S%S') #record the date of run
#ls -1 "$output_dir/"

no_of_subjects=$(wc -l $selectionfile | awk '{print $1}') #counts the number of lines in the selectionfile using wc command and extracts the number using awk
echo $no_of_subjects " subjects to be processed"

# Initialize variables to store subject IDs with missing T1 and rsfMRI
missing_t1=""
missing_rsfmri=""
missing_both=""

#go through lines in the selection file
for round in $(seq $no_of_subjects)
do
    src_subject_id=$(sed -n "$round"p $selectionfile | awk '{print $1}') #extracts src_subject_id from the selection file by retrieving the value in the first column of the corresponding line using sed and awk commands
    mri_info_visitid=$(sed -n "$round"p $selectionfile | awk '{print $2}')
    eventname=$(sed -n "$round"p $selectionfile | awk '{print $3}')
   # initialize the count for T1 and rsfMRI to 0
    t1_count=0
    rsfmri_count=0

    #check the presence of T1 and rsfMRI files in the output directory for the current subject
    for file in $(ls -1 $output_dir/NDAR${src_subject_id}*.tgz); do
        #echo $file
        if [[ $file == *"T1_"* ]]; then
            ((t1_count++))
        elif [[ $file == *"rsfMRI_"* ]]; then
            ((rsfmri_count++))
        fi
    done

    #add the subject ID, T1 count, and rsfMRI count to the counts variable
    counts+="NDAR$src_subject_id\\t$t1_count\\t$rsfmri_count\\n"

   #check if either T1 or rsfMRI count is 0 and add the subject ID to faulty_subs
   if [ "$t1_count" -eq 0 ] || [ "$rsfmri_count" -eq 0 ]; then
       faulty_subs+="$src_subject_id\\n"
   else
       non_faulty_subs+="$src_subject_id\\n"
   fi

 # Check if either T1 or rsfMRI count is 0 and add the subject ID to corresponding list
#    if [ "$t1_count" -eq 0 ]; then
 #       missing_t1+="$src_subject_id\\n"
  #  fi

   # if [ "$rsfmri_count" -eq 0 ]; then
    #    missing_rsfmri+="$src_subject_id\\n"
    #fi

   # Check if either T1 or rsfMRI count is 0 and add the subject ID to the corresponding list
    if [ "$t1_count" -eq 0 ]; then
        if [ "$rsfmri_count" -eq 0 ]; then
            missing_both+="NDAR$src_subject_id\\n"
        else
            missing_t1+="NDAR$src_subject_id\\n"
        fi
    elif [ "$rsfmri_count" -eq 0 ]; then
        missing_rsfmri+="NDAR$src_subject_id\\n"
    fi

done


#write the counts to a text file
echo -e "$counts" > ./downcmd_txt_files/${site}_counts_T1_rs.txt

# Write the faulty subject list to the text files
echo -e "$missing_t1" > ./downcmd_txt_files/${site}_missing_t1.txt
echo -e "$missing_rsfmri" > ./downcmd_txt_files/${site}_missing_rsfmri.txt
echo -e "$missing_both" > ./downcmd_txt_files/${site}_missing_both.txt

#write the faulty subject list to the text file
echo -e "$faulty_subs" >./downcmd_txt_files/${site}_faulty_subs.txt
echo -e "$non_faulty_subs" > ./downcmd_txt_files/${site}_non_faulty_subs.txt

# Count the total number of subs in the faulty subs file
total_faulty_subs=$(wc -l ./downcmd_txt_files/${site}_faulty_subs.txt)
total_nonfaulty_subs=$(wc -l ./downcmd_txt_files/${site}_non_faulty_subs.txt)

# Print the total number of subjects faulty and non-faulty
echo "Total number of faulty subs: $total_faulty_subs"
echo "Total number of non-faulty subs: $total_nonfaulty_subs"

# Remove the 'NDAR' prefix from the subject IDs in the missing_*.txt files
sed -i 's/^NDAR//' ./downcmd_txt_files/${site}_missing_t1.txt
sed -i 's/^NDAR//' ./downcmd_txt_files/${site}_missing_rsfmri.txt
sed -i 's/^NDAR//' ./downcmd_txt_files/${site}_missing_both.txt

#run the python script to write to the database.txt file
#python3 python_status.py
