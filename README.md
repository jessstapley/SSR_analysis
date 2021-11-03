# Short Sequence Repeat Analysis in R

This respository contains instructions and scripts for analysing short sequence repeats (SSR) or microsatellites using R. The analysis uses files created by a DNA Fragment Capillary Sequencer (.fsa).

# Step 1: Create an R Project directory.
Create a directory on you computer where you can store all the data related to this project. Using the approach outlined below will ensure that your data and results are well organised - this is an important step for data management. Data analysis, just like your laboratory methods must be properly recorded. Just like you must keep an accurate record of your what you did in the lab (lab book) you must also keep an accurate record of your analysis, and just like a lab book, this should be clear enough that someone can assess your methods and replicate your work. 

Name the folder accordingly. Do not use spaces or weird characters in your folder or filenames (eg. use underscore '_'_ instead of spaces)
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
Unzip the file and then move the R scripts into  'scripts' subdirectory and  the 'MsatAllele_1.05.tar.gz' to the 'paackage' subdirectory.

# Step 4: Create an R Project
To install or unpdate R and R Studio use the following links.
To download R
https://cran.r-project.org/

To download the free version of R Studio
https://www.rstudio.com/products/rstudio/download/

Open R Studio and choose 'File' and 'New Project' 
Create a project using 'Existing Directory'
Choose the Project directory that you just created.
Done

NB: When you quit R you will be asked if you wan to save your project data (.RData). Say YES!


