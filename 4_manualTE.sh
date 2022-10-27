#!/usr/bin/env bash 


#SBATCH --time=01:00:00
#SBATCH --mem-per-cpu=10G
#SBATCH --cpus-per-task=1
#SBATCH --job-name=maTE4
#SBATCH --mail-user=izabela.biedron@students.unibe.ch
#SBATCH --mail-type=begin,end
#SBATCH --output=logs/output_maTE4_c_%j.o
#SBATCH --error=logs/error_maTE4_c_%j.e

#load module
module load UHTS/Analysis/SeqKit/0.13.2

#path to genome
manual=/data/users/ibiedron/assembly_annotation_course/annotation/manual

#canu
seqkit sliding -s 500 -W 500 -g ${manual}/canu/c_contig.fasta > ${manual}/canu/contig_windows.fasta
#flye
seqkit sliding -s 500 -W 500 -g ${manual}/flye/f_contig.fasta > ${manual}/flye/contig_windows.fasta
