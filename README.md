# Sediminibacterium

This folder contains all relevant scripts and files to replicate (1) assembly, (2) annotation, and (3) phylogenomic analyses from the manuscript titled "Genome of a novel Sediminibacterium discovered in association with two species of freshwater cyanobacteria from streams in Southern California" by Sethuraman et al., 2022. biorxiv: https://doi.org/10.1101/2021.08.20.457134

1) run_tellink.sh
2) run_tellread.sh
3) Folders "CH" and "LY" contain the completely assembled Sediminibacterium genome(s) (CH_contigs.fasta and LY_contigs.fasta), after running the TelSeq pipeline, along with the YAML files utilized in running the PGAP annotation. 
4) Folder "Phylogeny" contains all the multiple sequence alignments from BLASTP runs with single copy hits, utilized in (1) running RAXML (see torq1.txt, and torq1.sh), and thereon, (2) reconstructing the phylogenomic species tree using ASTRAL (astral.sh).

For any queries regarding these analyses, please write to asethuraman@sdsu.edu




