# Analysis of SSR fragment size with R:Fragman

# NB: The DNA fragment analyzer is a capillary sequencer. 
# For more information watch this video
# https://www.thermofisher.com/blog/behindthebench/how-does-fragment-analysis-work-seq-it-out-3/

# It detects flourescently labelled DNA that is passing though a capillary.
# Different fragments (SSRs, Size standard) are labelled with a different colour (dye).
# The fluorescently labelled DNA fragments, separated by size, move through the path of a laser beam.
# The laser causes the dyes to fluoresce at different wavelengths (colours)
# A camera detects the fluorescence and records the size and time of the flourescent peak.

# To convert the peak time recorded by the machine to a size in base pairs we use a size standard or ladder. 
# This contains flourescently labelled DNA fragments of known size and creates peaks at regular intervals.
# We calibrate the ouput from the electrophoregram to determine the size of the peak in base pairs (bp)


# Questions you need to answer before anaylsing data 
# What colour dyes did you use in the PCR?
# What colour dye is the size standard/ladder?

#############################################
######### Step 1 - Load packages and data
#############################################

# NB: when you see the curly brackets {} you need to add the correct information there and remove the {}.

library(Fragman)
# install the package Fragman in your R environment
# HINT: go to Packages tab in Lower Right panel.
# once installed, load the library

# Fragman reads in .fsa files that were created by the DNA Fragment Analyzer. 
# Because we created an R project folder with the correct subdirectories it easy to tell R where these files are 
# HINTS:  If you need to see what directory you are in use 'getwd()' or to change the working directory use 'setwd()'

# now we load the data into the R environment using function "storing.inds". 

my.data<-storing.inds(folder="data/")

# Load the size standard ladder information
# The size standard used produces peaks at the certain intervals between 35-500bp.
# At the beginning of the electrophoregram there is a lot of flourscence and noise. 
# So peaks below 75 are not reliable. So we only start the size standard labelling at 75bp
# The laddeer is loaded as follows

my.ladder <- c(75,100,139,150,160,200,250,300,340,350,400,450,490,500)

# NB: the distance between the peaks is not uniform. 
# This helps the software (and us) to make sure we are finding the right peaks. 

#############################################
######### Step 2 - Sizing the peaks of the ladder
#############################################
# This step is to find the real peaks of the ladder adn store the infromation in the R environment
ladder.info.attach(stored=my.data, ladder=my.ladder, ladd.init.thresh=10000, channel.ladder = 5,attempt = 7)


# REMEMBER - it is good to look at the help information for a function using ?
?ladder.info.attach
# For e.g what is the channel ladder ?

# Look at how well the software identified the ladder peaks
# Look through the plots - use the arrows when in the 'Plots' tab in the bottom right panel. 
# Sometimes the peaks are too small to be detected or the software did not identify the peaks.
# then you will need to reduce 'ladd.init.thresh'
# If you  need to correct ladder for one or two samples - using the ladder.corrector. 
# Here you need to manually click on the correct peak positions.

ladder.corrector(stored=my.data, to.correct="{sample_name.fsa}" ,channel = 5,
                 ladder=my.ladder, thresh=10000) 
# Check and correct the samples whose ladders are mismatched. !!This step is important!!

#############################################
######### Step 3 - Sizing the SSR peaks 
#############################################

# Begin by making a marker panel for each SSR. We look at a single marker (channel/colour) at a time.
# You need to know the marker name, the marker colour and the expected size of the PCR product.
# Refer to the excel spreadsheet with marker information and your lab notes.

my.panel.{SSR name} <- overview2(my.inds=my.data,channel = {channel colour}, ladder=my.ladder, 
                           init.thresh=5000, xlim=c({size range in bp e.g. 200,300}))

# look at the object my.panel.{SSR name} 
my.panel.{SSR name} 
# This is a list of peak positions in base pairs that the software recognised.

# score the peaks 
{SSR name} <- score.markers(my.inds=my.data, panel= my.panel.{SSR name}$channel_1, 
                            ladder=my.ladder, channel.ladder=5, channel = {channel colour} )


# Look at the graphs again. A pink shaded area is the position that the software has labelled as a peak.

# Has the software found the right peaks?
# Sometimes  it chooses the wrong peak. We will discuss how to know what is the right peak.
 
# To fix this problem you have two options. I recommend Option 1.
# Option 1. Create a panel that has many more possible peak positions. The easiest way is to create a sequence of numbers isong 'seq()'
?seq

# if xlim=c(170,200)
my.panel.{SSR name} <- seq(from=170, to=200, by=0.05)
# this creates a list of lots of possible peak positions.
# then rerun score.markers. NB the structure of my.panel.{SSR name} object has changed see it now
my.panel.{SSR name}

# you no longer need to specifc the '$channel_1', instead rerun as follows

{SSR name} <- score.markers(my.inds=my.data, panel= my.panel.{SSR name}, 
                            ladder=my.ladder, channel.ladder=5, channel = {channel colour} )

# Check the peaks - is this better?

# Option 2. Is use the click on the manually choose the peak positions. 
# This can be useful if you have only a few positions, but it can be time consuming and is less repeatable because people will vary in how they choose these postions.

{SSR name} <- score.markers(my.inds=my.data, panel= my.panel.{SSR name}$channel_1, 
                            ladder=my.ladder, channel.ladder=5, channel = {channel colour} )

my.panel.{SSR name} <- locator(type="p", pch=20, col="blue",init.thresh=2500,)$x

# note the plot is in an interactive mode - you can click on the peaks that you want to include in the panel
# pres Esc to exit the plot window
# now look at the panel again
my.panel.{SSR name}
# are there more possible peaks ?

# then run score markers again 
{SSR name} <- score.markers(my.inds=my.data, panel= my.panel.{SSR name}, 
                            ladder=my.ladder, channel.ladder=5, channel = {channel colour} )


#############################################
######### Step 4 - Exporting the data
#############################################

# now using the panel information you can extract the peak sizes in store in a table 
pos.{SSR name} <- get.scores({SSR name})

# look at the data
head(pos.{SSR name})

# this creates a table with ID, allele 1, and allele 2.
# are there any heterozygotes?
# export data as comma separated file

# for the next step we need the data in a slightly different format so we add some columns before exporting


names(pos.{SSR name}) <- c("Size.a1", "Size.a2")
pos.{SSR name}$Sample.Name <- row.names(pos.{SSR name})

pos.{SSR name}$Marker <- rep("{SSR_name}", length(pos.{SSR name}$Sample.Name))
pos.{SSR name}$Panel <- rep("Multi2", length(pos.{SSR name}$Sample.Name))
pos.{SSR name}$Colour <- rep("B", length(pos.{SSR name}$Sample.Name))

newpos.{SSR name} <- pos.{SSR name}[,c("Sample.Name", "Colour", "Panel", "Sample.Name", "Marker", "Size.a1", "Size.a2")]

# We need to export this as a tab-delimited file

write.table(newpos.{SSR name}, 
            file="out/pos_{SSR name}.txt", 
            col.names=FALSE, row.names=FALSE, quote=FALSE, sep="\t")



####################################
######### Save when you exit R  ####
####################################

