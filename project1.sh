#!/bin/bash
#SBATCH --job-name=BLAST-test		                        # Job name
#SBATCH --partition=batch		                            # Partition (queue) name
#SBATCH --ntasks=1			                                # Single task job
#SBATCH --cpus-per-task=10		                            # Number of cores per task - match this to the num_threads used by BLAST
#SBATCH --mem=24gb			                                # Total memory for job
#SBATCH --time=8:00:00  		                            # Time limit hrs:min:sec
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

cd $OUTDIR
qlogin

module load QUAST/5.0.2-foss-2019b-Python-3.7.4

#assembly1
#wget https://data.nist.gov/od/ds/ark:/88434/mds2-2578/assemblies-and-benchmarking_results/asm1.tar.gz
#tar -xvzf asm1.tar.gz
#quast asm1/assembly/Ash1v1.7.fa.gz

#assembly2ab
#wget https://data.nist.gov/od/ds/ark:/88434/mds2-2578/assemblies-and-benchmarking_results/asm2ab.tar.gz
#tar -xvzf asm2ab.tar.gz
#assembly2a
#quast asm2ab/assembly/asm2a/Dovetail_HG002_phase1_scaffolds.fa.gz
#assembly2b
#quast asm2ab/assembly/asm2b/Dovetail_HG002_phase2_scaffolds.fa.gz

#assembly3a
#wget https://data.nist.gov/od/ds/ark:/88434/mds2-2578/assemblies-and-benchmarking_results/asm3a.tar.gz
#tar -xvzf asm3a.tar.gz
#quast asm3a/assembly/asm3a/asm.fa.gz
#assembly3bc
#wget https://data.nist.gov/od/ds/ark:/88434/mds2-2578/assemblies-and-benchmarking_results/asm3bc.tar.gz
#tar asm3bc.tar.gz
#assembly3b
#quast asm3bc/assembly/asm3b/pri_asm.fa.gz
#assembly3c
#quast asm3bc/assembly/asm3c/alt_asm.fa.gz

#assembly4a
#wget https://data.nist.gov/od/ds/ark:/88434/mds2-2578/assemblies-and-benchmarking_results/asm4a.tar.gz
#tar -xzvf asm4a.tar.gz
#quast asm4a/assembly/asm4a/asm.fa.gz
#assembly4b
#wget https://data.nist.gov/od/ds/ark:/88434/mds2-2578/assemblies-and-benchmarking_results/asm4bc.tar.gz
#tar -xzvf asm4bc.tar.gz
#quast asm4bc/assembly/asm4b/pri_asm_v2.fa.gz
#quast asm4bc/assembly/asm4c/alt_asm_v2.fa.gz

#assembly5
#wget https://data.nist.gov/od/ds/ark:/88434/mds2-2578/assemblies-and-benchmarking_results/asm5.tar.gz
#tar -xvzf asm5.tar.gz
#quast asm5/assembly/hg002.flye.scaffolds.fasta

#assembly6ab
#wget https://data.nist.gov/od/ds/ark:/88434/mds2-2578/assemblies-and-benchmarking_results/asm6ab.tar.gz
#tar xzvf asm6ab.tar.gz
#quast asm6ab/assembly/asm6a/flye.scaffolds.fasta.gz
#quast asm6ab/assembly/asm6b/flye.scaffolds.fasta.gz

#assembly 7
#wget https://data.nist.gov/od/ds/ark:/88434/mds2-2578/assemblies-and-benchmarking_results/asm7ab.tar.gz
#tar xzvf asm7ab.tar.gz
#quast asm7ab/assembly/asm7a/flye.scaffolds.fasta.gz
#quast asm7ab/assembly/asm7b/flye.scaffolds.fasta.gz

#assembly 8
#wget https://data.nist.gov/od/ds/ark:/88434/mds2-2578/assemblies-and-benchmarking_results/asm8ab.tar.gz
#tar -xzvf asm8ab.tar.gz
#quast asm8ab/assembly/asm8a/primary.fasta.gz
#quast asm8ab/assembly/asm8b/alts.fasta.gz

#assembly9
#wget https://data.nist.gov/od/ds/ark:/88434/mds2-2578/assemblies-and-benchmarking_results/asm9_05ab.tar.gz
#tar -xzvf asm9_05ab.tar.gz
#quast asm9_05ab/assembly/asm9_05b/ha4.mat.ctg.fa.gz
#quast asm9_05ab/assembly/asm9_05a/ha4.pat.ctg.fa.gz
#wget https://data.nist.gov/od/ds/ark:/88434/mds2-2578/assemblies-and-benchmarking_results/asm9ab.tar.gz
#tar -xzvf
#quast asm9ab/assembly/asm9a/DFCI_HC.hifiasm.mat.ctg.fa.gz
#quast asm9ab/assembly/asm9b/DFCI_HC.hifiasm.pat.ctg.fa.gz

#assembly 10
#wget https://data.nist.gov/od/ds/ark:/88434/mds2-2578/assemblies-and-benchmarking_results/asm10ab.tar.gz
#tar -xzvf asm10ab.tar.gz
#quast asm10ab/assembly/asm10a/DFCI_SG.dipasm-hic1a.hap1.scaf.fa.gz
#quast asm10ab/assembly/asm10b/DFCI_SG.dipasm-hic1a.hap2.scaf.fa.gz

#assembly 11
#wget https://data.nist.gov/od/ds/ark:/88434/mds2-2578/assemblies-and-benchmarking_results/asm11ab.tar.gz
#tar -xzvf asm11ab.tar.gz
quast asm11ab/assembly/asm11a/DFCI_SG.dipasm-hic1a.hap1.scaf.fa.gz
quast asm11ab/assembly/asm11b/DFCI_SG.dipasm-hic1a.hap2.scaf.fa.gz


#curl -s https://ftp.ncbi.nlm.nih.gov/genomes/all/GCF/000/001/405/GCF_000001405.40_GRCh38.p14/GCF_000001405.40_GRCh38.p14_genomic.fna.gz | gunzip -c> human.fna #data in fasta format
#curl -s https://s3-us-west-2.amazonaws.com/human-pangenomics/NHGRI_UCSC_panel/HG002/hpp_HG002_NA24385_son_v1/PacBio_HiFi/15kb/m64012_190920_173625.Q20.fastq > HG002.fastq #data in fastq format
