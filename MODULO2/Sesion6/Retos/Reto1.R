###
#   Simulación de un proceso AR(1)
###

# 1. Simula un proceso AR(1) de la forma x[t] = 0.5 * x[t-1] + w[t] para 
#    t = 1, 2, ..., 200 y muestra gráficamente la serie de tiempo obtenida

set.seed(1)
x <- w <- rnorm(200)
for(t in 2:200) x[t] <- 0.5 * x[t-1] + w[t]
plot(x, type = "l", xlab = "", ylab = "")
title(main = "Proceso AR(1) simulado",
      xlab = "Tiempo",
      ylab = expression(x[t]),
      sub = expression(x[t]==0.5*x[t-1]+w[t]))


# 2. Obtén el correlograma y el correlograma parcial del proceso AR(1) simulado

acf(x, main = "")
title(main = "Correlograma del proceso AR(1) simulado", 
      sub = expression(x[t]==0.5*x[t-1]+w[t]))


# 2. Ajusta un modelo autorregresivo a la serie simulada utilizando la función ar, 
#    observa el orden del modelo y el parámetro estimado (los parámetros estimados)


x.ar <- ar(x, method = "mle")
x.ar$order
x.ar$ar
  