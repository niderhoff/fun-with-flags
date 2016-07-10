# Hierarchical Cluster Analysis using the Mountford Measure

# Requirements: library(vegan)

mountford_measure = vegdist(bin_dat, method="mountford")
mountford_hclust = hclust(mountford_measure)

# plot(mountford_hclust,
#      main = c("mountford proximity measure & hierarchical algorithm"),
#      hang = -1)

mountford_cut = cutree(mountford_hclust, k = n_cluster)
mountford_clust = cbind(dat_cluster, "cluster" = mountford_cut)