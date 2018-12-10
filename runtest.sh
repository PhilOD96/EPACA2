#!/bin/bash
#Asking User for runtime
echo "Enter runtime duration"
read t

if [ $t -gt 10 ]
then
	echo "Runtime must not exceed 10 ten seconds"
	exit
fi

#Asking User for amount of concurrent users to use within the loadtest script
echo "Enter number of concurrent users"
read n

if [ $n -gt 50 ]
then 
	echo "Users must not exceed 50"
	exit
fi


printf "C0\tN\tIdle\n" >> results.dat
c0=0

#I attempted to use the Users input for to loadtest based on their input but 
#the terminal returns an error with running through {1..10} or {1..15} (whichever the input is

for i in {1..50}
do
	timeout $i ./loadtest $i 
	mpstat >> stats.txt
	c0=`cat synthetic.dat | wc -l`
	printf "$c0\t$i" >> results.dat
	printf "\t" >> results.dat
	awk '{print $12}' stats.txt | tail -n1 >> results.dat | tr -d '\n'
done
echo "Done"
