#!/bin/bash

# This script should NOT be modified by non expert users. Modifying it is quote risky so watch out!

if [ $# -lt 5 ]; then
	echo "Usage: ./merger.sh <dataset-root> <month> <section> <first-class> <second-class> [ <third-class> <fourth-class> ]"
	
	exit -1
fi

if [ $# -gt 7 ]; then
	echo "Usage: ./merger.sh <dataset-root> <month> <section> <first-class> <second-class> [ <third-class> <fourth-class> ]"
	
	exit -1
fi

month=$2
section=$3

counter=4
shellCommand=""
classes=""
numberOfFeatures=0

while [ $counter -le $# ]; do
	shellCommand=$1"/ClassPatientFiles/"${!counter}"_"$month"_section_"$section".csv "
	
	numberOfFeatures=$(awk -F ',' 'BEGIN{print "count", "lineNum"}{print gsub(/,/,"") "\t" NR}' $shellCommand | awk 'NR==2' | awk '{print $1}')
	
	let numberOfFeatures=$numberOfFeatures-1
	
	break
done

shellCommand="cat "

while [ $counter -le $# ]; do
	shellCommand=$shellCommand$1"/ClassPatientFiles/"${!counter}"_"$month"_section_"$section".csv "
	classes=$classes${!counter}
	
	if [ $counter -lt $# ]; then
		classes=${classes}"vs"
	fi
	
	let counter=$counter+1
done

shellCommand=${shellCommand}" >> "$1"/ClassifierFiles/Month_"$month"/"$classes"_"$month"_section_"$section".csv"

counter=1
variables="patientId,"

while [ $counter -le $numberOfFeatures ]; do
	variables=$variables"f"$counter","
	
	let counter=$counter+1
done

variables="echo "$variables"class >> "$1"/ClassifierFiles/Month_"$month"/"$classes"_"$month"_section_"$section".csv"

eval $variables
eval $shellCommand

echo $1"/ClassifierFiles/Month_"$month"/"$classes"_"$month"_section_"$section".csv wrote successfully."
