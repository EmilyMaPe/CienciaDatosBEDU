#    Distribicion binomial

#    Consideremos un experimento binomial con n = 35 pruebas idénticas e 
#    independientes, en donde la probabilidad de éxito en cada prueba es
#    p = 0.51. Encuentre lo siguiente:
  
# 1. La probabilidad de observar exactamente 10 éxitos

dbinom(x = 10, size = 35, prob = 0.51)

# 2. La probabilidad de observar 10 o más exitos

pbinom(q = 9, size = 35, prob = 0.51, lower.tail = FALSE)

# 3. El cuantil de orden 0.5

qbinom(p = 0.5, size = 35, prob = 0.51)

# 4. Genere una muestra aleatoria de tamaño 1000 de esta distribución,
#    construya una tabla de frecuencias relativas con los resultados y realice 
#    el gráfico de barras de los resultados que muestre las frecuencias relativas.
set.seed(105)
muestra <- rbinom(n = 1000, size = 35, prob = 0.51)
tabla <- as.data.frame(table(muestra)/length(muestra))
ggplot(data = tabla, aes(x = muestra, y = Freq)) + 
  geom_bar (stat="identity", position = "dodge")


#    Distribución normal
#    Considere una variable aleatoria normal con media 110 y desviación 
#    estándar 7. Realice lo siguiente:
  
# 1. Grafique la función de densidad de probabilidad

x <- seq(80,140, 0.01) # Algunos posibles valores que puede tomar la v.a. X (minimo: mu-4sigma, maximo: mu+4sigma)
y <- dnorm(x, mean = 110, sd = 7)

plot(x, y, type = "l", xlab="", ylab="")
title(main = "Densidad de Probabilidad Normal", sub = expression(paste(mu == 110, " y ", sigma == 7)))

data <- data.frame(x,y)
ggplot(data, aes(x,y)) + geom_line()

# 2. Encuentre la probabilidad de que la v.a. sea mayor o igual a 140

pnorm(q = 140, mean = 110, sd = 7, lower.tail = FALSE)


# 3. Encuentre el cuantil de orden 0.95

(b <- qnorm(p = 0.95, mean = 110, sd = 7)) 


# 4. Genere una muestra aleatoria de tamaño 1000 y realice el histograma de 
#    frecuencias relativas para esta muestra
set.seed(569)
muestraN <- rnorm(n = 1000, mean = 110, sd = 7)
mdf <- as.data.frame(muestraN)
ggplot(mdf, aes(muestraN)) + 
  geom_histogram(colour = 'red', 
                 fill = 'blue',
                 alpha = 0.3, # Intensidad del color fill
                 binwidth = 3) + 
  geom_density(aes(y = 3*..count..))+
  geom_vline(xintercept = mean(mdf$muestra), linetype="dashed", color = "black") + 
  ggtitle('Histograma para la muestra normal') + 
  labs(x = 'Valores obtenidos', y = 'Frecuencia')+
  theme_dark() +
  theme(plot.title = element_text(hjust = 0.5, size = 16))  

