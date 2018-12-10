#!/bin/bash

use=0

for i in {1..5}
do
	timeout $i ./loadtest $i 
	mpstat >> stats.txt
	use=`cat synthetic.dat | wc -l`
	printf "$use\t$i" >> results.dat
	printf "\t" >> results.dat
	awk '{print $12}' stats.txt | tail -n1 >> results.dat | tr -d '\n'
done

echo "Done"

