#!/usr/bin/env bash 


#SBATCH --time=01:00:00
#SBATCH --mem-per-cpu=10G
#SBATCH --cpus-per-task=2
#SBATCH --job-name=maTE2
#SBATCH --mail-user=izabela.biedron@students.unibe.ch
#SBATCH --mail-type=begin,end
#SBATCH --output=logs/output_maTE2_c_%j.o
#SBATCH --error=logs/error_maTE2_c_%j.e


manual=/data/users/ibiedron/assembly_annotation_course/annotation/manual
#sorting, save the longest contig
sort -k2 -n -r ${manual}/canu_seq_len.txt | head  -10 > ${manual}/longest_canu.txt
sort -k2 -n -r ${manual}/flye_seq_len.txt | head  -10 > ${manual}/longest_flye.txt

