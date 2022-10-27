#!/usr/bin/env bash 


#SBATCH --time=01:00:00
#SBATCH --mem-per-cpu=10G
#SBATCH --cpus-per-task=1
#SBATCH --job-name=maTE10
#SBATCH --mail-user=izabela.biedron@students.unibe.ch
#SBATCH --mail-type=begin,end
#SBATCH --output=logs/output_maTE10_c_%j.o
#SBATCH --error=logs/error_maTE10_c_%j.e



module load SequenceAnalysis/MultipleSequenceAlignment/clustalw2/2.1

manual=/data/users/ibiedron/assembly_annotation_course/annotation/manual

cd ${manual}/flye
clustalw2 window.bed.fa

cd ${manual}/canu
clustalw2 window.bed.fa



