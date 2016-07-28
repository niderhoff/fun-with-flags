# Functions used for inclusion in other scripts

# A simple function for 'Mixed Case' capitalizing from R-Help
capwords = function(x, strict = FALSE) {
    cap = function(x) paste(
            toupper(substring(x, 1, 1)),
            {x = substring(x, 2); if(strict) tolower(x) else x },
            sep = "", collapse = " "
        )
    sapply(strsplit(x, split = " "), cap, USE.NAMES = !is.null(names(x)))
}

# x: data with cluster variable
GetMeans = function(x) {
    R = max(x$cluster)
    dat.nominal = x[,-c(1,21)]
    dat.binary  = matrix(rep(
        NA,
        nrow(dat.nominal) * ncol(dat.nominal)),
        ncol = ncol(dat.nominal),
        nrow = nrow(dat.nominal)
    )
    for(i in 1:ncol(dat.nominal)) {
        dat.binary[,i] <- as.numeric(dat.nominal[,i])-1
    }
    dat.ready    = cbind(dat.binary, "cluster" = x$cluster)
    cluster.list = as.list(rep(NA, R))
    list.names   = c()
    for(i in 1:R){
        dat.subset           = as.data.frame(subset(dat.ready,
                                                    dat.ready[,20]==i))
        dat.subset           = dat.subset[,-20]
        colnames(dat.subset) = names(dat.cluster[,-1])
        cluster.list[[i]]    = apply(dat.subset, 2, mean)
        list.names           = cbind(list.names, paste("cluster", i))
    }
    names(cluster.list) = list.names
    return(cluster.list)
}

GetNames = function(cluster.vector) {
    cluster.frame           = data.frame(dataset$name, cluster.vector)
    colnames(cluster.frame) = c("name", "cluster")
    R                       = max(cluster.frame$cluster)
    cluster.names.list      = as.list(rep(NA, R))
    list.names              = c()
    for(i in 1:R) {
        cluster.names.list[[i]] = cluster.frame$name[cluster.frame$cluster==i]
        list.names              = cbind(list.names, paste("cluster", i))
    }
    names(cluster.names.list) = list.names
    return(cluster.names.list)
}