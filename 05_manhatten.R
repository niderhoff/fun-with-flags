# Hierarchical Cluster Analysis using the Manhattan Measure

# Requirements: library(vegan)

manhattan_measure = vegdist(bin_dat, method="manhattan")
manhattan_hclust = hclust(manhattan_measure)

# plot(manhattan_hclust,
#      main = c("Manhattan proximity measure & hierarchical algorithm"),
#      hang = -1)

manhattan_cut = cutree(manhattan_hclust, k = n_cluster)
manhattan_clust = cbind(dat_cluster, "cluster" = manhattan_cut)