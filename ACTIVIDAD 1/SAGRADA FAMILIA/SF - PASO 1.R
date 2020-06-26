
####################################################################
# Configurando el entorno de trabajo
####################################################################
rm(list=ls())
setwd(dirname(rstudioapi::getActiveDocumentContext()$path))
getwd()
dir()
graphics.off()
cat("\014")

###################################################################
#Algunos Paquetes necesarios
###################################################################


library(tm) # Minería de textos
library(SnowballC) 
library(wordcloud) #Sacar graficos de nubes de palabras
library(ggplot2) #Hacer Graficos
library(dplyr) # Manipular y Transformar datos
library(readr) # Leer y escribir documentos
library(cluster) # Analisis de grupos


datos <- read.csv("SF-OP.csv") #llamamos al dataset creado en el paso 0
datos #comprobamos lectura de los comentarios

#solo nos interesan los comentarios , no las fechas
comentarios <- datos[,c(2)]
comentarios

#Eliminamos caracteres especiales,tabulaciones...
comentarios = gsub("[[:cntrl:]]", " ", comentarios)
comentarios
#Pasamos el texto a minusculas
comentarios = tolower(comentarios)
comentarios

#eliminamos numeros
comentarios = removeNumbers(comentarios)
comentarios

#eliminamos espacios en blanco
comentarios = stripWhitespace(comentarios)
comentarios

#Creamos el corpus
corpus = VCorpus(VectorSource(comentarios))
str(corpus)

sf_op = tm_map(corpus, PlainTextDocument)

#Creamos una nube de palabras
wordcloud(sf_op , max.words = 10000, random.order = F, colors = brewer.pal(name = "Dark2", n = 8))

#Eliminamos palabras
comentarios = removeWords(comentarios, words = c("las", "los", "una", "con", "que", "pues", "tal", "tan", "así", "dijo", "cómo", "sino", "entonces", "aunque", "don", "doña","pero","para","nos","años","son","cada","dio","tres","obligan","atento.","casi","ido","hace","...más","eso","ese","habia","muy",",.h","por","vez","hacer","uno","otra","vas","fuimos","hemos","dos","esta","más","algo","después","nan"))
comentarios
corpus = VCorpus(VectorSource(comentarios))
corpus

sf_op = tm_map(corpus, PlainTextDocument)

#Creamos una nube de palabras
wordcloud(sf_op, max.words = 10000, random.order = F, colors = brewer.pal(name = "Dark2", n = 8))


