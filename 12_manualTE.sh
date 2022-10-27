#!/usr/bin/env bash 


#SBATCH --time=01:00:00
#SBATCH --mem-per-cpu=10G
#SBATCH --cpus-per-task=1
#SBATCH --job-name=maTE12
#SBATCH --mail-user=izabela.biedron@students.unibe.ch
#SBATCH --mail-type=begin,end
#SBATCH --output=logs/output_maTE12_c_%j.o
#SBATCH --error=logs/error_maTE12_c_%j.e

module load Blast/ncbi-blast/2.9.0+

#set directories
manual=/data/users/ibiedron/assembly_annotation_course/annotation/manual
bras=/data/courses/assembly-annotation-course/CDS_annotation

#create db for library
cd ${manual}
mkdir blast_db

makeblastdb -in ${bras}/Brassicaceae_repbase_all_march2019.fasta -dbtype nucl -out ${manual}/blast_db/library

#blast the consensus sequence against the library
blastn -query ${manual}/flye/TE1_family.cons -db ${manual}/blast_db/library -outfmt 6 -num_threads 10 -max_hsps 1 > ${manual}/flye/te1_element.blastn
