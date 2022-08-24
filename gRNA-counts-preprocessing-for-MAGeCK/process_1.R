## Process CRISPR screening counts
## Filter gRNAs using Amp library counts

input_1 <- "input/RAW-ALL_Screen-One-Read-Count_20171023_clean.txt"
output_1 <- "RAW_ALL_filt_by_5pct_comb_Amp.txt"
output_2 <- "RAW_ALL_filt_by_5pct_comb_Amp_overlap.txt"

# Load input
dat <- read.table(input_1, sep = "\t", header = T)
mat <- as.matrix(dat[, -1:-4])

# Bottom 5th percentile count for each library
count.5pct <- apply(mat, 2, function(x) quantile(x, 0.05))

# gRNAs with counts <=5th percentile count in each library
low.idx <- apply(mat, 2, function(x) which(x <= quantile(x, 0.05)))
low.gRNA <- lapply(low.idx, function(x) dat$sgRNA[x])

# gRNAs with low count in any Amp libraries
low.gRNA.Amp <- unlist(low.gRNA[grep("Amp", names(low.gRNA))], use.names = F)
low.gRNA.Amp.tab = table(low.gRNA.Amp)

# gRNAs with low count in >=4 Amp libraries
low.gRNA.Amp.ge4 = names(low.gRNA.Amp.tab)[low.gRNA.Amp.tab >=4]


# Bottom 5th percentile from combined Amp libraries
mat.Amp.comb <- rowSums(mat[, grep("Amp", colnames(mat))])
count.Amp.comb.5pct <- quantile(mat.Amp.comb, 0.05)

low.gRNA.comb <- dat$sgRNA[mat.Amp.comb <= count.Amp.comb.5pct]

# Output 1
# Exclude gRNAs with low counts in combined library
dat.filtered.1 <- dat[! dat$sgRNA %in% low.gRNA.comb, ]
write.table(dat.filtered.1, output_1, sep = "\t", col.names = T, row.names = F, quote = F)

# Output 2
# Exclude gRNAs with low counts in combined library and with low counts in >=4 individual libraries
dat.filtered.2 <- dat[! dat$sgRNA %in% intersect(low.gRNA.comb, low.gRNA.Amp.ge4), ]
write.table(dat.filtered.2, output_2, sep = "\t", col.names = T, row.names = F, quote = F)

