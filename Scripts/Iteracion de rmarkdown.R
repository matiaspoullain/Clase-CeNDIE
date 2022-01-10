library(tidyverse)
respiratorias <- read.csv("Datos/respiratorias.csv", stringsAsFactors = TRUE, encoding = "UTF-8")


provincias <- as.character(unique(respiratorias$provincia_nombre))


for(i in provincias){
  
  nombre <- gsub(" ", "_", paste0("Iter_Rmarkdowns/rmarkdown_", i, ".pdf"))
  
  rmarkdown::render('RM base.Rmd', params = list(data = i), output_file = nombre)
  
}
