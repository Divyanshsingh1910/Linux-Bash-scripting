#! /bin/bash

# This is the code for comm command

#taking the filenames
filename1=$1
filename2=$2
echo $1, $2
echo

if [ -e $filename1 ]
then
	#echo "$filename1 found yayy "
	echo
	if [ -e $filename2 ]
	then
		#echo "$filename2 found yayyy!!"
		echo "Both file found!"
		echo
		#entering the file1
		while IFS= read -r line1; do
			if [[ -n "$line1" ]]
			then
				#now entering the file2
				while IFS= read line2; do
					if [[ -n "$line2" ]]
					then
						#statements
						if [[ "$line1" == "$line2" ]]
						then 
							echo "$line1"
						fi
					fi
				done < $filename2
			fi
		done < $filename1
	else
		echo "$filename2 not found :("
	fi

else 
	echo " $filename1 not found "
fi
