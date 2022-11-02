#!/usr/bin/env bash 


#SBATCH --time=00:20:00
#SBATCH --mem-per-cpu=2G
#SBATCH --cpus-per-task=1
#SBATCH --job-name=inf
#SBATCH --mail-user=izabela.biedron@students.unibe.ch
#SBATCH --mail-type=begin,end
#SBATCH --output=logs/output_inf_c_%j.o
#SBATCH --error=logs/error_inf_c_%j.e


EDTA=/data/users/ibiedron/assembly_annotation_course/annotation/EDTA
# count the families of transposables that were found 
grep -c -e ">" ${EDTA}/pilon.fasta.mod.EDTA.TElib.fa 
#  934 families

# count the intact ones 
grep -v LTR ${EDTA}/pilon.fasta.mod.EDTA.intact.gff3 |wc
# 841

# count the repeat regions 
grep LTR ${EDTA}/pilon.fasta.mod.EDTA.intact.gff3|awk '$3=="repeat_region"'|wc -l 
# 224

awk '$3~/retrotransposon/' ${EDTA}/pilon.fasta.mod.EDTA.TEanno.gff3 >${EDTA}/pilon.fasta.mod.EDTA.TEanno.gff3_edited

##add remaining DNA transposons to new gff
grep -v LTR ${EDTA}/pilon.fasta.mod.EDTA.TEanno.gff3 >> ${EDTA}/pilon.fasta.mod.EDTA.TEanno.gff3_edited

#simplify TE identifiers and swap columns 3 and 9
#class
sed 's/\;Classification.*//' ${EDTA}/pilon.fasta.mod.EDTA.TEanno.gff3_edited > ${EDTA}/pilon.fasta.mod.EDTA.gff3_classification
#name
sed 's/ID.*Name\=//' ${EDTA}/pilon.fasta.mod.EDTA.gff3_classification > ${EDTA}/pilon.fasta.mod.EDTA.gff3_name
#col
awk -F'\t' -v OFS="\t" '{print $1, $2, $9, $4, $5, $6, $7, $8, $3}' ${EDTA}/pilon.fasta.mod.EDTA.gff3_name > ${EDTA}/pilon.fasta.mod.EDTA.gff3_columns
#new
sed 's/\_pi.*\tEDTA/\_pilon\tEDTA/' ${EDTA}/pilon.fasta.mod.EDTA.gff3_columns > ${EDTA}/pilon.fasta.mod.EDTA.gff3_new
