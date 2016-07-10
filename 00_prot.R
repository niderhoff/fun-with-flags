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

# Jaccard
source("05_jaccard.R")
cluster_vector = jaccard_cut # cluster numbers (index by row)
cluster_table = jaccard_clust # full table incl. cluster nos

# Kulczynski
# source("05_kulczynski.R")
# cluster_vector = kulczynski_cut
# cluster_table = kulczynski_clust

# Mountford
# source("05_mountford.R")
# cluster_vector = mountford_cut
# cluster_table = mountford_clust

# Euclidean
# source("05_euclid.R")
# cluster_vector = euclid_cut
# cluster_table = euclid_clust

# Canberra
# source("05_canberra.R")
# cluster_vector = canberra_cut
# cluster_table = canberra_clust

# Manhatten
# source("05_manhattan.R")
# cluster_vector = manhattan_cut
# cluster_table = manhattan_clust

# Gower
# source("05_gower.R")
# cluster_vector = gower_cut
# cluster_table = gower_clust

# Divisive clustering
# source("05_gower.R")
# div_cluster = diana(gower_measure, diss = T)
# div_cut = cutree(div_cluster, k = n_cluster)
# div_clust = cbind(dat_cluster, "cluster" = div_cut)
# cluster_vector = div_cut
# cluster_table = div_clust

# PAM
# source("05_gower.R")
# pam_cluster = pam(gower_measure, diss = T, k = n_cluster)
# pam_vector = pam_cluster$clustering
# pam_clust = cbind(dat_cluster, "cluster" = pm_vector)
# cluster_vector = pam_vector
# cluster_table = pam_clust

# Decide for one measure (Jaccard) and create publication ready plots

# Plot Worldmap
source("03_worldmap.R")

# Plot Heatmap
source("04_heatmap.R")

# Plot Dendrogram
library(dendextend)
library(RColorBrewer)
dendrogram = color_branches(
    dend = as.dendrogram(jaccard_hclust),
    k = n_cluster,
#    col = brewer.pal(n_cluster, "Paired")
    col = c("tomato","slateblue")
)
labels(dendrogram) = rep(" ", n_countries)
dendrogram = assign_values_to_branches_edgePar(
    dend = dendrogram, value = 2, edgePar = "lwd"
)

par(mar=c(4.5, 5.4, 2.3, 1.0))
plot(dendrogram, ylab = "Jaccard Similarty Coefficient",
     cex.lab = 1.5,
     cex.axis = 1.5)

cutoff = get_branches_heights(dendrogram, sort = T, decreasing = T)[n_cluster-1]
abline(h=cutoff, lwd = 2, lty = "dashed", col = "gray")
