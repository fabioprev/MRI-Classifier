#!/bin/bash

if [ $# -lt 3 ]; then
	echo "Usage: ./merger.sh <section> <first-class> <second-class> [ <third-class> <fourth-class> ]"
	
	exit -1
fi

if [ $# -gt 5 ]; then
	echo "Usage: ./merger.sh <section> <first-class> <second-class> [ <third-class> <fourth-class> ]"
	
	exit -1
fi

section=$1

counter=2
shellCommand=""
classes=""
numberOfFeatures=0

while [ $counter -le $# ]; do
	shellCommand="ClassPatientFiles/"${!counter}"_section_"$section".csv "
	
	numberOfFeatures=$(awk -F ',' 'BEGIN{print "count", "lineNum"}{print gsub(/,/,"") "\t" NR}' $shellCommand | awk 'NR==2' | awk '{print $1}')
	
	let numberOfFeatures=$numberOfFeatures-1
	
	break
done

shellCommand="cat "

while [ $counter -le $# ]; do
	shellCommand=$shellCommand"ClassPatientFiles/"${!counter}"_section_"$section".csv "
	classes=$classes${!counter}
	
	if [ $counter -lt $# ]; then
		classes=${classes}"vs"
	fi
	
	let counter=$counter+1
done

shellCommand=${shellCommand}">> ClassifierFiles/"$classes"_section_"$section".csv"

counter=1
variables="patientId,"

while [ $counter -le $numberOfFeatures ]; do
	variables=$variables"f"$counter","
	
	let counter=$counter+1
done

variables="echo "$variables"class >> ClassifierFiles/"$classes"_section_"$section".csv"

eval $variables
eval $shellCommand

echo "ClassifierFiles/"$classes"_section_"$section".csv wrote successfully."
