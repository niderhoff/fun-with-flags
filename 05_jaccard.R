# Hierarchical Cluster Analysis using the Jaccard Measure

# Requirements: library(vegan)
current_measure = "jaccard"
jaccard_measure = vegdist(bin_dat, method=current_measure)
jaccard_hclust = hclust(jaccard_measure)

# plot(jaccard_hclust,
#      main = c("Jaccard proximity measure & hierarchical algorithm"),
#      hang = -1)

jaccard_cut = cutree(jaccard_hclust, k = n_cluster)
jaccard_clust = cbind(dat_cluster, "cluster" = jaccard_cut)