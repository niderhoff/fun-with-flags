# General Code for generating hierarchical clustering through 'vegan' library

# Requirements: library(vegan)
measure = vegdist(bin_dat, method=current_measure)
hierarch = hclust(measure)

# plot(hierarch,
#      main = c("Jaccard proximity measure & hierarchical algorithm"),
#      hang = -1)

cluster_vector = cutree(hierarch, k = n_cluster)
cluster_table = cbind(dat_cluster, "cluster" = cluster_vector)