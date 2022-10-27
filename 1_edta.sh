#!/usr/bin/env bash 


#SBATCH --time=05:00:00
#SBATCH --mem-per-cpu=10G
#SBATCH --cpus-per-task=30
#SBATCH --job-name=edta
#SBATCH --mail-user=izabela.biedron@students.unibe.ch
#SBATCH --mail-type=begin,end
#SBATCH --output=logs/output_ed_c_%j.o
#SBATCH --error=logs/error_ed_c_%j.e


cd /data/users/ibiedron/assembly_annotation_course/annotation/EDTA
PROJDIR=/data 
  
singularity exec \
--bind $PROJDIR $PROJDIR/courses/assembly-annotation-course/containers2/EDTA_v1.9.6.sif EDTA.pl \
--threads 4 \
--genome $PROJDIR/users/ibiedron/assembly_annotation_course/results/polishing/pilon/flye/pilon.fasta \
--step all \
--species others \
--cds $PROJDIR/users/ibiedron/assembly_annotation_course/annotation/EDTA/TAIR10_cds_20110103_representative_gene_model \
--anno 1 