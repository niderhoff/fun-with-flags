# TODO: better documentation
# x=data with cluster variable
get_means <- function(x) {
  R <- max(x$cluster)
  dat_nominal <- x[,-c(1,21)]
  dat_binary <- matrix(rep(NA, nrow(dat_nominal)*ncol(dat_nominal)), ncol=ncol(dat_nominal), nrow=nrow(dat_nominal))
  for(i in 1:ncol(dat_nominal)){
    dat_binary[,i] <- as.numeric(dat_nominal[,i])-1
  }
  dat_ready <- cbind(dat_binary, "cluster"=x$cluster)
  cluster_list <- as.list(rep(NA, R))
  list_names <- c()
  for(i in 1:R){
    dat_subset <- as.data.frame(subset(dat_ready, dat_ready[,20]==i))
    dat_subset <- dat_subset[,-20]
    colnames(dat_subset) <- names(dat_cluster[,-1])
    cluster_list[[i]] <- apply(dat_subset, 2, mean)
    list_names <- cbind(list_names, paste("cluster", i))
  }
  names(cluster_list) <- list_names
  return(cluster_list)
}

get_names <- function(cluster_vector){
  cluster_frame <- data.frame(dataset$name, cluster_vector)
  colnames(cluster_frame) <-c("name", "cluster")
  R <- max(cluster_frame$cluster)
  cluster_names_list <- as.list(rep(NA, R))
  list_names <- c()
  for(i in 1:R){
    cluster_names_list[[i]] <- cluster_frame$name[cluster_frame$cluster==i]
    list_names <- cbind(list_names, paste("cluster", i))
  }
  names(cluster_names_list) <- list_names
  return(cluster_names_list)
}