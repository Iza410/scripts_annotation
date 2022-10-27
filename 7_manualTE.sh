#!/usr/bin/env bash 


#SBATCH --time=01:00:00
#SBATCH --mem-per-cpu=10G
#SBATCH --cpus-per-task=1
#SBATCH --job-name=maTE7
#SBATCH --mail-user=izabela.biedron@students.unibe.ch
#SBATCH --mail-type=begin,end
#SBATCH --output=logs/output_maTE7_c_%j.o
#SBATCH --error=logs/error_maTE7_c_%j.e

#load module
module load Blast/ncbi-blast/2.9.0+
module load UHTS/Analysis/SeqKit/0.13.2

#fasta file with only the te window you've chosen (window 41 for canu, 36 for flye)
#path to genome
my_data=/data/users/ibiedron/assembly_annotation_course/results/polishing/pilon
manual=/data/users/ibiedron/assembly_annotation_course/annotation/manual

#save the contigs in a new fasta file
seqkit grep -n -f ${manual}/flye/te_window.txt ${manual}/flye/contig_windows.fasta -o ${manual}/flye/te_window.fasta
seqkit grep -n -f ${manual}/canu/te_window.txt ${manual}/canu/contig_windows.fasta -o ${manual}/canu/te_window.fasta

#create genome db
makeblastdb -in ${my_data}/flye/pilon.fasta -dbtype nucl -out ${manual}/flye/blast_db/genome
makeblastdb -in ${my_data}/canu/pilon.fasta -dbtype nucl -out ${manual}/canu/blast_db/genome

#blast 
blastn -query ${manual}/flye/te_window.fasta -db ${manual}/flye/blast_db/genome -outfmt 6 -num_threads 10 -perc_identity 80 -qcov_hsp_perc 80 -max_hsps 1 > ${manual}/flye/te_window.blastn
blastn -query ${manual}/canu/te_window.fasta -db ${manual}/canu/blast_db/genome -outfmt 6 -num_threads 10 -perc_identity 80 -qcov_hsp_perc 80 -max_hsps 1 > ${manual}/canu/te_window.blastn
