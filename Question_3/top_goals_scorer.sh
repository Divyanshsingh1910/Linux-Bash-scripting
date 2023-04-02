#! /bin/bash

#Checking the files
if [ !  -f "$1" ]; then
    echo "Input file not found"
    exit 1
fi

if [ ! -f "$2" ]; then
    touch "output"
    out="output"
else out=$2
fi


input_file=$1
touch "least_out_of_top"

cat $input_file | awk -F ',' '{if(NR>1){print $0}}' | sort -t ',' -k16 -gr | awk -F ',' '{print $16}' | uniq | head -n 10 | awk 'END{print}' > "least_out_of_top"
num=`cat least_out_of_top`

#printing the columns name
cat $input_file | awk '{if(NR==1){print $0}}' > $out
cat $input_file | awk '{if(NR!=1){print $0}}' | sort -t ',' -k16 -gr | awk -F ',' -v var="$num" '{if(NR>1 && $16>=var){print $0}}' >> $out

cat $out

rm "least_out_of_top"
