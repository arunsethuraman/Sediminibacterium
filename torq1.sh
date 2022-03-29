#!/bin/sh
#PBS -M arun@temple.edu
#PBS -l walltime=48:00:00
#PBS -l nodes=2:ppn=16
#PBS -N raxmljobs
#PBS -q medium
#PBS
cd $PBS_O_WORKDIR

export PATH=$PATH:/home/tuf29140/work/DcoccGenome/standard-RAxML/
module load java

torque-launch torq1.txt
	
