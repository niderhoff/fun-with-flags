# Data preparation

# Read dataset, thereby defining which variables are factors
dataset = read.table(
    file = "./flagdata.txt",
    sep = ",",
    colClasses = c(
        'factor','factor','factor','integer','integer','factor',
        'factor','integer','integer','integer','factor','factor','factor',
        'factor','factor','factor','factor','factor','integer','integer',
        'integer','integer','integer','factor','factor','factor','factor',
        'factor','factor','factor'
        )
)

# Install human-readable column names
colnames(dataset) = c(
    "name", "landmass", "zone", "area", "population",
    "language", "religion", "bars", "stripes", "colours",
    "red", "green", "blue", "gold", "white", "black",
    "orange", "mainhue", "circles", "crosses", "saltires",
    "quarters", "sunstars", "crescent", "triangle", "icon",
    "animate", "text", "topleft", "botright"
    )

# Put proper labels on the factor variables
levels(dataset$language) = c(
    "English", "Spanish", "French", "German",
    "Slavic", "Other Indo-European", "Chinese",
    "Arabic", "Japanese/Turkish/Finnish/Magyar",
    "Others"
    )

levels(dataset$landmass) = c(
    "N.America", "S.America", "Europe", "Africa",
    "Asia", "Oceania"
    )

levels(dataset$zone) = c("NE", "SE", "SW", "NW")

levels(dataset$religion)=c(
    "Catholic", "Other Christian", "Muslim", "Buddhist", "Hindu", "Ethnic",
    "Marxist", "Others"
    )

levels(dataset$blue) = levels(dataset$green) = levels(dataset$red) =
levels(dataset$gold) = levels(dataset$white) = levels(dataset$black) =
levels(dataset$orange) = c("Absent", "Present")

levels(dataset$crescent)[2] = "Moon"
levels(dataset$triangle)[2] = "Triangle"
levels(dataset$icon)[2] = "Inanimate"
levels(dataset$animate)[2] = "Animate"
levels(dataset$text)[2] = "Text"
levels(dataset$crescent)[1] =
levels(dataset$triangle)[1] =
levels(dataset$icon)[1] =
levels(dataset$animate)[1] =
levels(dataset$text)[1] = "Else"

# Create a subet with the columns we are interested in
dat_cluster = dataset[,
    !(names(dataset) %in% c(
        "landmass", "zone", "area", "population", "language", "religion",
        "colours", "mainhue", "topleft", "botright"
        ))
    ]

# Convert numeric variables to binary factors
# TODO: rewrite using lapply maybe?
dat_cluster$bars[dat_cluster$bars > 0] = 1
dat_cluster$stripes[dat_cluster$stripes > 0] = 1
dat_cluster$circles[dat_cluster$circles > 0] = 1
dat_cluster$crosses[dat_cluster$crosses > 0] = 1
dat_cluster$saltires[dat_cluster$saltires > 0] = 1
dat_cluster$quarters[dat_cluster$quarters > 0] = 1
dat_cluster$sunstars[dat_cluster$sunstars > 0] = 1

dat_cluster$bars = factor(dat_cluster$bars,
                          labels=c("No Bars", "Bars"))
dat_cluster$stripes = factor(dat_cluster$stripes,
                             labels=c("No Stripes", "Stripes"))
dat_cluster$circles = factor(dat_cluster$circles,
                             labels=c("No Circles", "Circles"))
dat_cluster$crosses = factor(dat_cluster$crosses,
                             labels=c("No Crosses", "Crosses"))
dat_cluster$saltires = factor(dat_cluster$saltires,
                              labels=c("No Saltires", "Saltires"))
dat_cluster$quarters = factor(dat_cluster$quarters,
                              labels=c("No Quarters", "Quarters"))
dat_cluster$sunstars = factor(dat_cluster$sunstars,
                              labels=c("No Sunstars", "Sunstars"))

# TODO: this is really bad & ugly.
# Binary matrix for later usage(?)
bin_dat <- matrix(rep(NA, 19*194), ncol=19, nrow=194)
for (i in 2:ncol(dat_cluster)){
    bin_dat[,i-1] <- as.numeric(dat_cluster[,i])-1
}

