#!/usr/bin/env bash 


#SBATCH --time=01:00:00
#SBATCH --mem-per-cpu=10G
#SBATCH --cpus-per-task=1
#SBATCH --job-name=maTE11
#SBATCH --mail-user=izabela.biedron@students.unibe.ch
#SBATCH --mail-type=begin,end
#SBATCH --output=logs/output_maTE11_c_%j.o
#SBATCH --error=logs/error_maTE11_c_%j.e

module load Emboss/EMBOSS/6.6.0
manual=/data/users/ibiedron/assembly_annotation_course/annotation/manual
cons -sequence ${manual}/flye/window.bed.fa -outseq ${manual}/flye/TE1_family.cons -name TE1_cons