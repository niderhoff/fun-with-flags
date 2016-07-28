# General Code for generating hierarchical clustering through 'vegan' library

# Requirements: library(vegan)
measure        = vegdist(bin.dat, method=current.measure)
hierarch       = hclust(measure)
cluster.vector = cutree(hierarch, k = n.cluster)
cluster.table  = cbind(dat.cluster, "cluster" = cluster.vector)