# Genetic Analysis with R:poppr

# Package Vignettes 
# https://grunwaldlab.github.io/poppr/articles/poppr_manual.html
# https://grunwaldlab.github.io/poppr/articles/mlg.html


#############################################
######### Step 1 - Edit the data file in excel 
#############################################

# first we need to create a data file that poppr can read - we will use a genalex file.
# see https://biology-assets.anu.edu.au/GenAlEx/Download_files/GenAlEx%206.5%20Guide.pdf
# We will edit the file you made before (out/Results_{SSR name}.csv) in excel. 

# HINTS: 
# We need to make one file with all the allele size information together  
# Pop = Cultivar
# Make the data haploid (one column (allele) per SSR)


# Save file to "out/Results_genalex.csv"

#############################################
######### Step 1 - Load library and import data into R 
#############################################
# install and load the package 'poppr'
library(poppr)

# import the genalex formatted file

res <- read.genalex("out/Results_genalex.csv")

# Check the data has been read in properly 
table(strata(res}, ~Pop))

#############################################
######### Step 2 - Find multi-locus genotype
#############################################

# A multi-locus genotype (mlg)is the unique combination of alleles across all loci.

mlg.tab <- mlg.table(res)
mlg.tab
# How many mlg are in your data?

# Look at the plots - Is there differences between the cultivars?

#############################################
######### Step 3 - Identify and remove clones
#############################################

# Some isolates may be clones - thus are not different genotypes
# The number of clones indicates the amount of asexual reproduction in the population
# We want to know the number of clones and for some later analysis we want to remove them 
# Removing clones is called clone correction

res.cc <- clonecorrect(res)

# Compare before and after clone correction
res.cc
res

# What does the summary tell you?
# How many individuals are removed?
# How many clones were there in the res?


#############################################
######### Step 4 - Get summary statistics for loci
#############################################

?locus_table
lt.cc <- locus_table(res.cc, info = FALSE)

# Which is the most variable SSR?
# What do Hexp and Eveness mean?

# How does that compare to the summary table for the results with clones
lt <- locus_table(res, info = FALSE)
lt

# You can make a summary table for each cultivar/population
locus_table(res, pop = "{pop name }")

# How does the results compare?




