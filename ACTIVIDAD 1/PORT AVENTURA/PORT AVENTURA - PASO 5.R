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


punt1 <- read.csv("1-punt.csv") #llamamos al dataset creado en el paso 0
punt3 <- read.csv("3-punt.csv")
punt4 <- read.csv("4-punt.csv")
punt5 <- read.csv("5-punt.csv")
punt1 #comprobamos lectura de los comentarios

#solo nos interesan los comentarios , no las fechas
comentarios1 <- punt1[,c(2)]
comentarios3 <- punt3[,c(2)]
comentarios4 <- punt4[,c(2)]
comentarios5 <- punt5[,c(2)]
comentarios1

#Eliminamos caracteres especiales,tabulaciones...
comentarios1 = gsub("[[:cntrl:]]", " ", comentarios1)
comentarios3 = gsub("[[:cntrl:]]", " ", comentarios3)
comentarios4 = gsub("[[:cntrl:]]", " ", comentarios4)
comentarios5 = gsub("[[:cntrl:]]", " ", comentarios5)
comentarios1
#Pasamos el texto a minusculas
comentarios1 = tolower(comentarios1)
comentarios3 = tolower(comentarios3)
comentarios4 = tolower(comentarios4)
comentarios5 = tolower(comentarios5)
comentarios1

#eliminamos numeros
comentarios1 = removeNumbers(comentarios1)
comentarios3 = removeNumbers(comentarios3)
comentarios4 = removeNumbers(comentarios4)
comentarios5 = removeNumbers(comentarios5)
comentarios1

#eliminamos espacios en blanco
comentarios1 = stripWhitespace(comentarios1)
comentarios3 = stripWhitespace(comentarios3)
comentarios4 = stripWhitespace(comentarios4)
comentarios5 = stripWhitespace(comentarios5)
comentarios1

#Creamos el corpus
corpus1 = VCorpus(VectorSource(comentarios1))
corpus3 = VCorpus(VectorSource(comentarios3))
corpus4 = VCorpus(VectorSource(comentarios4))
corpus5 = VCorpus(VectorSource(comentarios5))
str(corpus1)
str(corpus3)
str(corpus4)
str(corpus5)

port_op_1 = tm_map(corpus1, PlainTextDocument)
port_op_3 = tm_map(corpus3, PlainTextDocument)
port_op_4 = tm_map(corpus4, PlainTextDocument)
port_op_5 = tm_map(corpus5, PlainTextDocument)

#Creamos una nube de palabras
wordcloud(port_op_1 , max.words = 10000, random.order = F, colors = brewer.pal(name = "Dark2", n = 8))
wordcloud(port_op_3 , max.words = 10000, random.order = F, colors = brewer.pal(name = "Dark2", n = 8))
wordcloud(port_op_4 , max.words = 10000, random.order = F, colors = brewer.pal(name = "Dark2", n = 8))
wordcloud(port_op_5 , max.words = 10000, random.order = F, colors = brewer.pal(name = "Dark2", n = 8))

#Eliminamos palabras
comentarios1 = removeWords(comentarios1, words = c("las", "los", "una", "con", "que", "pues", "tal", "tan", "así", "dijo", "cómo", "sino", "entonces", "aunque", "don", "doña","pero","para","nos","años","son","cada","dio","tres","obligan","atento.","casi","ido","hace","...más","eso","ese","habia","muy",",.h","por","vez","hacer","uno","otra","vas","fuimos","hemos","dos","esta","más","algo","después","nan"))
comentarios3 = removeWords(comentarios3, words = c("las", "los", "una", "con", "que", "pues", "tal", "tan", "así", "dijo", "cómo", "sino", "entonces", "aunque", "don", "doña","pero","para","nos","años","son","cada","dio","tres","obligan","atento.","casi","ido","hace","...más","eso","ese","habia","muy",",.h","por","vez","hacer","uno","otra","vas","fuimos","hemos","dos","esta","más","algo","después","nan"))
comentarios4 = removeWords(comentarios4, words = c("las", "los", "una", "con", "que", "pues", "tal", "tan", "así", "dijo", "cómo", "sino", "entonces", "aunque", "don", "doña","pero","para","nos","años","son","cada","dio","tres","obligan","atento.","casi","ido","hace","...más","eso","ese","habia","muy",",.h","por","vez","hacer","uno","otra","vas","fuimos","hemos","dos","esta","más","algo","después","nan"))
comentarios5 = removeWords(comentarios5, words = c("las", "los", "una", "con", "que", "pues", "tal", "tan", "así", "dijo", "cómo", "sino", "entonces", "aunque", "don", "doña","pero","para","nos","años","son","cada","dio","tres","obligan","atento.","casi","ido","hace","...más","eso","ese","habia","muy",",.h","por","vez","hacer","uno","otra","vas","fuimos","hemos","dos","esta","más","algo","después","nan"))

comentarios1

corpus1 = VCorpus(VectorSource(comentarios1))
corpus3 = VCorpus(VectorSource(comentarios3))
corpus4 = VCorpus(VectorSource(comentarios4))
corpus5 = VCorpus(VectorSource(comentarios5))

corpus1

port_op_1 = tm_map(corpus1, PlainTextDocument)
port_op_3 = tm_map(corpus3, PlainTextDocument)
port_op_4 = tm_map(corpus4, PlainTextDocument)
port_op_5 = tm_map(corpus5, PlainTextDocument)

#Creamos una nube de palabras
wordcloud(port_op_1 , max.words = 10000, random.order = F, colors = brewer.pal(name = "Dark2", n = 8))
wordcloud(port_op_3 , max.words = 10000, random.order = F, colors = brewer.pal(name = "Dark2", n = 8))
wordcloud(port_op_4 , max.words = 10000, random.order = F, colors = brewer.pal(name = "Dark2", n = 8))
wordcloud(port_op_5 , max.words = 10000, random.order = F, colors = brewer.pal(name = "Dark2", n = 8))


