

#Limpiar workspace
rm(list = ls())

# Cambiar el directorio de trabajo
setwd(dirname(rstudioapi::getActiveDocumentContext()$path))
getwd()

# Limpiar consola
cat("\014")

# UTF-8
options(encoding = "utf-8")

# Cargamos las librerías que vamos a necesitar
library(rvest)

# Datos de  la basilica
web <- read_html("https://www.tripadvisor.es/Attraction_Review-g187497-d190166-Reviews-Basilica_of_the_Sagrada_Familia-Barcelona_Catalonia.html")

# Obtenemos el número total de reviews
totalReviews <- web %>%
  html_nodes(".seeAllReviews") %>%
  html_text()
totalReviews

# Nos quedamos solo con el número
totalReviews <- strsplit(totalReviews, " ")[[1]][1]
totalReviews <- as.numeric(gsub("\\.", "", totalReviews))
totalReviews

# Obtenemos el teléfono
telefono <- web %>%
  html_node(".phone") %>%
  html_text()
telefono

# Obtenemnos la localidad
locality <- web %>%
  html_node(".locality") %>%
  html_text()
locality
locality <- strsplit(locality, ",")[[1]][1] # Limpiamos para quedarnos solo con la primera parte
locality

# Vamos a obtener la gráfica de ratings   
ratings<-web%>%
  html_nodes(".ratings_chart")%>%
  html_text()
ratings  

division<-strsplit(ratings,"%")
division


###################################################################
###################################################################
# Dataset para descargar todos los campos de los comentarios
# 1. Texto comentarios
textoComentario<-web%>%
  html_nodes(".partial_entry")%>%
  html_text()
textoComentario

datos<-data.frame(textoComentario)

# Nos recorremos todas las páginas
for(i in 1:100){
  # 1. Preparamos la url
  url<-paste0("https://www.tripadvisor.es/Attraction_Review-g187497-d190166-Reviews-or",i*10,"-Basilica_of_the_Sagrada_Familia-Barcelona_Catalonia.html")
  
  # 2. Descargamos la página
  pagina<-read_html(url)
  
  # 3. Descargamos los comentarios de esa página
  textoComentario<-pagina%>%
    html_nodes(".partial_entry")%>%
    html_text()
  
  # 5. Lo juntamos en un dataframe
  nuevosDatos<-data.frame(textoComentario)
  
  # 6. Lo juntamos con el dataframe general
  datos<-rbind(datos,nuevosDatos)
  
  print(paste0("Página ",i))
}

write.csv(datos, file="SF-OP.csv") #PASO 0 --> EXPORTAR A CSV

