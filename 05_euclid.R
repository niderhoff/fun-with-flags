# Hierarchical Cluster Analysis using the Euclidean Measure

# Requirements: library(vegan)

euclid_measure = vegdist(bin_dat, method="euclidean")
euclid_hclust = hclust(euclid_measure)

# plot(euclid_hclust,
#      main = c("euclid proximity measure & hierarchical algorithm"),
#      hang = -1)

euclid_cut = cutree(euclid_hclust, k = n_cluster)
euclid_clust = cbind(dat_cluster, "cluster" = euclid_cut)