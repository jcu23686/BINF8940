#!/bin/bash
#SBATCH --job-name=BLAST-test		                        # Job name
#SBATCH --partition=batch		                            # Partition (queue) name
#SBATCH --ntasks=1			                                # Single task job
#SBATCH --cpus-per-task=6		                            # Number of cores per task - match this to the num_threads used by BLAST
#SBATCH --mem=40gb			                                # Total memory for job
#SBATCH --time=2:00:00  		                            # Time limit hrs:min:sec
#SBATCH --output=/work/gene8940/jcu23686/log.%j			    # Location of standard output and error log files (replace cbergman with your myid)
#SBATCH --mail-user=jcu23686@uga.edu                    # Where to send mail (replace cbergman with your myid)
#SBATCH --mail-type=END,FAIL                            # Mail events (BEGIN, END, FAIL, ALL)

#set output directory variable
OUTDIR="/work/gene8940/jcu23686/project1"             # replace cbergman in the following line with your myid


#if output directory doesn't exist, create it
if [ ! -d $OUTDIR ]
then
    mkdir -p $OUTDIR
fi



curl -s https://ftp.ncbi.nlm.nih.gov/genomes/all/GCF/000/001/405/GCF_000001405.40_GRCh38.p14/GCF_000001405.40_GRCh38.p14_genomic.fna.gz | gunzip -c> human.fna #data in fasta format
curl -s https://s3-us-west-2.amazonaws.com/human-pangenomics/NHGRI_UCSC_panel/HG002/hpp_HG002_NA24385_son_v1/PacBio_HiFi/15kb/m64012_190920_173625.Q20.fastq > HG002.fastq #data in fastq format
