#!/usr/bin/env bash 


#SBATCH --time=01:00:00
#SBATCH --mem-per-cpu=4G
#SBATCH --cpus-per-task=1
#SBATCH --job-name=TEsorter
#SBATCH --mail-user=izabela.biedron@students.unibe.ch
#SBATCH --mail-type=begin,end
#SBATCH --output=logs/output_TEs_c_%j.o
#SBATCH --error=logs/error_TEs_c_%j.e

PROJDIR=/data 
  
EDTA=/data/users/ibiedron/assembly_annotation_course/annotation/EDTA 
singularity exec \
--bind $PROJDIR \
$PROJDIR/courses/assembly-annotation-course/containers2/TEsorter_1.3.0.sif \
TEsorter ${EDTA}/gff_simpl.fasta  -db rexdb-plant


singularity exec \
--bind $PROJDIR \
$PROJDIR/courses/assembly-annotation-course/containers2/TEsorter_1.3.0.sif \
TEsorter $PROJDIR/courses/assembly-annotation-course/CDS_annotation/Brassicaceae_repbase_all_march2019.fasta  -db rexdb-plant
