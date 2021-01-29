# Ejemplo 1. Regresion Lineal Simple

# Primero hay que establecer el directorio de trabajo y este deberia contener 
# el archivo de datos production.txt

# Leemos nuestros datos con la funcion read.table
setwd("C:/Users/monts/SantanderBEDU/MODULO2/Sesion5/Ejemplos/Ejemplo1")
production <- read.table("production.txt", header = TRUE)

# Los datos que importamos a R se encuentran como data frame con nombre 
# production. Aplicamos la funcion attach al data frame production para
# poder manipular las columnas mediante sus nombres

attach(production)

# Hacemos el grafico de dispersion

plot(RunSize, RunTime, xlab = "Tama?o de ejecucion", 
     ylab = "Tiempo de ejecucion", pch = 16)

# Ajustamos un modelo de regresion lineal simple con la funcion lm, en donde
# la variable de respuesta es RunTime y la variable predictora es RunSize. 
# Guardamos nuestro modelo ajustado con el nombre de m1

m1 <- lm(RunTime~RunSize)

# Obtenemos un resumen de nuestro modelo ajustado mediante la funcion `summary`

summary(m1)

# Graficamos nuestros datos nuevamente, pero ahora con la recta de regresion
# ajustada

plot(RunSize, RunTime, xlab = "Tama?o de ejecucion", 
     ylab = "Tiempo de ejecucin", pch = 16)
abline(lsfit(RunSize, RunTime), colours(red)) # Trazamos la recta de regresion estimada
mtext(expression(paste('Modelo de regresion lineal simple:',
                       ' ',
                       y[i] == beta[0] + beta[1]*x[i] + e[i])),
      side = 3, adj=1, font = 2)

# Recta de regresion poblacional

text(x = 200, y = 240, expression(paste('Recta de regresion:',
                                        ' ',
                                        y[i] == beta[0] + beta[1]*x[i])),
     adj = 1, font = 2)


# Recta de regresion estimada

text(x = 350, y = 180, expression(paste('Recta estimada:',
                                        ' ',
                                        hat(y)[i] == hat(beta)[0] + hat(beta)[1]*x[i])),
     adj = 1, font = 2)

# Recta de regresion estimada

text(x = 350, y = 160, expression(paste('Recta estimada:',
                                        ' ',
                                        hat(y)[i] == 149.74770 + 0.25924*x[i])),
     adj = 1, font = 2)

# Residuales

points(189, 215, pch=16, col = "red") # Punto muestral
149.74770 + 0.25924 * 189 # Valor y sobre la recta estimada
lines(c(189, 189), c(198.7441, 215), col = "red")

points(173, 166, pch=16, col = "red") # Punto muestral
149.74770 + 0.25924 * 173 # Valor y sobre la recta estimada
lines(c(173, 173), c(166, 194.5962), col = "red")

# A continuacion encontramos el cuantil de orden 0.975 de la distribucion
# t de Student con 18 (n - 2) grados de libertad. En total tenemos n = 20 
# observaciones en nuestro conjunto de datos. Estamos encontrando el valor 
# que satisface P(T > tval) = 0.025

tval <- qt(1-0.05/2, 18)
tval

# Comprobamos

pt(tval, df = 18)

# Encontramos intervalos de confianza del 95% para el intercepto y la pendiente
# del modelo de regresión lineal simple

round(confint(m1, level = 0.95), 3)

# Ahora encontramos intervalos de confianza del 95% para la recta de regresion
# poblacional en algunos valores de X (RunSize)

RunSize0 <- c(50,100,150,200,250,300,350) # Algunos posibles valores de RunSize

(conf <- predict(m1, newdata = 
                   data.frame(RunSize = RunSize0), 
                 interval = "confidence", level = 0.95))

# Podemos visualizar graficamente estos intervalos de confianza

lines(RunSize0, conf[, 2], lty = 2, lwd = 2, col = "green") # limites inferiores
lines(RunSize0, conf[, 3], lty = 2, lwd = 2, col = "green") # limites superiores

# Tambien podemos encontrar intervalos de prediccion del 95% para el valor
# real de la variable de respuesta Y (RunTime) en algunos valores de X (RunSize)

(pred <- predict(m1, newdata = 
          data.frame(RunSize = RunSize0), 
        interval = "prediction", level = 0.95))

# Podemos visualizar graficamente estos intervalos de prediccion

lines(RunSize0, pred[, 2], lty = 2, lwd = 2, col = "blue") # límites inferiores
lines(RunSize0, pred[, 3], lty = 2, lwd = 2, col = "blue") # límites superiores


# Note como los intervalos de confianza estan contenidos dentro de los
# intervalos de prediccion correspondientes

# Tambien es posible llevar a cabo un analisis de varianza para decidir si 
# existe asociacion lineal entre RunSize y RunTime

anova(m1)

# Grafico de diagnostico de R

# Cuando usamos un modelo de regresión, hacemos una serie de suposiciones. 
# Entonces debemos hacer diagnósticos de regresión para verificar las
# supocisiones.

par(mfrow = c(2, 2))
plot(m1)
dev.off()

# Inspirado en:

# [S.J. Sheather, A Modern Approach to Regression with R, 
# DOI: 10.1007/978-0-387-09608-7_2, © Springer Science + Business Media LLC 2009]
# (https://gattonweb.uky.edu/sheather/book/index.php)




