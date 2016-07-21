#!/bin/bash

# This script should NOT be modified by non expert users. Modifying it is quote risky so watch out!

if [ $# -lt 2 ]; then
	echo "Usage: ./generateClassifierFiles.sh <dataset-root> <section> [ <section> ... <section> ]"
	
	exit -1
fi

eval "mkdir -p "$1"/ClassifierFiles/Month_6"
eval "rm -rf "$1"/ClassifierFiles/Month_6/*"

eval "mkdir -p "$1"/ClassifierFiles/Month_12"
eval "rm -rf "$1"/ClassifierFiles/Month_12/*"

eval "mkdir -p "$1"/ClassifierFiles/Month_18"
eval "rm -rf "$1"/ClassifierFiles/Month_18/*"

eval "mkdir -p "$1"/ClassifierFiles/Month_24"
eval "rm -rf "$1"/ClassifierFiles/Month_24/*"

eval "mkdir -p "$1"/ClassifierFiles/Month_36"
eval "rm -rf "$1"/ClassifierFiles/Month_36/*"

counter=2

while [ $counter -le $# ]; do
	./merger.sh $1 6 ${!counter} AD LMCI
	./merger.sh $1 6 ${!counter} AD LMCI MCI
	./merger.sh $1 6 ${!counter} AD LMCI MCI CN
	./merger.sh $1 6 ${!counter} AD LMCI CN
	./merger.sh $1 6 ${!counter} AD MCI
	./merger.sh $1 6 ${!counter} AD MCI CN
	./merger.sh $1 6 ${!counter} AD CN
	./merger.sh $1 6 ${!counter} LMCI MCI
	./merger.sh $1 6 ${!counter} LMCI MCI CN
	./merger.sh $1 6 ${!counter} LMCI CN
	./merger.sh $1 6 ${!counter} MCI CN
	
	./merger.sh $1 12 ${!counter} AD LMCI
	./merger.sh $1 12 ${!counter} AD LMCI MCI
	./merger.sh $1 12 ${!counter} AD LMCI MCI CN
	./merger.sh $1 12 ${!counter} AD LMCI CN
	./merger.sh $1 12 ${!counter} AD MCI
	./merger.sh $1 12 ${!counter} AD MCI CN
	./merger.sh $1 12 ${!counter} AD CN
	./merger.sh $1 12 ${!counter} LMCI MCI
	./merger.sh $1 12 ${!counter} LMCI MCI CN
	./merger.sh $1 12 ${!counter} LMCI CN
	./merger.sh $1 12 ${!counter} MCI CN
	
	./merger.sh $1 18 ${!counter} LMCI MCI
	
	./merger.sh $1 24 ${!counter} AD LMCI
	./merger.sh $1 24 ${!counter} AD LMCI MCI
	./merger.sh $1 24 ${!counter} AD LMCI MCI CN
	./merger.sh $1 24 ${!counter} AD LMCI CN
	./merger.sh $1 24 ${!counter} AD MCI
	./merger.sh $1 24 ${!counter} AD MCI CN
	./merger.sh $1 24 ${!counter} AD CN
	./merger.sh $1 24 ${!counter} LMCI MCI
	./merger.sh $1 24 ${!counter} LMCI MCI CN
	./merger.sh $1 24 ${!counter} LMCI CN
	./merger.sh $1 24 ${!counter} MCI CN
	
	./merger.sh $1 36 ${!counter} LMCI MCI
	./merger.sh $1 36 ${!counter} LMCI MCI CN
	./merger.sh $1 36 ${!counter} LMCI CN
	./merger.sh $1 36 ${!counter} MCI CN
	
	let counter=$counter+1
done
