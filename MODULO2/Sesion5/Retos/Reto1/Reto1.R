###
#   Se cree que entre las variables x y y del archivo csv adjunto, podría haber 
#   una relación más o menos lineal. Para tener más evidencia sobre esto lleve
#   a cabo lo siguiente:
###  
setwd("C:/Users/monts/SantanderBEDU/MODULO2/Sesion5/Retos/Reto1")
data <- read.csv("datoslineal.csv")
attach(data)
# 1. Realice el gráfico de dispersión de los datos

plot(x,y, main="Grafico de dispersion")

# 2. Ajuste un modelo de regresión lineal simple a los datos, muestre un resumen
#    del modelo ajustado y trace la recta de regresión estimada junto con el 
#    gráfico de dispersión

modelo <- lm(x~y)
summary(modelo)
abline(lsfit(x,y), col="red")

# 3. Obtenga algunas gráficas de diagnóstico y diga si es razonable suponer para
#    los errores aleatoriedad, normalidad y varianza constante.

par(mfrow = c(2,2))
plot(modelo)
dev.off()
