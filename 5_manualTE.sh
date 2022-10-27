#!/usr/bin/env bash 


#SBATCH --time=01:00:00
#SBATCH --mem-per-cpu=10G
#SBATCH --cpus-per-task=1
#SBATCH --job-name=maTE5
#SBATCH --mail-user=izabela.biedron@students.unibe.ch
#SBATCH --mail-type=begin,end
#SBATCH --output=logs/output_maTE5_c_%j.o
#SBATCH --error=logs/error_maTE5_c_%j.e


#load module
module load Blast/ncbi-blast/2.9.0+

#set directories
manual=/data/users/ibiedron/assembly_annotation_course/annotation/manual

#change directory and make blast_db directory
cd ${manual}/flye
mkdir blast_db

makeblastdb -in contig_windows.fasta -dbtype nucl -out blast_db/contig_windows

blastn -query contig_windows.fasta -db blast_db/contig_windows -num_threads 10 -outfmt 6 -perc_identity 80 \
-max_hsps 1 > contig_windows.blastn

#change directory and make blast_db directory
cd ${manual}/canu
mkdir blast_db
makeblastdb -in contig_windows.fasta -dbtype nucl -out blast_db/contig_windows

blastn -query contig_windows.fasta -db blast_db/contig_windows -num_threads 10 -outfmt 6 -perc_identity 80 \
-max_hsps 1 > contig_windows.blastn