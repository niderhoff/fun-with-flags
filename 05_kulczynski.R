# Hierarchical Cluster Analysis using the Kulczynski Measure

# Requirements: library(vegan)

kulczynski_measure = vegdist(bin_dat, method="kulczynski")
kulczynski_hclust = hclust(kulczynski_measure)

# plot(kulczynski_hclust,
#      main = c("Kulczynski proximity measure & hierarchical algorithm"),
#      hang = -1)

kulczynski_cut = cutree(kulczynski_hclust, k = n_cluster)
kulczynski_clust = cbind(dat_cluster, "cluster" = kulczynski_cut)