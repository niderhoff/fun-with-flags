rm(list=ls())
source("01_prepare_data.R")

# Load Libraries
# ggplot2, ggthemes, cluster, maps, vegan

# Load Functions

# Results

## Number of clusters
n_cluster = 10 #TODO: why 10?

# Run different measures
# * Gower, Jaccard, Kulczynski, Mountford, Euclidean, Canberra, Manhatten
# As well as
# * Divisive Clustering
# * PAM

# For each generate:
# * List of cluster names (get_names())
# * Means for all clusters (get_means())
# * plt: Worldmap ("final_map.R")
# * plt: Heatmap ("heatmap.R")