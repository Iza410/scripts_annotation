#!/usr/bin/env bash 


#SBATCH --time=01:00:00
#SBATCH --mem-per-cpu=10G
#SBATCH --cpus-per-task=1
#SBATCH --job-name=maTE3
#SBATCH --mail-user=izabela.biedron@students.unibe.ch
#SBATCH --mail-type=begin,end
#SBATCH --output=logs/output_maTE3_c_%j.o
#SBATCH --error=logs/error_maTE3_c_%j.e


#load module
module load UHTS/Analysis/SeqKit/0.13.2

#path to genome
my_data=/data/users/ibiedron/assembly_annotation_course/results/polishing/pilon
manual=/data/users/ibiedron/assembly_annotation_course/annotation/manual
#save the contigs in a new fasta file
seqkit grep -n -f ${manual}/longest_flye.txt ${my_data}/flye/pilon.fasta -o ${manual}/flye/f_contig.fasta
seqkit grep -n -f ${manual}/longest_canu.txt ${my_data}/canu/pilon.fasta -o ${manual}/canu/c_contig.fasta
