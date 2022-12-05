# CRISPR-screen-preprocessing
## Step 1. Analyze sequencing data with count_spacers.py for sgRNA representation
This script was used to count the number of each detected sgRNA from the library from each sample of populations including before sort (before sort), non-eater(P5), good-eater(Q2). The format looks as below, in which the first column is the sgRNA target sequence, the second is the read count number:

|sgRNA spacer sequence|count|
|---------------------|-----|
|AAAAAAAAAAAATGCATTCT|10|
|AAAAAAAAATAAGCTCACCC|18|
|AAAAAAAATCCTGTCGCCCA|60|

## Step 2. Annotation of the read count table
Using R command merge(),the information of gene id, gene symbol and NM id was extracted from “broadgpp-brie-library-contents.txt” to annotate read count of each sgRNA target sequence from the step 1. 

## Step 3. Combine read count tables from the same CRISPR screening experiment
By using the same R command merge(), combine read counts of different populations from the same CRISPR screening experiment into one file.

## Step 4. Process CRISPR screening counts
(Process_1.R) Obtain gRNA count of input library by following step 1-3. Calculate percent abundance of each gRNA in the input library {(individual gRNA count)/(Total gRNA count)}, and identify gRNAs in the lowest 5th percentile in at least one or >=4 of the PCR amplified sub-libraries.

## Step 5. Combined input libraries and 2 screens.
Process_2.R

## Step 6. Remove low-abundance gRNAs from all screening samples.
(Process_3.R) Use the list created from step 4 to filter out low-abundance gRNAs from all screening samples.

## Step 7. Remove gRNAs that might have been contaminated by validation plasmids
|sgRNA spacer sequence|gene|
|---------------------|-----|
|AGATAACGCTGCCCGCAGAG|Traf2|	
|AGGAAGGTGGTCATTCAGAC|Atl3|	
|CAGGTTCACGTGCTGTACCG|Traf3|	
|CGGACCAGGCCTTTACATGC|Traf2|	
|GAAGTATCAAAGAACCAACC|Racgap1|
|GAGATCGCGGAACAAAACCC|Trib2|
|GATGCACAGCGCGGAAAACG|Trib2|	
|TAGCAACATCAACCAAATCA|Trib2|	
|TGGACGTGGAGATCAAGCGG|Racgap1|
