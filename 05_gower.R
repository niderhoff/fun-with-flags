gower_measure = daisy(dat_cluster[,-1], metric = current_measure)
#hierarch = agnes(measure, gower_measure, diss = TRUE)
#cluster_vector = cutree(hierarch, k = n_cluster)
#cluster_table = cbind(dat_cluster, "cluster" = cluster_vector)