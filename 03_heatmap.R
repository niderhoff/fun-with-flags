# Crate Heatmap
library(reshape2)
library(ggplot2)
library(ggthemes)

print(paste(
    "Generating heatmap for", capwords(current.measure), "measure", sep = " ")
)

# Add labels to the raw binary data table
bin.labeled = data.frame(
    "name"           = as.character(dat.cluster$name),
    bin.dat,
    "cluster"        = cluster.vector,
    stringsAsFactors = FALSE
    )
colnames(bin.labeled) = c(colnames(dat.cluster),"cluster")

# Order by Cluster
bin.labeled = bin.labeled[order(bin.labeled$cluster),]

# Put into long format for ggplot using melt()
cluster.melt   = data.frame()
cluster.levels = c()
for (i in unique(cluster.vector)) {
    clusterx      = subset(bin.labeled, cluster == i)[,1:19]
    clusterx.melt = melt(clusterx, id.vars = 1, variable_name = "name")
    clusterx.melt = cbind(clusterx.melt, "cluster" = i)
    cluster.melt  = rbind(cluster.melt,clusterx.melt)
}

# Define manual sorting order
manual.levels = c(
    "icon", "animate", "triangle", "crescent", "text",
    "sunstars", "saltires", "quarters", "crosses", "circles", "bars",
    "stripes", "red", "green", "blue", "gold", "white", "black", "orange"
)

# Manually sort factor levels with above defined order
cluster.melt$variable = factor(
    cluster.melt$variable,
    levels  = manual.levels,
    ordered = TRUE
)

# Extract the means to plot in the heatmap
means                = as.data.frame(GetMeans(cluster.table))
colnames(means)      = 1:length(colnames(means))
means                = cbind("variable" = rownames(means), means)
means.melt           = melt(means, id.vars = 1)
colnames(means.melt) = c("variable", "cluster", "value")

grp        = rep(c(1,1,2,2,2,2,2,2,2,3,3,3,3,3,4,4,4,4,4), n.cluster)
means.melt = cbind(means.melt, grp)

means.melt$variable = factor(
    means.melt$variable,
    levels  = manual.levels,
    ordered = TRUE
    )

# Generate plot
path = paste("figures/", current.measure, "_heatmap.pdf", sep="")
pdf(path, width = 44, paper = "a4r")
print(ggplot(means.melt,
             aes(cluster, variable)) +
             geom_tile(aes(fill = value)) +
             scale_fill_gradient(low = "white", high = "black") +
             scale_x_discrete(expand = c(0, 0), name = "Cluster") +
             scale_y_discrete(expand = c(0, 0), name = "Variable") +
             theme_tufte(base_size = 25) +
             scale_alpha_discrete(name = "Rel. Frequency")
)
dev.off()

print("Done.")