#! /bin/bash

if [ ! -f "$1" ]; then
    echo "Input file not found"
    exit 1
fi

if [ ! -f "$2" ]; then
    touch "output"
    out="output"
else out=$2
fi

input_file=$1
gk="Goalkeeper"
fw="Forward"
mf="Midfielder"
df="Defender"

touch "sorted"


cat $input_file | awk -F ',' '{print $1","$12","$7","$16}' | awk -F ',' '{if(NR>1){print $0}}' | sort -t ',' -k4 -g -r > "sorted"
# cat sorted
cat $input_file | awk -F ',' '{if(NR==1){print $1","$12","$7","$16}}' > $out
cat "sorted" | awk -F ',' -v gk="$gk" '{if($3==gk){print $0}}' >> $out
cat "sorted" | awk -F ',' -v df="$df" '{if($3==df){print $0}}' >> $out
cat "sorted" | awk -F ',' -v mf="$mf" '{if($3==mf){print $0}}' >> $out
cat "sorted" | awk -F ',' -v fw="$fw" '{if($3==fw){print $0}}' >> $out

cat $out
rm "sorted"