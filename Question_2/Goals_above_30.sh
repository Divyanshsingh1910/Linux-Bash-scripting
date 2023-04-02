#! /bin/bash

#Checking the files
if [ !  -f "$1" ]; then
    echo "Input file not found"
    exit 1
fi

#creating output file if not passed as argument
if [ ! -f "$2" ]; then
    touch "output.csv"
    output_file="output.csv"
else output_file=$2
fi

input_file=$1

cat $input_file | awk -F "," '$2>30 && $16>=1' > $output_file 

echo "List of the players"
cat $output_file