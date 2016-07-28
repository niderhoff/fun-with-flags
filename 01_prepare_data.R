# Prepare the flag dataset to be usable in the analysis

# Read dataset, thereby defining which variables are factors
dataset = read.table(
    file       = "./flagdata.txt",
    sep        = ",",
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
levels(dataset$icon)[2]     = "Inanimate"
levels(dataset$animate)[2]  = "Animate"
levels(dataset$text)[2]     = "Text"

# Set all others to "Else"
levels(dataset$crescent)[1] =
levels(dataset$triangle)[1] =
levels(dataset$icon)[1]     =
levels(dataset$animate)[1]  =
levels(dataset$text)[1]     = "Else"

# Create a subet with the columns we are interested in
dat.cluster = dataset[,
    !(names(dataset) %in% c(
        "landmass", "zone", "area", "population", "language", "religion",
        "colours", "mainhue", "topleft", "botright"
        ))
    ]

# Convert numeric variables to binary factors
# TODO: rewrite using lapply
dat.cluster$bars[dat.cluster$bars > 0]         = 1
dat.cluster$stripes[dat.cluster$stripes > 0]   = 1
dat.cluster$circles[dat.cluster$circles > 0]   = 1
dat.cluster$crosses[dat.cluster$crosses > 0]   = 1
dat.cluster$saltires[dat.cluster$saltires > 0] = 1
dat.cluster$quarters[dat.cluster$quarters > 0] = 1
dat.cluster$sunstars[dat.cluster$sunstars > 0] = 1

dat.cluster$bars = factor(dat.cluster$bars,
                          labels=c("No Bars", "Bars"))
dat.cluster$stripes = factor(dat.cluster$stripes,
                             labels=c("No Stripes", "Stripes"))
dat.cluster$circles = factor(dat.cluster$circles,
                             labels=c("No Circles", "Circles"))
dat.cluster$crosses = factor(dat.cluster$crosses,
                             labels=c("No Crosses", "Crosses"))
dat.cluster$saltires = factor(dat.cluster$saltires,
                              labels=c("No Saltires", "Saltires"))
dat.cluster$quarters = factor(dat.cluster$quarters,
                              labels=c("No Quarters", "Quarters"))
dat.cluster$sunstars = factor(dat.cluster$sunstars,
                              labels=c("No Sunstars", "Sunstars"))

# Binary matrix for later usage
# TODO: this is really bad & ugly.
bin.dat <- matrix(rep(NA, 19*194), ncol=19, nrow=194)
for (i in 2:ncol(dat.cluster)){
    bin.dat[,i-1] <- as.numeric(dat.cluster[,i])-1
}

