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
module load UHTS/Analysis/SeqKit/0.13.2

#path 
manual=/data/users/ibiedron/assembly_annotation_course/annotation/manual

#change directory
#cd ${manual}/flye

#cut -f1 contig_windows.blastn | sort | uniq -c | sort -k1,1 -n | tail -n 50 | cut -f7 -d ' ' > top_contig_windows.txt

#before the next step, save the 50-most abundant files in a new fasta file
#seqkit grep -n -f top_contig_windows.txt contig_windows.fasta -o contig_windows_TOP50.fasta



#change directory
cd ${manual}/canu

#before the next step, save the 50-most abundant files in a new fasta file
#cut -f1 contig_windows.blastn | sort | uniq -c | sort -k1,1 -n | tail -n 50 | cut -f3 > top_contig_windows.txt

#save 50 most abundant 500bp-windows into new fasta file
seqkit grep -n -f top_contig_windows.txt contig_windows.fasta -o contig_windows_TOP50.fasta
