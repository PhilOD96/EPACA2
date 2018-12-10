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
read users

if [ $users -gt 50 ]
then 
	echo "Users must not exceed 50"
	exit
fi

for i in {1..5}
do
	./loadtest $t $users &

while [ $i -le $users ]
do
	sleep $t
	echo "$users..."
	let "i++"
done

idle=$(mpstat -P 1 $t $i | awk 'END{print $NF}')

pkill loadtest

util=$(wc -l < synthetic.dat)

echo "$util"		"$i"		"$idle" >> results.dat

done
echo "Done"
