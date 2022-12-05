## Combine input library and 3 screens

input_1 <- "input/CRISPR_Screen_input-library-only_20180620.txt"
input_2 <- "input/CRISPR_Screen_One.txt"
input_3 <- "input/CRISPR_Screen_Three.txt"

output <- "Screen_1to3_dedup_merged.txt"

# Load input
dat_1 <- read.table(input_1, sep = "\t", header = T)
dat_2 <- read.table(input_2, sep = "\t", header = T)
dat_3 <- read.table(input_3, sep = "\t", header = T)

# Remove duplicate sgRNAs from input library and other screens
dat_1.dedup <- dat_1[! duplicated(dat_1$sgRNA), ]
dat_2.dedup <- dat_2[! duplicated(dat_2$sgRNA), ]
dat_3.dedup <- dat_3[! duplicated(dat_3$sgRNA), ]

# Select columns from dat_2 and dat_3
dat_2.dedup <- dat_2.dedup[, c(1, 5:ncol(dat_2.dedup))]
dat_3.dedup <- dat_3.dedup[, c(1, 5:ncol(dat_3.dedup))]

# Merge
merge_12 <- merge(dat_1.dedup, dat_2.dedup, by = 1)
merge_123 <- merge(merge_12, dat_3.dedup, by = 1)

# Output
write.table(merge_123, output, sep = "\t", col.names = T, row.names = F, quote = F)

