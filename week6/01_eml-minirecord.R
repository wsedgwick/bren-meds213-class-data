# Required packages
library(EML)
library(emld)

# Below is a minimal valid EML record with a tile, creator and contact info.

me <- list(individualName = list(givenName = "Renata", surName = "Curty"))
eml_mini <- list(dataset = list(
  title = "This is a minimal valid EML dataset record",
  creator = me,
  contact = me)
)

#We then need to run 
write_eml(eml_mini, "eml-mini.xml")
eml_validate("eml-mini.xml")

#We should get [1] TRUE with no erros and a min.xml record

# As we learned this is too barebones, and not enough for findability and interoperability.
# We need richer metadata!
# Time to open the eml-losapio.R script file.
