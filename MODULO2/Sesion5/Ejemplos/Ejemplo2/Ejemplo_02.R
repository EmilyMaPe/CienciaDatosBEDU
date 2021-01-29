# Ejemplo 2. Regresion Lineal Multiple

# Predecir el precio de cena (platillo). 
# Datos de encuestas de clientes de 168 restaurantes Italianos
# en el Area deseada estan disponibles.

# Y: Price (Precio): el precio (en USD) de la cena
# X1: Food: Valuacion del cliente de la comida (sacado de 30)
# X2: Decor: Valuacion del cliente de la decoracion (sacado de 30)
# X3: Service: Valuacion del cliente del servicio (sacado de 30)
# X4: East: variable dummy: 1 (0) si el restaurante esta al este (oeste) de la quinta avenida

# Primero debemos establecer nuestro directorio de trabajo y el archivo
# de datos (nyc.csv) que importaremos a R debera de estar en este directorio
setwd("C:/Users/monts/SantanderBEDU/MODULO2/Sesion5/Ejemplos/Ejemplo2")
nyc <- read.csv("nyc.csv", header = TRUE)

# Observamos algunas filas y la dimension del data frame

head(nyc, 2); tail(nyc, 2); dim(nyc)
attach(nyc)

# Llevamos a cabo el ajuste de un modelo
# Y = beta0 + beta1*Food + beta2*Decor + beta3*Service + beta4*East + e

m1 <- lm(Price ~ Food + Decor + Service + East)

# Obtenemos un resumen

summary(m1)

# Ajustamos nuevamente un modelo pero ahora sin considerar la variable Service
# ya que en el resultado anterior se observa que su coeficiente de regresion
# no fue estadisticamente significativo

# Y = beta0 + beta1*Food + beta2*Decor + beta4*East + e (Reducido)

m2 <- lm(Price ~ Food + Decor + East)

# Obtenemos un resumen del modelo ajustado

summary(m2)

# Una forma alternativa de obtener m2 es usar el comando update

m2 <- update(m1, ~.-Service)
summary(m2)

######

# Analisis de covarianza

# Para investigar si el efecto de los predictores depende de la variable dummy 
# East consideraremos el siguiente modelo el cual es una extension a mas de una 
# variable predictora del modelo de rectas de regresion no relacionadas 
# Y = beta0 + beta1*Food + beta2*Decor +  beta3*Service + beta4*East 
#           + beta5*Food*East + beta6*Decor*East + beta7*Service*East + e (Completo)

mfull <- lm(Price ~ Food + Decor + Service + East + 
              Food:East + Decor:East + Service:East)

# Note como ninguno de los coeficientes de regresion para los
# terminos de interaccion son estadisticamente significativos

summary(mfull)

# Ahora compararemos el modelo completo guardado en mfull contra el modelo
# reducido guardado en m2. Es decir, llevaremos a cabo una prueba de hipotesis
# general de

# H0: beta3 = beta5 = beta6 = beta7 = 0
# es decir Y = beta0 + beta1*Food + beta2*Decor + beta4*East + e (Reducido)
# contra
# H1: H0 no es verdad
# es decir, 
# Y = beta0 + beta1*Food + beta2*Decor +  beta3*Service + beta4*East 
#           + beta5*Food*East + beta6*Decor*East + beta7*Service*East + e (Completo)

# La prueba de si el efecto de los predictores depende de la variable dummy
# East puede lograrse usando la siguiente prueba-F parcial.

anova(m2,mfull)

# Dado que el p-value es aproximadamente 0.36, fallamos en rechazar la hipotesis
# nula y adopatamos el modelo reducido
# Y = beta0 + beta1*Food + beta2*Decor + beta4*East + e (Reducido)

######

# Diagnosticos

# En regresion multiple, las graficas de residuales o de residuales
# estandarizados proporcionan informacion directa sobre la forma
# en la cual el modelo esta mal especificado cuando se cumplen
# las siguientes dos condiciones:

# E(Y | X = x) = g(beta0 + beta1*x1 + ... + betap*xp) y
# E(Xi | Xj) aprox alpha0 + alpha1*Xj

# Cuando estas condiciones se cumplen, la grafica de Y contra
# los valores ajustados, proporciona informacion directa acerca de g.
# En regresion lineal multiple g es la funcion identidad. En
# este caso la grafica de Y contra los valores ajustados
# debe producir puntos dispersos alrededor de una recta.
# Si las condiciones no se cumplen, entonces un patron en la
# grafica de los residuales indica que un modelo incorrecto
# ha sido ajustado, pero el patron mismo no proporciona 
# informacion directa sobre como el modelo esta mal especificado.

# Ahora tratemos de verificar si el modelo ajustado es un modelo valido.

# Acontinuacion mostramos una matriz de graficos de dispersion de los
# tres predictores continuos. Los predictores parecen estar linealmente
# relacionados al menos aproximadamente

pairs(~ Food + Decor + Service, data = nyc, gap = 0.4, cex.labels = 1.5)

# A continuacion veremos graficas de residuales estandarizados contra cada
# predictor. La naturaleza aleatoria de estas graficas es un indicativo de
# que el modelo ajustado es un modelo valido para los datos.

m1 <- lm(Price ~ Food + Decor + Service + East)
summary(m1)
StanRes1 <- rstandard(m1)
par(mfrow = c(2, 2))
plot(Food, StanRes1, ylab = "Residuales Estandarizados")
plot(Decor, StanRes1, ylab = "Residuales Estandarizados")
plot(Service, StanRes1, ylab = "Residuales Estandarizados")
plot(East, StanRes1, ylab = "Residuales Estandarizados")
dev.off()

# Finalmente mostramos una grafica de Y, el precio contra los valores
# ajustados 

plot(m1$fitted.values, Price, xlab = "Valores ajustados", ylab = "Price")
abline(lsfit(m1$fitted.values, Price))

# Inspirado en:

# [S.J. Sheather, A Modern Approach to Regression with R, 
# DOI: 10.1007/978-0-387-09608-7_2, © Springer Science + Business Media LLC 2009]
# (https://gattonweb.uky.edu/sheather/book/index.php)

