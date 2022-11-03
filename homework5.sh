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
OUTDIR="/work/gene8940/jcu23686/homework5"             # replace cbergman in the following line with your myid
KALLISTODIR="/work/gene8940/jcu23686/homework5/kallisto5"

#if output directory doesn't exist, create it
if [ ! -d $OUTDIR ]
then
    mkdir -p $OUTDIR
fi

if [ ! -d $KALLISTODIR ]
then
  mkdir -p $KALLISTODIR
fi

curl https://ftp.ncbi.nlm.nih.gov/genomes/all/GCF/000/005/845/GCF_000005845.2_ASM584v2/GCF_000005845.2_ASM584v2_cds_from_genomic.fna.gz | gunzip -c > $OUTDIR/ecoli_MG1655_refseq_cds.fa

module load kallisto/0.46.1-foss-2019b
kallisto index -i $OUTDIR/ecoli_MG1655_refseq_cds.fa.idx $OUTDIR/ecoli_MG1655_refseq_cds.fa

for i in SRR5344681 SRR5344682 SRR5344683 SRR5344684
do
  kallisto quant -t 6 -b 100 -i $OUTDIR/ecoli_MG1655_refseq_cds.fa.idx -o $KALLISTODIR/$i /work/gene8940/instructor_data/${i}_1.fastq.gz /work/gene8940/instructor_data/${i}_2.fastq.gz
done

source activate R
R --no-save <$HOME/BINF8940/homework5.r
