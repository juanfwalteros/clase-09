## Eduard Martinez
## 18-03-2024

## intial setup
rm(list=ls())
require(pacman)
p_load(tidyverse,
       rio,
       data.table,
       janitor)

## load data
files <- list.files("input",recursive=T , full.names=T)
files

## Cabecera - Caracter
str_subset(files,"Cabecera - Car")
cg <- import_list(str_subset(files,"Cabecera - Car")) %>% 
      rbindlist(fill=T) %>% clean_names()

## Cabecera - Caracter
str_subset(files,"Cabecera - Ocu")
ocu <- import_list(str_subset(files,"Cabecera - Ocu")) %>% 
       rbindlist(fill=T) %>% clean_names()

## join
geih <- left_join(x=cg , y=ocu , by=c("directorio","secuencia_p","orden","hogar"))

## clean environment
rm(list=ls())
geih <- import("output/geih_2019_2021.rds")

## scatter plot


## Ingreso por sexo


## Ingreso por sexo y tipo de contrato


