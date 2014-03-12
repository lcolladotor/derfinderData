#!/bin/sh

# Directories
MAINDIR=/dcs01/lieber/ajaffe/Brain/derRuns/derfinderData/extdata/
WDIR=${MAINDIR}/thout
DATADIR=${MAINDIR}/simulatedFasta

# Define variables
P=4
TRANSINDEX=/amber2/scratch/jleek/iGenomes-index/Homo_sapiens/UCSC/hg19/Annotation/Transcriptome/known
GENOMEINDEX=/amber2/scratch/jleek/iGenomes-index/Homo_sapiens/UCSC/hg19/Sequence/Bowtie2Index/genome

# Change to data dir
cd ${DATADIR}

# Construct shell files
cat paired.txt | while read x
	do
	cd ${WDIR}
	libname=$(echo "$x" | cut -f3)
	# Setting paired file names
	file1=$(echo "$x" | cut -f1)
	file2=$(echo "$x" | cut -f2)
	# Actually create the script
	echo "Creating script for ${libname}"
	cat > ${WDIR}/.${libname}.th.sh <<EOF
#!/bin/bash	
echo "**** Job starts ****"
date

# run tophat
# defaults for polyester::simulate_experiment() are 100 bp paired reads from 250bp fragments with 25bp sd
tophat -p ${P} --transcriptome-index=${TRANSINDEX} --mate-inner-dis=50 --mate-std-dev=25 -o ${libname} ${GENOMEINDEX} ${DATADIR}/${file1} ${DATADIR}/${file2}

mv ${WDIR}/${libname}.* ${WDIR}/${libname}/
echo "**** Job ends ****"
date
EOF
	call="qsub -cwd -l jabba,mem_free=100G,h_vmem=30G,h_fsize=10G -pe local $P -N ${libname}.th -m e ${WDIR}/.${libname}.th.sh"
	echo $call
	$call
done
