# Plot Dendrogram
library(dendextend)
library(RColorBrewer)

print(paste(
    "Generating dendrogram for",
    capwords(current.measure),
    "measure",
    sep = " "
))

dendrogram = color_branches(
    dend = as.dendrogram(hierarch),
    k    = n.cluster,
#    col = brewer.pal(n.cluster, "Paired")
    col  = rep(c("tomato","slateblue"), n.cluster/2)
)

labels(dendrogram) = rep(" ", n.countries)

dendrogram = assign_values_to_branches_edgePar(
    dend = dendrogram, value = 2, edgePar = "lwd"
)

par(mar = c(4.5, 5.4, 2.3, 1.0))

path = paste("figures/", current.measure, "_dendrogram.pdf", sep="")
pdf(path, width = 44, paper = "a4r")
plot(dendrogram,
    ylab = paste(capwords(current.measure),"Similarty Coefficient",sep =" "),
    cex.lab = 1.5,
    cex.axis = 1.5)

cutoff = get_branches_heights(dendrogram, sort = T, decreasing = T)[n.cluster-1]
abline(h = cutoff, lwd = 2, lty = "dashed", col = "gray")
dev.off()

print("Done.")