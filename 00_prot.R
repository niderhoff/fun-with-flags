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
n_countries = 194 #TODO: dynamic

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

# Plot Worldmap

# Plot Heatmap

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
