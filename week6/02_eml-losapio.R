# This code demonstrates how one could create EML metadata in R from scratch for a dataset
# We will be only covering a tiny fraction of the schema (eml-dataset-module)
# We will be using an adapted dataset from a Dryad deposit as an example: https://doi.org/10.5061/dryad.dz08kprw0
# Please refer to the insert-record.csv, methods.md, abstract.md and README-losapio.txt files to complete this exercise.

# If you haven't yet, time two install two required packages

install.packages("EML")
install.packages("emld") #an effective back-end for other 'R'-based tools working with 'EML

setwd("/Users/wsedgwick/Desktop/bren_meds/courses/spring/eds213/bren-meds213-class-data/week6")

# Load Packages

# Starting our EML Record
# Describing the Coverage (Temporal and Geographic)

geographicDescription <- "Loma del Mulhacen, Sierra Nevada, Andalucia, Spain"

coverage <- 
  set_coverage(begin = "2015-07-01", end = "2015-07-31",
               geographicDescription = geographicDescription,
               west = -3.30, east = 3.30, 
               north = 37.05, south = 37.05,
               altitudeMin = 600, altitudeMaximum = 3396,
               altitudeUnits = "meter")

# Methods
methods_file <- "./methods.md"
methods <- set_methods(methods_file)

losapia <- eml$creator(
  individualName = eml$individualName(
    givenName = "Gianalberto",
    surName = "Losapio"),
  electronicMailAddress = "losapiog@stanford.edu"
)

gianalberto <- eml$creator(
  individualName = eml$individualName(
    givenName = "Gianalberto",
    surName = "Losapio"),
  electronicMailAddress = "losapiog@stanford.edu"
)


R_person <- person("Gianalbeto", "Losapio", "losapiog@stanford.edu")

# You may copy it or call the .md file

# Creating parties

# Persons and Organizations appear in multiple places in and EML document. R has a native object class R_person

# Publisher

publisher <- "Standford University"
  
# Contact Info  
 

# Time for some keywords! As we learned these are important for findability.
# We will create a keywordSet which is essentially a list of lists
# We may also refer to controlled vocabularies and specific thesaurus for terms such as LTER's (https://vocab.lternet.edu/)


# Publication Date
    
pubDate <- "2021"

# Title

title <- "Plant-pollinator observations for: An experimental approach to assessing the 
  impact of ecosystem engineers on biodiversity and ecosystem functions"

# Abstract

abstract_file <- "./abstract.md"
abstract_set <- set_TextType(abstract_file)

intellectualRights <- "Creative Commons CC0 License"

# You may copy it or call the .md file
contact <- list(
  individualName = gianalberto$individualName,
  electronicMailAddress = gianalberto$electronicMailAddress,
  organization = "Stanford University")


# Licensing and Rights

# Time to create our dataset element!

dataset <- list(
  title = title,
  creator = gianalberto,
  pubDate = pubDate,
  ...)

# We should now create our root element for EML which will hang everything else

eml <- list(
  packageId = uuid::UUIDgenerate(),
  system = "uuid", # type of identifier - Universally Unique Identifiers
  dataset = dataset)

# Getting close! Time to write and validate our EML record!


# If you got [1] TRUE that means success!


# Wait! We are missing the attribute metadata at the file-level which is the heart of an EML dataset record!
# We will work on a separate script file (dataTable).
# Make sure to copy it here when ready, and add the dataTable to the elements's list before re-running the code.
