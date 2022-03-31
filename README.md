# Sediminibacterium

This folder contains all relevant scripts and files to replicate (1) assembly, (2) annotation, and (3) phylogenomic analyses from the manuscript titled "Genome of a novel Sediminibacterium discovered in association with two species of freshwater cyanobacteria from streams in Southern California" by Sethuraman et al., 2022. biorxiv: https://doi.org/10.1101/2021.08.20.457134

1) run_tellink.sh
2) run_tellread.sh
3) Folders "CH" and "LY" contain the completely assembled Sediminibacterium genome(s) (CH_contigs.fasta and LY_contigs.fasta), after running the TelSeq pipeline, along with the YAML files utilized in running the PGAP annotation. 
4) Folder "Phylogeny" contains all the multiple sequence alignments from BLASTP runs with single copy hits, utilized in (1) running RAXML (see torq1.txt, and torq1.sh), and thereon, (2) reconstructing the phylogenomic species tree using ASTRAL (astral.sh).


# The sequence data were processed using the "Tell_Seq" data analysis software (https://www.universalsequencing.com/analysis-tools).
# 1. The Tell-Read pipeline takes as input the NGS sequencing data and generates linked-read FASTQ files, as well as QC reports
# The Tell-Read pipeline was run separately for the CH lib (T507) and LY lib (T508) sequencing data. The output FASTAQ files were
# stored in the "/data/tellread-release/runT507" and "/data/tellread-release/runT508" directories respectively.
# The used parameter to the Tell-Read pipeline were
# -i		This specifies the path to the raw data directory.
# -o		This specifies output directory that the results will be. 
# -s		This is a sample index list. 
# -g 		This is a genome reference list. It was set to NONE for the sequencing data.
run_tellread.sh -i /data/tellread-release/200907_NS500704_0850_AHF7VFAFX2/ -s T507 -o /data/tellread-release/runT507 -g NONE
run_tellread.sh -i /data/tellread-release/200907_NS500704_0850_AHF7VFAFX2/ -s T508 -o /data/tellread-release/runT508 -g NONE

# 2. The Tell-Link pipeline takes as input the FASTQ files generated in step 1, build barcode-aware assembly graphes, assembles
# contigs and performs scaffolding. 
# The Tell-Link pipeline was run separately for the CH lib (T507) and LY lib (T508) as following.
# The used parameters to the Tell-Link pipeline were 
# -r1		This parameter specifies read 1 fastq file in gz compressed format.
# -r2		This parameter specifies read 2 fastq file in gz compressed format.
# -i1		This parameter specifies index 1 fastq file in gz compressed format.
# -k		This parameter specifies k-mer length for constructing global assembly graph
# -lc		This parameter specifies local k-mer length for constructing local assembly graph.
# -o		This parameter specifies the output directory
run_tellink.sh -r1 /data/tellread-release/runT507/Full/runT507_R1_T507.fastq.gz.corrected.fastq.err_barcode_removed.fastq.gz \\
   -r2 /data/tellread-release/runT507/Full/runT507_R2_T507.fastq.gz.corrected.fastq.err_barcode_removed.fastq.gz \\
   -i1 /data/tellread-release/runT507/Full/runT507_I1_T507.fastq.gz.corrected.fastq.err_barcode_removed.fastq.gz \\
   -o CH -k 55 -lc 31 

run_tellink.sh -r1 /data/tellread-release/runT508/Full/runT508_R1_T508.fastq.gz.corrected.fastq.err_barcode_removed.fastq.gz \\
   -r2 /data/tellread-release/runT508/Full/runT508_R2_T508.fastq.gz.corrected.fastq.err_barcode_removed.fastq.gz \\
   -i1 /data/tellread-release/runT508/Full/runT508_I1_T508.fastq.gz.corrected.fastq.err_barcode_removed.fastq.gz \\
   -o LY -k 55 -lc 31 
   
# 3. The NCBI Prokaryotic Genome Annotation Pipeline (PGAP) is designed to annotate bacterial and archaeal genomes.
# The PGAP pipeline was run for the CH and LY assembly generated in step 2 separately as following. 
# The used parameters to the PGAP pipeline were 
# -o				Output directory to be created.
# --ignore-all-errors   Ignore errors from quality control analysis, in order to obtain a draft annotation.
# -d				Debug mode
# -r 				Set the report_usage flag in the YAML to true.
# The input.yaml files were created for CH and LY genomes, in which the genus_species parameter was set to 'Sediminibacterium'

python pgap.py -o CH_contigs/ --ignore-all-errors -d -r /data/pgap/test_genomes/CH/input.yaml
python pgap.py -o LY_contigs/ --ignore-all-errors -d -r /data/pgap/test_genomes/LY/input.yaml

For any queries regarding these analyses, please write to asethuraman@sdsu.edu




