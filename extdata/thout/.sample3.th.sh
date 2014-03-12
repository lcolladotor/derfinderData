#!/bin/bash	
echo "**** Job starts ****"
date

# run tophat
# defaults for polyester::simulate_experiment() are 100 bp paired reads from 250bp fragments with 25bp sd
tophat -p 4 --transcriptome-index=/amber2/scratch/jleek/iGenomes-index/Homo_sapiens/UCSC/hg19/Annotation/Transcriptome/known --mate-inner-dis=50 --mate-std-dev=25 -o sample3 /amber2/scratch/jleek/iGenomes-index/Homo_sapiens/UCSC/hg19/Sequence/Bowtie2Index/genome /dcs01/lieber/ajaffe/Brain/derRuns/derfinderData/extdata/simulatedFasta/sample_03_1.fasta.gz /dcs01/lieber/ajaffe/Brain/derRuns/derfinderData/extdata/simulatedFasta/sample_03_2.fasta.gz

mv /dcs01/lieber/ajaffe/Brain/derRuns/derfinderData/extdata/thout/sample3.* /dcs01/lieber/ajaffe/Brain/derRuns/derfinderData/extdata/thout/sample3/
echo "**** Job ends ****"
date
