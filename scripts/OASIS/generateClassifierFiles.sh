#!/bin/bash

# This script should NOT be modified by non expert users. Modifying it is quite risky so watch out!

if [ $# -lt 2 ]; then
	echo "Usage: ./generateClassifierFiles.sh <dataset-root> <section> [ <section> ... <section> ]"
	
	exit -1
fi

counter=2

eval "mkdir -p "$1"/ClassifierFiles"
eval "rm -rf "$1"/ClassifierFiles/*"

while [ $counter -le $# ]; do
	./merger.sh $1 ${!counter} AD LMCI
	./merger.sh $1 ${!counter} AD LMCI MCI
	./merger.sh $1 ${!counter} AD LMCI MCI CN
	./merger.sh $1 ${!counter} AD LMCI CN
	./merger.sh $1 ${!counter} AD MCI
	./merger.sh $1 ${!counter} AD MCI CN
	./merger.sh $1 ${!counter} AD CN
	./merger.sh $1 ${!counter} LMCI MCI
	./merger.sh $1 ${!counter} LMCI MCI CN
	./merger.sh $1 ${!counter} LMCI CN
	./merger.sh $1 ${!counter} MCI CN
	
	let counter=$counter+1
done
