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
OUTDIR="/work/gene8940/jcu23686/homework3"

#if output directory doesn't exist, create it
if [ ! -d $OUTDIR ]
then
    mkdir -p $OUTDIR
fi

cd $OUTDIR
module load canu/1.9-GCCcore-8.3.0-Java-11
module load SPAdes/3.14.1-GCC-8.3.0-Python-3.7.4
module load QUAST/5.0.2-foss-2019b-Python-3.7.4
module load MUMmer/3.23_conda

curl -s ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCF/000/005/845/GCF_000005845.2_ASM584v2/GCF_000005845.2_ASM584v2_genomic.fna.gz | gunzip -c> e_coli_MG1655.fna
canu -p ecoli -d $OUTDIR/canu genomeSize=4.8m useGRID=false -pacbio-raw /work/gene8940/jcu23686/homework3/ecoli_p6_25x.filtered.fastq.gz #I copied the files from instructor_data to my work directory
spades.py -t 6 -k 21,33,55,77 --isolate --memory 40 -1 s_6_1.fastq.gz -2 s_6_2.fastq.gz -o $OUTDIR/spades
quast.py -t -6 -r e_coli_MG1655.fna $OUTDIR/canu/ecoli.contigs.fasta $OUTDIR/spades/scaffolds.fasta
nucmer e_coli_MG1655.fna canu/ecoli.contigs.fasta -p $OUTDIR/mummer
delta-filter -1 $OUTDIR/mummer.delta > $OUTDIR/mummer.1delta
