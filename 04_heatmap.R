# TODO: documentation, bug below
library(reshape2)
library(ggplot2)

# Add labels to the raw binary data table
bin_labeled = data.frame(
    "name" = as.character(dat_cluster$name),
    bin_dat,
    "cluster" = cluster_vector,
    stringsAsFactors = F
    )
colnames(bin_labeled) = c(colnames(dat_cluster),"cluster")

# Order by Cluster
bin_labeled = bin_labeled[order(bin_labeled$cluster),]

# Put into long format for ggplot using melt()
cluster_melt = data.frame()
cluster_levels = c()
for (i in unique(cluster_vector)) {
    clusterx = subset(bin_labeled, cluster == i)[,1:19]
    clusterx_melt = melt(clusterx, id.vars = 1, variable_name = "name")
    clusterx_melt = cbind(clusterx_melt, "cluster" = i)
    cluster_melt = rbind(cluster_melt,clusterx_melt)
}

# Sort manually

manual_levels = c(
    "icon", "animate", "triangle", "crescent", "text",
    "sunstars", "saltires", "quarters", "crosses", "circles", "bars",
    "stripes", "red", "green", "blue", "gold", "white", "black", "orange"
)

cluster_melt$variable = factor(
    cluster_melt$variable,
    levels = manual_levels,
    ordered = T
)

# Plot the chloropleth
# FIXME: this doesn't work (discrete scale error)
ggplot(cluster_melt, aes(name, variable)) +
    geom_tile(aes(fill = value), colour = "white") +
    scale_fill_manual(values = c("0" = "white", "1" = "blue")) +
    facet_grid(. ~ cluster, scale = "free") +
    theme(axis.text.x = element_text(angle = 330,
                                     hjust = 0,
                                     colour = "grey50"))

# Means only