#!/usr/bin/env bash 


#SBATCH --time=05:00:00
#SBATCH --mem-per-cpu=10G
#SBATCH --cpus-per-task=4
#SBATCH --job-name=emb
#SBATCH --mail-user=izabela.biedron@students.unibe.ch
#SBATCH --mail-type=begin,end
#SBATCH --output=logs/output_em_c_%j.o
#SBATCH --error=logs/error_em_c_%j.e

module load Emboss/EMBOSS/6.6.0
cons -sequence /data/users/ibiedron/assembly_annotation_course/annotation/manual/window.bed.fa -outseq /data/users/ibiedron/assembly_annotation_course/annotation/manual/TE1_family.cons -name TE1_cons