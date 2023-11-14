mkdir withprimer
#check primer present and filtered reads without primer
for i in *.fastq; 
do usearch -search_oligodb $i -db primer.txt -strand both -matchedfq withprimer/${i:0:-5}withprimer.fastq ; 
done

#sync fw and reverse
mkdir sync; cd $_
##define array with file names
list1=($(ls *R1*))
list2=($(ls *R2*))
##declare array length
len=${#list1[@]}

##loop array list of file names to perform read label sync
for ((i=0; i<$len; i++)); do usearch -fastx_syncpairs ${list1[$i]} -reverse ${list2[$i]} -output sync/${list1[$i]} -output2 sync/${list2[$i]}; done

#trim primer
mkdir trim
for i in *.R1.clean.withprimer.fastq; do
site=${i:0:-26}
cutadapt -g TCCACTAATCACAARGATATTGGTAC -a GCTCATGCCTTCATTATGATTTTC -n 2 --cores 20 -o trim/$site.R1.trim.fastq $i
done

for i in *.R2.clean.withprimer.fastq; do
site=${i:0:-26}
cutadapt -g GAAAATCATAATGAAGGCATGAGC -a GTACCAATATCXTTGTGATTAGTGGA -n 2 --cores 20 -o trim/$site.R2.trim.fastq $i
done
