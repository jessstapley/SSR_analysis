
# We will use the package 'MsatAllele' to bin the peak sizes into distinct size classes
# This is necessary to ensure we can consistently call the peak size across multiple data sets and multiple researchers

#############################################
######### Step 1 - Install the package and load the data
#############################################

# This package is no longer maintained on the CRAN website, so we need to use an archived version.
# The package (tar.gz) should be in your 'package' subdirectory

# We need to Install the package - go to Install packages and change the option to Install From 'Package Archive File' 
# Then select the archive file 'MsatAllele_1.05.tar.gz'
# When the package is installed then load the library

library(MsatAllele)

# Now we load the data file we created in the first script

db_{SSR name} <- read.ah.file("out/pos_{SSR name}.txt", date="{add date i.e 12-09-21}", plate="plate1")

#############################################
######### Step 2 - Investigate variation in peak sizes
#############################################

# Here we will plot the data to look at the sizes of the peaks.
# These two graphs are useful for visualising the variability in peak sizes.
# There is error around the peak position and the sizing is not always accurate.
# Peaks that are very close together (< 1bp difference) are really the same SSR repeat length.
# Some SSR PCR products are more variable and sometimes we need to bin them into a single size class.
# So we need to see the variation in peak positions 
# This is why this package is useful.

# Lets look at the data

par(mfrow=c(1,2))
AlleleCum(db_{SSR name} , "{SSR name}", c1="black", c2="grey", ytsize=1, psize=1, pch=1)
AlleleHist(db_{SSR name} , "{SSR name}", limits=0.01, ticks=1)

# How much spread is there for the peaks? 
# What does the distribution of peak sizes look like?
# We expect a normal distribution in pak sizes?

# We can also get the exact variation around each peak size using this function 

bs_{SSR name} <-  BinStat(db_{SSR name}, "{SSR name}")

# How many 'Bins' does this package identify?
# The distinct Bins represent the alleles - how many alleles are there in this sample?
# What is the total N - is this equal to the number of isolates?
# How many isolates have the first allele in your list ?

#############################################
######### Step 3 - Bin the peaks into distinct size classes
#############################################

bs_{SSR name} <-  BinStat(db_{SSR name}, "{SSR name}")

# read in data again as data frame 
dat <- read.table("out/pos_{SSR name}.txt")
names(dat) <- c("Sample.Name", "Colour", "Panel", "Sample.Name", "Marker", "Size.a1", "Size.a2")

bks <- c(bs_{SSR name}$Min[1]-0.001, bs_{SSR name}$Max+0.001)

dat$Bin.a1 <- cut(dat$Size.a1, breaks = bks, labels = bs_{SSR name}$Bin, include.lowest=TRUE, include.highest=TRUE)
dat$Bin.a2 <- cut(dat$Size.a2, breaks = bks, labels = bs_{SSR name}$Bin, include.lowest=TRUE, include.highest=TRUE)

summary(dat$Bin.a1)

# how does that compare to the N in the bs_{SSR name}

#############################################
######### Step 4 - Export the data 
#############################################

write.csv(dat, file="out/Results_{SSR name}.csv", quote=FALSE, row.names=FALSE)


