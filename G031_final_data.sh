#!/bin/bash
#this script will create a text file with all the subjects in the site that can be used further after deleting those that don't have t1 or rs

file1="/scratch/project_2001640/ABCD_fMRI/site_data/G031_site.txt"
file2="/scratch/project_2001640/ABCD_fMRI/csc_fmri/scripts/downcmd_txt_files/G031_faulty_subs.txt"
merged_file="./downcmd_txt_files/G031_final_data.txt"

#cat $file1
#cat $file2
#check if file1 exists
if [ ! -f "$file1" ]; then
    echo "Error: $file1 not found"
    exit 1
fi

#check if file2 exists
if [ ! -f "$file2" ]; then
    echo "Error: $file2 not found"
    exit 1
fi

# Empty the output_file
> "$merged_file"

#store the values from file2 in an array
#mapfile -t file2_values < "$file2"

#loop through each line in file1 and exclude lines that match strings in file2
while IFS= read -r line; do
    #echo "Processing line: $line"
    first_column=$(echo "$line" | awk '{print $1}')
    #echo "First column: $first_column"
    exclude_row=true
    #loop through each string in file2_values array and check for a match in the current line of file1
   for value in $(cat "$file2"); do
        if [[ "$first_column" == *"$value"* ]]; then
            exclude_row=false
            break
        fi
    done
    #Append the line to the merged file if it doesn't match any stringin file2
    if [ "$exclude_row" = true ]; then
        echo "$line" >> "$merged_file"
    fi
done < "$file1"

#cat $merged_file
echo "File merging completed"

# Count the total number of lines in the merged file
total_lines=$(wc -l < "$merged_file")

# Calculate the number of sub-divisions needed
batch_size=400
total_batches=$(( (total_lines + batch_size - 1) / batch_size ))

# Loop through each batch and create sub-divided files
for ((batch=1; batch<=total_batches; batch++)); do
    start_line=$(( (batch - 1) * batch_size + 1 ))
    end_line=$(( batch * batch_size ))
    output_file="/scratch/project_2001640/ABCD_fMRI/csc_fmri/scripts/downcmd_txt_files/G031_final_data${batch}.txt"
    sed -n "${start_line},${end_line}p" "$merged_file" > "$output_file"
    echo "Created sub-divided file: $output_file"
done

echo "File sub-division completed"




