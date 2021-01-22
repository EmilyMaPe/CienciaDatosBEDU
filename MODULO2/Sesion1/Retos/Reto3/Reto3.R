#1. Almacenalo en un data frame que se llame amazon.best

setwd("C:/Users/monts/SantanderBEDU/MODULO2/Sesion1/Data")
amazon.best <- read.csv("bestsellers with categories.csv")

#2. Calcula el data frame transpuesto, asignale el nombre de tAmazon y conviertelo en un data frame

tAmazon <- as.data.frame(t(amazon.best))

#3. Usa el nombre de los libros como el nombre de las columnas

colnames(tAmazon) <- tAmazon[1,]

row.names(tAmazon)

#4. ¿Cúal es el libro de menor y mayor precio?

which.max(tAmazon["Price",])

which.min(tAmazon["Price",])
