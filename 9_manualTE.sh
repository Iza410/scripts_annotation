#!/usr/bin/env bash 


#SBATCH --time=01:00:00
#SBATCH --mem-per-cpu=10G
#SBATCH --cpus-per-task=1
#SBATCH --job-name=maTE9
#SBATCH --mail-user=izabela.biedron@students.unibe.ch
#SBATCH --mail-type=begin,end
#SBATCH --output=logs/output_maTE9_c_%j.o
#SBATCH --error=logs/error_maTE9_c_%j.e

module load UHTS/Analysis/SeqKit/0.13.2
#path 
my_data=/data/users/ibiedron/assembly_annotation_course/results/polishing/pilon
manual=/data/users/ibiedron/assembly_annotation_course/annotation/manual


seqkit subseq --bed ${manual}/flye/te_window.bed ${my_data}/flye/pilon.fasta -u 2000 -d 2000 > ${manual}/flye/window.bed.fa

seqkit subseq --bed ${manual}/canu/te_window.bed ${my_data}/canu/pilon.fasta -u 2000 -d 2000 > ${manual}/canu/window.bed.fa