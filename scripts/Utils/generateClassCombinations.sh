#!/bin/bash

# This script should NOT be modified by non expert users. Modifying it is quite risky so watch out!

# This script outputs all possible combinations between classes found in <dataset-root>. The generation of CSV
# files for the classifier is left to the user because it depends on the file format. An example can be found
# in the directory ADNI or in OASIS.

if [ $# -ne 1 ]; then
	echo "Usage: ./generateClassifierFiles.sh <dataset-root>"
	
	exit -1
fi

classes=$(cd $1 && ls -d */ | cut -f1 -d'/')
size=$(echo "$classes" | wc -w)
index=0

while IFS=' ' read -ra ADDR; do
	for i in "${ADDR[@]}"; do
		classArray[index]=$i
		
		let index=${index}+1
	done
done <<< "$classes"

if [ ${#classArray[@]} -lt 2 ]; then
	echo "Found only one class ["${classArray[0]}"]. In order to generate all possible combinations between classes, two or more classes are needed. Exiting..."
	
	exit 0
fi

index=0

for i in "${classArray[@]}"
do
	for j in "${classArray[@]}"
	do
		if [ "$i" != "$j" ]; then
			found=0
			
			for k in "${combinations[@]}"
			do
				found=0
				
				tokens=$(echo $k | tr "vs" "\n")
				
				for w in $tokens
				do
					if [ "$i" == "$w" ]; then
						let found=$found+1
					fi
					
					if [ "$j" == "$w" ]; then
						let found=$found+1
					fi
				done
				
				if [ $found -eq 2 ]; then
					break
				fi
			done
			
			if [ $found -lt 2 ]; then
				combinations[index]=$i"vs"$j
				
				let index=$index+1
			fi
		fi
	done
done

counter=2

let size=$size-1

while [ $counter -lt $size ]; do
	let maxClasses=$counter+1
	
	for i in "${classArray[@]}"
	do
		for k in "${combinations[@]}"
		do
			found=0
			
			tokens=$(echo $k | tr "vs" "\n")
			
			sizeTokens=0
			
			for w in $tokens
			do
				let sizeTokens=$sizeTokens+1
			done
			
			if [ $sizeTokens -lt $counter ]; then
				continue
			fi
			
			for w in $tokens
			do
				if [ "$i" == "$w" ]; then
					found=1
					
					break
				fi
			done
			
			if [ $found -eq 0 ]; then
				temp=$i"vs"$k
				
				for j in "${combinations[@]}"
				do
					found=0
					
					tokens=$(echo $j | tr "vs" "\n")
					
					for w in $tokens
					do
						let falsePositive=1
						
						if echo "$temp" | grep -q "$w"
						then
							grepResult=$(echo "$temp" | grep -o "$w")
							
							tokens2=$(echo $temp | tr "vs" "\n")
							tokens3=$(echo $grepResult | tr "vs" "\n")
							
							for t in $tokens2
							do
								for t2 in $tokens3
								do
									if [ "$t" == "$t2" ]; then
										falsePositive=0
										
										break
									fi
								done
							done
							
							if [ $falsePositive -eq 0 ]; then
								let found=$found+1
							fi
						fi
					done
					
					if [ $found -eq $maxClasses ]; then
						break
					fi
				done
				
				if [ $found -lt $maxClasses ]; then
					combinations[index]=$temp
					
					let index=$index+1
				fi
			fi
		done
	done
	
	let counter=$counter+1
done

if [ ${#classArray[@]} -gt 2 ]; then
	temp=""
	counter=0
	
	for i in "${classArray[@]}"
	do
		temp=$temp$i
		
		if [ $counter -lt $size ]; then
			temp=$temp"vs"
		fi
		
		let counter=$counter+1
	done
	
	combinations[index]=$temp
fi

for i in "${combinations[@]}"
do
	echo $i
done
