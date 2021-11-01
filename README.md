# Short Sequence Repeat Analysis in R

This respository contains instructions and scripts for analysing short sequence repeats (SSR) or microsatellites using R. The analysis uses files created by a DNA Fragment Capillary Sequencer (.fsa).

# Step 1: Create an R Project directory.
Create a directory on you computer to all the date related to this project. Using the aapproach outlined below will ensure that your data and results are well organised - this is an important step for data management. Data analysis, like your laboratory methods must be properly recorded, so just like you keep an accurate record of your what you did in the lab (lab book) you should also keep an accurate record of your analysis. Just like a lab book, this should be clear enough that someone can assess your methods and replicate your work. 

Name the folder accordingly. Do not use spaces or weird caracters in your folder or filenames (eg. use '_'_ instead of spaces)
In this directory create the following sub directories 
- data
- plots
- scripts
- results
- package

# Step 2: Copy the raw data (.fsa) files into the 'data' subdirectory
Nothing else should go into the 'data' subdirectory.

# Step 3: Copy files from this repository 
There are a couple of ways to copy the files from github. An easy option is dowload the directory. Click on code and choose download zip.
Then move the R scripts into  'scripts' subdirectory and  the 'MsatAllele_1.05.tar.gz' to the 'paackage' subdirectory.

# Step 4: Create an R Project
If you need to install or unpdate R and R Studio
To download R
https://cran.r-project.org/

To download the free version of R Studio
https://www.rstudio.com/products/rstudio/download/

Open R Studio and choose 'File' and 'New Project' 
Create a project using 'Existing Directory'
Choose your Project directory that you created.

When you quit R you will be asked if you wan to save your project data (.RData). Say YES!


