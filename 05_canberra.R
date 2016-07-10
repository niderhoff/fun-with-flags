# Hierarchical Cluster Analysis using the Canberra Measure

# Requirements: library(vegan)

canberra_measure = vegdist(bin_dat, method="canberra")
canberra_hclust = hclust(canberra_measure)

# plot(canberra_hclust,
#      main = c("canberra proximity measure & hierarchical algorithm"),
#      hang = -1)

canberra_cut = cutree(canberra_hclust, k = n_cluster)
canberra_clust = cbind(dat_cluster, "cluster" = canberra_cut)