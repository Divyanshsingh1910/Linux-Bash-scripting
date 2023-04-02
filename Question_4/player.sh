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

touch "uniq_goals"
goals="uniq_goals"

cat $input_file | awk -F ',' '{if(NR>1){print $1","$12","$7","$16}}' | sort -t ',' -k4 -n -r | awk -F ',' '{print $4}' | uniq | awk -F ',' 'BEGIN{ORS=" ";} {print $0}' > $goals

read -a goals_array < $goals

cat $input_file | awk -F ',' '{if(NR==1){print $1","$12","$7","$16}}' > $out

for goal in ${goals_array[@]}
do
    cat $input_file | awk -F ',' -v goal="$goal" -v gk="$gk" '{if($7==gk && $16==goal){print $1","$12","$7","$16}}' >> $out
    cat $input_file | awk -F ',' -v goal="$goal" -v df="$df" '{if($7==df && $16==goal){print $1","$12","$7","$16}}' >> $out
    cat $input_file | awk -F ',' -v goal="$goal" -v mf="$mf" '{if($7==mf && $16==goal){print $1","$12","$7","$16}}' >> $out
    cat $input_file | awk -F ',' -v goal="$goal" -v fw="$fw" '{if($7==fw && $16==goal){print $1","$12","$7","$16}}' >> $out
   
done
rm "uniq_goals"
cat $out