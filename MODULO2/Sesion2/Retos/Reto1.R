library(DescTools)

set.seed(134)
x <- round(rnorm(1000, 175, 6), 1)

# 1. Calcule, la media, mediana y moda de los valores en x

media <- mean(x)
mediana <- median(x)
moda <- Mode(x)
media
mediana
moda

# 2. Obtenga los deciles de los numeros en x

deciles <- quantile(x,probs = seq(.1,.9,.1))
deciles

# 2. Encuentre la rango intercuartilico, la desviacion estandar y varianza muestral de las mediciones en x

rangoIntercuartil <- IQR(x)
desviacionStd <- sd(x)
varianzaMuestral <- var(x)
rangoIntercuartil
desviacionStd
varianzaMuestral
