## Eduard Martinez
## 18-03-2024

## intial setup
rm(list=ls())
require(pacman)
p_load(tidyverse,
       rio,
       data.table,
       janitor,
       ggthemes)
  
files <- list.files("input",recursive=T,full.names = T)
files

## substraer un vector de caraters
letras <- c("hola","papa","mapa")
letras

str_subset(string = letras , pattern = "p")

## Cabecera - Caracter
str_subset(string = files , pattern = "Cabecera - Car")

## importar vector de archivos
all_db <- import_list(files)
all_db

## Cabecera - Caracter
cg <- import_list(file = str_subset(files,"Cabecera - Car")) %>%
      rbindlist(use.names = T , fill = T) %>%
      clean_names()
cg

## ocupados - Caracter
ocu <- import_list(file = str_subset(files,"Cabecera - Ocu")) %>%
       rbindlist(use.names = T , fill = T) %>%
       clean_names()

## join
db <- left_join(cg,ocu,c("directorio" ,"secuencia_p","orden","hogar"))


##==== Graficos base  ===###
db <- import("output/geih_2019_2021.rds")

## hist
hist(db$p6040)

## densidad
plot(density(db$p6040))

## scatter plot
plot(x = db$p6040 , y = db$inglabo)

##=== ggplot2 ===##

## grafico base de ggplot
ggplot(data = db , mapping = aes(x=inglabo , y=p6040))

## grafico sctaer
ggplot(data = db , mapping = aes(y=inglabo , x=p6040)) +
geom_point(col = "gold") 

## plot by category
ggplot(data = db , mapping = aes(y=inglabo , x=p6040 , color=as.factor(p6450))) +
geom_point() 

## guardar en un objeto
grafico <- ggplot(data = db[1:1000,] , mapping = aes(y=inglabo , x=p6040 , color=as.factor(p6450))) +
           geom_point() + 
           labs(x="Edad" , y="Ingresos (pesos)" , color="Tipo contrato" , title="Ingreso vs Edad")

## agregar un tema
grafico <- grafico + theme_bw()

## modificar elementos del tema
grafico + theme(axis.title.x = element_text(size = 20 , colour = "red") , 
                axis.text.x = element_text(size = 20) , 
                plot.title = element_text(face = "bold" , size = 30 , hjust = 0.5))

## Ingreso por sexo y departamento
db %>% 
group_by(p6020,p6450) %>%
summarise(ing=mean(inglabo,na.rm = T)) %>%
ggplot(mapping = aes(fill=as.factor(p6020), y=ing, x=as.factor(p6450))) + 
geom_bar(position="dodge", stat="identity") + theme_bw()





db %>% 
group_by(dpto.x,p6020) %>%
summarise(ing=mean(inglabo,na.rm = T)) %>%
ggplot(mapping = aes(y=ing, x=as.factor(dpto.x))) + 
geom_bar(position="dodge", stat="identity" , fill=alpha("darkblue",0.5) , color=NA) + 
  facet_wrap("p6020") +
  theme_bw()









