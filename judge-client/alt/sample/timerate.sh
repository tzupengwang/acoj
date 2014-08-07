for i in {0..100000}
do
	echo $RANDOM
done >tmpa
sort -n <tmpa >tmpb
