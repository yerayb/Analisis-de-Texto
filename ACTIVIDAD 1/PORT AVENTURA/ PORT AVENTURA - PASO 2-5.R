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

# Datos de port aventura
web <- read_html("https://www.tripadvisor.es/Attraction_Review-g562814-d667082-Reviews-PortAventura-Salou_Costa_Dorada_Province_of_Tarragona_Catalonia.html")

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

# 2. Fecha comentario
fechaComentario<-web%>%
  html_nodes(".ratingDate")%>%
  html_attr("title")
fechaComentario

#3. Titulo Comentario
tituloComentario<-web%>%
  html_nodes(".noQuotes")%>%
  html_text()
tituloComentario

# 4. Reviews
reviews <- web %>% html_nodes("#REVIEWS")

puntuacionComentario <- reviews %>% 
  html_nodes(".ui_bubble_rating") %>% 
  html_attr("class")%>%
  gsub("ui_bubble_rating bubble_", "", .) %>%
  as.integer()/10
puntuacionComentario

datos<-data.frame(textoComentario,fechaComentario,tituloComentario,puntuacionComentario)

# Nos recorremos todas las páginas

for(i in 1:100){
  # 1. Preparamos la url
  url<-paste0("https://www.tripadvisor.es/Attraction_Review-g562814-d667082-Reviews-or",i*10,"-PortAventura-Salou_Costa_Dorada_Province_of_Tarragona_Catalonia.html")
  
  # 2. Descargamos la página
  pagina<-read_html(url)
  
  # 3. Descargamos los comentarios de esa página
  textoComentario<-pagina%>%
    html_nodes(".partial_entry")%>%
    html_text()
  
  # 2. Fecha comentario
  fechaComentario<-pagina%>%
    html_nodes(".ratingDate")%>%
    html_attr("title")
  fechaComentario
  
  #3. Titulo Comentario
  tituloComentario<-pagina%>%
    html_nodes(".noQuotes")%>%
    html_text()
  tituloComentario
  
  # 4. Descargamos puntuaciones
  puntuacionComentario <- reviews %>% 
    html_nodes(".ui_bubble_rating") %>% 
    html_attr("class")%>%
    gsub("ui_bubble_rating bubble_", "", .) %>%
    as.integer()/10
  
  punt<-reviews%>%
    html_nodes(".ratings_chart")%>%
    html_text()
  punt  
  
  evaldivision<-strsplit(punt,"%")
  evaldivision
  
  
  # 5. Lo juntamos en un dataframe
  nuevosDatos<-data.frame(textoComentario,fechaComentario,tituloComentario,puntuacionComentario)
  
  # 6. Lo juntamos con el dataframe general
  datos<-rbind(datos,nuevosDatos)
  
  print(paste0("Página ",i))
  
}

hist(datos$puntuacionComentario,main="Puntuacion Port Aventura") #PASO 4

#PASO 5 --> NUEVOS DATAFRAME
datos1 = datos[datos$puntuacionComentario==1,]
datos3 = datos[datos$puntuacionComentario==3,]
datos4 = datos[datos$puntuacionComentario==4,]
datos5 = datos[datos$puntuacionComentario==5,]

write.csv(datos1, file="1-punt.csv") #PASO 5 --> EXPORTAR A CSV
write.csv(datos3, file="3-punt.csv")
write.csv(datos4, file="4-punt.csv")
write.csv(datos5, file="5-punt.csv")

