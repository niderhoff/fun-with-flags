# NOT used
gower.measure = daisy(dat.cluster[,-1], metric = current.measure)
#hierarch = agnes(measure, gower.measure, diss = TRUE)
#cluster.vector = cutree(hierarch, k = n.cluster)
#cluster.table = cbind(dat.cluster, "cluster" = cluster.vector)