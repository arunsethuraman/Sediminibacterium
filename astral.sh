#!/bin/sh
#PBS -M arun@temple.edu
#PBS -l walltime=48:00:00
#PBS -l nodes=1:ppn=1
#PBS -N astral
#PBS -q big
#PBS
cd $PBS_O_WORKDIR

export PATH=$PATH:/home/tuf29140/work/DcoccGenome/standard-RAxML/
module load java

java -jar ../../../DcoccGenome/Astral/astral.5.7.5.jar -i astralinput.tre -o astraloutput.tre > astralout_1.log	
