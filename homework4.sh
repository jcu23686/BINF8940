#!/bin/bash
#SBATCH --job-name=BLAST-test		                        # Job name
#SBATCH --partition=batch		                            # Partition (queue) name
#SBATCH --ntasks=1			                                # Single task job
#SBATCH --cpus-per-task=6		                            # Number of cores per task - match this to the num_threads used by BLAST
#SBATCH --mem=40gb			                                # Total memory for job
#SBATCH --time=12:00:00  		                            # Time limit hrs:min:sec
#SBATCH --output=/work/gene8940/jcu23686/log.%j			    # Location of standard output and error log files (replace cbergman with your myid)
#SBATCH --mail-user=jcu23686@uga.edu                    # Where to send mail (replace cbergman with your myid)
#SBATCH --mail-type=END,FAIL                            # Mail events (BEGIN, END, FAIL, ALL)

#set output directory variable
OUTDIR="/work/gene8940/jcu23686/homework4"             # replace cbergman in the following line with your myid

#if output directory doesn't exist, create it
if [ ! -d $OUTDIR ]
then
    mkdir -p $OUTDIR
fi

cd $OUTDIR

module load SRA-Toolkit/2.11.1-centos_linux64
module load BWA/0.7.17-GCC-8.3.0
module load SAMtools/1.10-GCC-8.3.0
module load BCFtools/1.10.2-GCC-8.3.0

prefetch -O /work/gene8940/jcu23686/homework4/ SRR8082143
fastq-dump --split-files --gzip /work/gene8940/jcu23686/homework4/SRR8082143 -O /work/gene8940/jcu23686/homework4
curl -s ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCF/000/005/845/GCF_000005845.2_ASM584v2/GCF_000005845.2_ASM584v2_genomic.fna.gz | gunzip -c > GCF_000005845.fna
bwa index GCF_000005845.fna
bwa mem -t 6 GCF_000005845.fna SRR8082143_1.fastq.gz SRR8082143_2.fastq.gz | samtools view - -O BAM | samtools sort - > SRR8082143.sorted.bam
samtools index -@ 6 SRR8082143.sorted.bam
bcftools mpileup -Oz --threads 6 --min-MQ 60 -f GCF_000005845.fna SRR8082143.sorted.bam > SRR8082143.sorted.mpileup.vcf.gz
bcftools call -Oz -m -v --threads 6 --ploidy 1 SRR8082143.sorted.mpileup.vcf.gz > SRR8082143.sorted.mpileup.call.vcf.gz
bcftools filter -Oz -e 'QUAL<40 || DP<10' SRR8082143.sorted.mpileup.call.vcf.gz > SRR8082143.sorted.mpileup.call.filter.vcf.gz
bcftools index SRR8082143.sorted.mpileup.call.filter.vcf.gz
