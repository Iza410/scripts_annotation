#!/usr/bin/env bash 


#SBATCH --time=01:00:00
#SBATCH --mem-per-cpu=10G
#SBATCH --cpus-per-task=1
#SBATCH --job-name=maTE8
#SBATCH --mail-user=izabela.biedron@students.unibe.ch
#SBATCH --mail-type=begin,end
#SBATCH --output=logs/output_maTE8_c_%j.o
#SBATCH --error=logs/error_maTE8_c_%j.e

#path 
my_data=/data/users/ibiedron/assembly_annotation_course/results/polishing/pilon
manual=/data/users/ibiedron/assembly_annotation_course/annotation/manual

#akw
awk '$10 < $9 {print($2"\t"$10-1"\t"$9)}' ${manual}/flye/te_window.blastn > ${manual}/flye/te_window.bed
awk '$10 > $9 {print($2"\t"$9-1"\t"$10)}' ${manual}/flye/te_window.blastn >> ${manual}/flye/te_window.bed
awk '$10 < $9 {print($2"\t"$10-1"\t"$9)}' ${manual}/canu/te_window.blastn > ${manual}/canu/te_window.bed
awk '$10 > $9 {print($2"\t"$9-1"\t"$10)}' ${manual}/canu/te_window.blastn >> ${manual}/canu/te_window.bed
