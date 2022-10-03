#!/bin/bash
#SBATCH --job-name=BLAST-test		                        # Job name
#SBATCH --partition=batch		                            # Partition (queue) name
#SBATCH --ntasks=1			                                # Single task job
#SBATCH --cpus-per-task=2		                            # Number of cores per task - match this to the num_threads used by BLAST
#SBATCH --mem=40gb			                                # Total memory for job
#SBATCH --time=2:00:00  		                            # Time limit hrs:min:sec
#SBATCH --output=/work/gene8940/jcu23686/log.%j			    # Location of standard output and error log files (replace cbergman with your myid)
#SBATCH --mail-user=jcu23686@uga.edu                    # Where to send mail (replace cbergman with your myid)
#SBATCH --mail-type=END,FAIL                            # Mail events (BEGIN, END, FAIL, ALL)

#set output directory variable
OUTDIR="/work/gene8940/jcu23686/homework2"

#if output directory doesn't exist, create it
if [ ! -d $OUTDIR ]
then
    mkdir -p $OUTDIR
fi

# load modules
module load BEDOPS/2.4.39-foss-2019b
module load BEDTools/2.29.2-GCC-8.3.0
module load SAMtools/1.10-GCC-8.3.0
module load ucsc/359

curl -s ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCF/000/005/845/GCF_000005845.2_ASM584v2/GCF_000005845.2_ASM584v2_genomic.gff.gz | gunzip -c> e_coli_MG1655.gff
convert2bed --input=gff < e_coli_MG1655.gff > e_coli_MG1655.bed
grep -i "CDS" e_coli_MG1655.bed > CDS_e_coli_MG1655.bed
grep CDS e_coli_MG1655.bed > e_coli_MG1655.CDS.bed #might be better
curl -s ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCF/000/005/845/GCF_000005845.2_ASM584v2/GCF_000005845.2_ASM584v2_genomic.fna.gz | gunzip -c> e_coli_MG1655.fna
samtools faidx e_coli_MG1655.fna
cut -f1,2 e_coli_MG1655.fna.fai > e_coli_MG1655.genome.txt
bedtools complement -i e_coli_MG1655.CDS.bed -g e_coli_MG1655.genome.txt > e_coli_MG1655_intergenic.bed
bedtools getfasta -fi e_coli_MG1655.fna -bed e_coli_MG1655.CDS.bed > e_coli_MG1655_CDS.fna
bedtools getfasta -fi e_coli_MG1655.fna -bed e_coli_MG1655_intergenic.bed > e_coli_MG1655_intergenic.fna
faCount -summary e_coli_MG1655_CDS.fna > e_coli_MG1655_Stats.bed
cut -f1,4,5 e_coli_MG1655_Stats.bed > e_coli_MG1655_finalStats.bed
faCount -summary e_coli_MG1655_intergenic.fna > e_coli_MG1655_intergenic_Stats.bed 
cut -f1,4,5 e_coli_MG1655_intergenic_Stats.bed > e_coli_MG1655_intergenic_finalStats.bed
