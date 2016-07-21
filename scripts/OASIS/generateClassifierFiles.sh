#!/bin/bash

if [ $# -lt 1 ]; then
	echo "Usage: ./generateClassifierFiles.sh <section> [ <section> ... <section> ]"
	
	exit -1
fi

counter=1

eval "mkdir -p ClassifierFiles"
eval "rm -rf ClassifierFiles/*"

while [ $counter -le $# ]; do
	./merger.sh ${!counter} AD LMCI
	./merger.sh ${!counter} AD LMCI MCI
	./merger.sh ${!counter} AD LMCI MCI CN
	./merger.sh ${!counter} AD LMCI CN
	./merger.sh ${!counter} AD MCI
	./merger.sh ${!counter} AD MCI CN
	./merger.sh ${!counter} AD CN
	./merger.sh ${!counter} LMCI MCI
	./merger.sh ${!counter} LMCI MCI CN
	./merger.sh ${!counter} LMCI CN
	./merger.sh ${!counter} MCI CN
	
	let counter=$counter+1
done
