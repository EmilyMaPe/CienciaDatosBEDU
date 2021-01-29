###
#   Dada una muestra aleatoria de tamaño n = 10 de una distribución normal
#   
#   set.seed(124)
#   muestra <- rnorm(n = 10, mean = 110, sd = 7) # muestra pequeña
#   tail(as.data.frame(muestra))
#
#   estamos interesados en contrastar las hipótesis H0: mu = 120 vs H1: mu < 120
#   (contraste de cola inferior).
###

set.seed(124)
muestra <- rnorm(n = 10, mean = 110, sd = 7) # muestra pequeña
tail(as.data.frame(muestra))

# 1. Decida si rechazar o no la hipótesis nula si el nivel de significancia es 
#    alpha = 0.05

# El valor observado del estadístico de prueba en este caso está dado por
t0 <- (mean(muestra)-120)/(sd(muestra)/sqrt(10))
t0

# que proviene de una distribución t de Student con n - 1 = 9 grados de libertad (gl).

# estamos interesados en encontrar la región de rechazo (de cola inferior) con 
# un nivel de significancia alpha = 0.05, debemos encontrar el valor t0.05 que
# satisface P(T < t0.05) = 0.05, donde T se distribuye como t de Student con n-1 = 9 gl.

(t.05 <- qt(p = 0.05, df = 9))

t0 < t.05

# como es verdadero rechazamos la hipótesis nula

# 2. Obtenga el p-value de la prueba

(pvalue <- pt(t0, df = 9))

# 3. Lleve a cabo la prueba con la función t.test

t.test(x = muestra, 
       alternative = "less",
       mu = 120)
