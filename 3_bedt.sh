#!/usr/bin/env bash 


#SBATCH --time=01:00:00
#SBATCH --mem-per-cpu=4G
#SBATCH --cpus-per-task=1
#SBATCH --job-name=bed
#SBATCH --mail-user=izabela.biedron@students.unibe.ch
#SBATCH --mail-type=begin,end
#SBATCH --output=logs/output_bed_c_%j.o
#SBATCH --error=logs/error_bed_c_%j.e


module add UHTS/Analysis/BEDTools/2.29.2

EDTA=/data/users/ibiedron/assembly_annotation_course/annotation/EDTA
PILON=/data/users/ibiedron/assembly_annotation_course/results/polishing/pilon/flye
#extract the TE sequences from the genome assembly with bedtools
bedtools getfasta -s -nameOnly -fi ${PILON}/pilon.fasta -bed ${EDTA}/pilon.fasta.mod.EDTA.gff3_new -fo ${EDTA}/gff_simpl.fasta
