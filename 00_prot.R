rm(list=ls())
source("01_prepare_data.R")
source("02_functions.R")

# Load Libraries
# ggplot2, ggthemes, cluster, maps, vegan
library(vegan)

# Load Functions

# Results

## Number of clusters
n_cluster = 10 #TODO: why 10?

# Run different measures
# * Gower, Jaccard, Kulczynski, Mountford, Euclidean, Canberra, Manhatten
source("05_jaccard.R")
cluster_vector = jaccard_cut # cluster numbers (index by row)
cluster_table = jaccard_clust # full table incl. cluster nos
#get_means(jaccard_clust)
#get_names(jaccard_clust)

# As well as
# * Divisive Clustering
# * PAM

# For each generate:
# * List of cluster names (get_names())
# * Means for all clusters (get_means())
# * plt: Worldmap ("final_map.R")
# * plt: Heatmap ("heatmap.R")