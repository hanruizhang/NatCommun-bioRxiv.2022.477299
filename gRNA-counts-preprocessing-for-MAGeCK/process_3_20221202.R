## Filter screening counts

input <- "Screen_1to3_dedup_merged.txt"
Amp_1 <- "RAW_ALL_filt_by_5pct_comb_Amp.txt"
Amp_2 <- "RAW_ALL_filt_by_5pct_comb_Amp_overlap.txt"

output_1 <- "Screen_1to3_dedup_merged_filt_by_5pct_comb_Amp.txt"
output_2 <- "Screen_1to3_dedup_merged_filt_by_5pct_comb_Amp_overlap.txt"

# gRNAs from filtered Amp libraries
gRNA_1 <- read.table(Amp_1, sep = "\t", header = T)
gRNA_2 <- read.table(Amp_2, sep = "\t", header = T)

# Load input
dat <- read.table(input, sep = "\t", header = T)

dat_1 <- dat[dat$sgRNA %in% gRNA_1$sgRNA, ]
dat_2 <- dat[dat$sgRNA %in% gRNA_2$sgRNA, ]

# Output
write.table(dat_1, output_1, sep = "\t", col.names = T, row.names = F, quote = F)
write.table(dat_2, output_2, sep = "\t", col.names = T, row.names = F, quote = F)
