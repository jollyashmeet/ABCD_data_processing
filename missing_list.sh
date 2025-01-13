#!/bin/bash -l

# definition of a .txt selection file, which contains the subject ID's of the participants
# we then use the selection file to loop through the subject ID's
selectionfile=$1
no_cases=0
outfile=''

no_cases=(wc -l $selectionfile)
echo "total cases: $no_cases"

outfile=$(basename "$selectionfile")
outfile=${outfile}_missing.txt
if [ -f $outfile ]; then
	rm $outfile
fi

path=/scratch/project_2001640/ABCD_fMRI/testing_download

for (( case=1; case<=$no_cases; case++ ))
do
	subject=$(sed -n NDAR"$case"  $selectionfile | awk '{print $1}')
	outputfile=${path}/T1_${src_subject_id}.txt
        if [ -f $outputfile ]; then
              continue
        else
              echo $subject >> $outfile
        fi
done
no_missing_cases=(wc -l $outfile)
echo "total missing cases "$no_cases
