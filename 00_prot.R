# TODO: header
# Clean workspace
rm(list=ls())

# Prepare the data (labels and such)
source("01_prepare_data.R")

# Load required Libraries
# ggplot2, ggthemes, cluster, maps, vegan
library(vegan)

# Load Functions
source("02_functions.R")

# Define: Number of clusters, Number of countries
n_cluster = 10 #TODO: why 10?
n_countries = 194 #TODO: dynamic

# Run different measures and create experimental plots for each

hierarch_measures = c(
    "jaccard",
    "kulczynski",
    "mountford",
    "euclidean",
    "canberra",
    "manhattan"
)

pb <- txtProgressBar(min = 0, max = length(hierarch_measures), style = 3)
for (i in 1:length(hierarch_measures)) {
    setTxtProgressBar(pb, i)
    current_measure = hierarch_measures[i]
    source("05_hierarchical.R")
    source("03_worldmap.R")
    source("03_heatmap.R")
    source("03_dendrogram.R")
}

# Gower
# source("05_gower.R")
# cluster_vector = gower_cut
# cluster_table = gower_clust
# source("03_worldmap.R")
# source("03_heatmap.R")

# Divisive clustering
# source("05_gower.R")
# div_cluster = diana(gower_measure, diss = T)
# div_cut = cutree(div_cluster, k = n_cluster)
# div_clust = cbind(dat_cluster, "cluster" = div_cut)
# cluster_vector = div_cut
# cluster_table = div_clust
# source("03_worldmap.R")
# source("03_heatmap.R")

# PAM
# source("05_gower.R")
# pam_cluster = pam(gower_measure, diss = T, k = n_cluster)
# pam_vector = pam_cluster$clustering
# pam_clust = cbind(dat_cluster, "cluster" = pm_vector)
# cluster_vector = pam_vector
# cluster_table = pam_clust
# source("03_worldmap.R")
# source("03_heatmap.R")
