# TODO: documentation, bug below
library(reshape2)
library(ggplot2)
library(ggthemes)

print(paste(
    "Generating heatmap for", capwords(current_measure), "measure", sep = " ")
)

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

# FIXME: this doesn't work (discrete scale error)
# ggplot(cluster_melt, aes(name, variable)) +
#     geom_tile(aes(fill = value), colour = "white") +
#     scale_fill_manual(values = c("0" = "white", "1" = "blue")) +
#     facet_grid(. ~ cluster, scale = "free") +
#     theme(axis.text.x = element_text(angle = 330,
#                                      hjust = 0,
#                                      colour = "grey50"))

# Means only
means = as.data.frame(get_means(cluster_table))
colnames(means) = 1:length(colnames(means))
means = cbind("variable" = rownames(means), means)

means_melt = melt(means, id.vars = 1)
colnames(means_melt) = c("variable", "cluster", "value")
# Was ist das?
grp <- rep(c(1,1,2,2,2,2,2,2,2,3,3,3,3,3,4,4,4,4,4), n_cluster)
means_melt = cbind(means_melt, grp)
means_melt$variable = factor(
    means_melt$variable,
    levels = manual_levels,
    ordered = T
    )

path = paste("figures/", current_measure, "_heatmap.pdf", sep="")
pdf(path, width = 44, paper = "a4r")
print(ggplot(means_melt,
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