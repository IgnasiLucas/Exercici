if (!require("BiocManager", quietly = TRUE))
    install.packages("BiocManager")
BiocManager::install("DECIPHER")
install.packages(c('curl', 'plyr', 'taxize', 'rhmmer'))
