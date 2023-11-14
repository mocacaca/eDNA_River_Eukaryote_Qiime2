#!/bin/bash

trainpath="/home/cpl/edna/illumina/MergeAtQ2/try_skip_orient/MIDORITraining/"
outpath="/home/cpl/edna/illumina/qiime2/"

constax \
--num_threads 60 \
--mem 700000 \
--input ${outpath}qiime2_q20_otu.fasta \
--db /home/cpl/edna/illumina/MergeAtQ2/try_skip_orient/MIDORI2_LONGEST_NUC_GB250_CO1_SintaxtoSilva.fasta \
--trainfile ${trainpath} \
--tax ${outpath}qiime_otu_q20/ \
--output ${outpath}qiime_otu_q20/ \
--conf 0.8 \
--blast \
--pathfile /home/cpl/edna/illumina/MergeAtQ2/try_skip_orient/pathfile.txt &
