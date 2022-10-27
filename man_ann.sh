#!/usr/bin/env bash 


#SBATCH --time=05:00:00
#SBATCH --mem-per-cpu=10G
#SBATCH --cpus-per-task=4
#SBATCH --job-name=ma
#SBATCH --mail-user=izabela.biedron@students.unibe.ch
#SBATCH --mail-type=begin,end
#SBATCH --output=logs/output_ma_c_%j.o
#SBATCH --error=logs/error_ma_c_%j.e

module load UHTS/Analysis/SeqKit/0.13.2
seqkit fx2tab -l -n /data/users/ibiedron/assembly_annotation_course/results/polishing/pilon/flye/pilon.fasta > all_l.txt #print sequences length
sort -k2 -n -r all_l.txt > all_l_sorted.txt
#id.txt contig_467_pilon /1150570 not in the file/
seqkit grep -f id.txt /data/users/ibiedron/assembly_annotation_course/results/polishing/pilon/flye/pilon.fasta -o contig.fa #extract sequence from genome
seqkit sliding -s 500 -W 500 -g contig.fa > contig_windows.fa

module load Blast/ncbi-blast/2.9.0+
mkdir blast_db #create directory for blast databases

makeblastdb -in contig_windows.fa -dbtype nucl -out blast_db/contig_windows

blastn -query contig_windows.fa -db blast_db/contig_windows -num_threads 10 -outfmt 6 -perc_identity 80 -max_hsps 1 > contig_windows.blastn
#sort -k 1 contig_windows.blastn |tail -n 50 > contigs_50.txt
#sort -k1 contig_windows.blastn > contig_windows_sorted.blastn

seqkit grep -n -f id.txt contig_windows.fa -o contig_windows_TOP50.fa #empty file
####DO THE PLOT when file will be created!!!!!!!!!!!!!!!!!!!!
makeblastdb -in /data/users/ibiedron/assembly_annotation_course/results/polishing/pilon/flye/pilon.fasta -dbtype nucl -out blast_db/flye_genome

blastn -query contig_windows.fa -db blast_db/flye_genome -outfmt 6 -num_threads 10 -perc_identity 80 -qcov_hsp_perc 80 -max_hsps 1 > contig_windows.blastn

awk '$10 < $9 {print($2"\t"$10-1"\t"$9)}' contig_windows.blastn > window.bed
awk '$10 > $9 {print($2"\t"$9-1"\t"$10)}' contig_windows.blastn >> window.bed

seqkit subseq --bed window.bed /data/users/ibiedron/assembly_annotation_course/results/polishing/pilon/flye/pilon.fasta -u 2000 -d 2000 > window.bed.fa

module load SequenceAnalysis/MultipleSequenceAlignment/clustalw2/2.1
clustalw2 window.bed.fa 
#ERROR: Multiple sequences found with same name (found contig_444_pilon_306246-306742_._us_2000_ds_2000 at least twice)!
#but file is created

#visualize alignment with https://www.jalview.org/jalview-js/JalviewJS/ - doesn't work

module load Emboss/EMBOSS/6.6.0 #as script
cons -sequence window.bed.fa -outseq TE1_family.cons -name TE1_cons #empty file