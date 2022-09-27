#!/bin/bash
#SBATCH --job-name=Homework1		                        # Job name
#SBATCH --partition=batch		                            # Partition (queue) name
#SBATCH --ntasks=1			                                # Single task job
#SBATCH --cpus-per-task=2		                            # Number of cores per task - match this to the num_threads used by BLAST
#SBATCH --mem=40gb			                                # Total memory for job
#SBATCH --time=2:00:00  		                            # Time limit hrs:min:sec
#SBATCH --output=/work/gene8940/jcu23686/log.%j			    # Location of standard output and error log files (replace cbergman with your myid)
#SBATCH --mail-user=jcu23686@uga.edu                    # Where to send mail (replace cbergman with your myid)
#SBATCH --mail-type=END,FAIL                            # Mail events (BEGIN, END, FAIL, ALL)

#set output directory variable
OUTDIR="/work/gene8940/jcu23686/homework_1/results.txt"             # output directory variable for homework1

#if output directory doesn't exist, create it
if [ ! -d $OUTDIR ]
then
    mkdir -p $OUTDIR
fi
   curl -s ftp://ftp.ensemblgenomes.org/pub/bacteria/release-37/gff3/bacteria_0_collection/escherichia_coli_str_k_12_substr_mg1655/Escherichia_coli_str_k_12_substr_mg1655.ASM584v2.37.gff3.gz | gunzip -c > ecoli_MG1655.gff
    cut -f3 ecoli_MG1655.gff|grep -c "CDS" 1> results.txt         #specifically 3rd column, count CDS in that column

