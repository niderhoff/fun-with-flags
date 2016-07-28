# ------------------------------------------------------------------------------
# Cousre: Multivariate Analysis II (SS 2016)
# ------------------------------------------------------------------------------
# Project: Fun with flags
# ------------------------------------------------------------------------------
# Description: Runs a cluster analysis using different methods on a data set of
# flags. The dataset contains various variables describing the flag design, such
# as colors, used symbols and icons, bars/stripes, etc.
# ------------------------------------------------------------------------------
# Usage: Set below number of clusters (n.cluster) and define the different
# measures for which the calculation is supposed to run (hierarch.measures).
# Gower measure, divisive clustering and PAM where not used in the project and
# their proper function is not guaranteed. Only run this file, all others will
# be automatically sourced.
# ------------------------------------------------------------------------------
# Datafile: flag data set (flagdata.txt, see 01_prepare_data.R)
# Downloadable from https://archive.ics.uci.edu/ml/datasets/Flags (UCI Machine
# Learning Repository)
# ------------------------------------------------------------------------------
# Output: The script will automatically generate a worldmap which the countries
# colored  by cluster, a heatmap of the cluster means, and a dendrogram.
# ------------------------------------------------------------------------------
# Author: Nicolas Iderhoff, last change: 2016/07/28
# ------------------------------------------------------------------------------
# Github: https://github.com/niderhoff/fun-with-flags
# ------------------------------------------------------------------------------

# Clean workspace
rm(list=ls())

# Prepare the data (labels and such)
source("01_prepare_data.R")

# Load required Libraries (vegan, cluster).
# ggplot2, ggthemes, maps, RColorBrewer, dendextend are sourced from others
# files.
library(vegan)
library(cluster)

# Load Functions
source("02_functions.R")

# Define: Number of clusters, Number of countries
n.cluster   = 10
n.countries = dim(dataset)[1]

# Run different measures and create experimental plots for each

hierarch.measures = c(
    "jaccard",
    "kulczynski",
    "mountford",
    "euclidean",
    "canberra",
    "manhattan"
)

pb = txtProgressBar(min = 0, max = length(hierarch.measures), style = 3)
for (i in 1:length(hierarch.measures)) {
    setTxtProgressBar(pb, i)
    current.measure = hierarch.measures[i]
    source("05_hierarchical.R")
    source("03_worldmap.R")
    source("03_heatmap.R")
    source("03_dendrogram.R")
}

# Gower
current.measure = "gower"
source("05_gower.R")
# source("03_worldmap.R")
# source("03_heatmap.R")
# source("03_dendrogram.R")

# Divisive clustering (NOT used)
# source("05_gower.R")
# current.measure = "divisive"
# div_cluster = diana(gower.measure, diss = TRUE)
# div_cut = cutree(div_cluster, k = n.cluster)
# div_clust = cbind(dat.cluster, "cluster" = div_cut)
# cluster.vector = div_cut
# cluster.table = div_clust
# source("03_worldmap.R")
# source("03_heatmap.R")
# source("03_dendrogram.R")

# PAM (NOT used)
# source("05_gower.R")
current.measure = "PAM"
pam.cluster     = pam(gower.measure, diss = T, k = n.cluster)
pam.vector      = pam.cluster$clustering
pam.clust       = cbind(dat.cluster, "cluster" = pam.vector)
cluster.vector  = pam.vector
cluster.table   = pam.clust
source("03_worldmap.R")
source("03_heatmap.R")
# TODO: dendrogram doesn't really work with PAM...
# source("03_dendrogram.R")