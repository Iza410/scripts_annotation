#!/usr/bin/env bash 


#SBATCH --time=02:00:00
#SBATCH --mem-per-cpu=10G
#SBATCH --cpus-per-task=2
#SBATCH --job-name=maTE
#SBATCH --mail-user=izabela.biedron@students.unibe.ch
#SBATCH --mail-type=begin,end
#SBATCH --output=logs/output_maTE_c_%j.o
#SBATCH --error=logs/error_maTE_c_%j.e


module load UHTS/Analysis/SeqKit/0.13.2
#path
my_data=/data/users/ibiedron/assembly_annotation_course/results/polishing/pilon
manual=/data/users/ibiedron/assembly_annotation_course/annotation/manual
#for flye
seqkit fx2tab -l -n ${my_data}/flye/pilon.fasta  > ${manual}/flye_seq_len.txt #print sequences length
echo -n "flye done"

#for canu
seqkit fx2tab -l -n ${my_data}/canu/pilon.fasta > ${manual}/canu_seq_len.txt
echo -n "canu done"