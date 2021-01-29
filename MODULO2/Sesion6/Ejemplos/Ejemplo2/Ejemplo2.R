# Ejemplo 2. Modelos estocasticos basicos, modelos estacionarios y prediccion

# Ruido Blanco y simulacion en R

set.seed(1)
w <- rnorm(100)
plot(w, type = "l", xlab = "")
title(main = "Ruido Blanco Gaussiano", xlab = "Tiempo")

###

# Para ilustrar mediante simulacion como las muestras pueden diferir 
# de sus poblaciones subyacentes considere lo siguiente

x <- seq(-3, 3, length = 1000)
hist(rnorm(100), prob = T, ylab = "", xlab = "", main = "") 
points(x, dnorm(x), type = "l")
title(ylab = "Densidad", xlab = "Valores simulados de la distribucion normal estandar",
      main = "Comparacion de una muestra con su poblacion subyacente")

###

set.seed(2)
acf(rnorm(100), main = "")
title(main = "Funcion de Autocorrelacion Muestral", 
      sub = "Valores simulados de la distribucion normal estandar")

###

              # Caminata Aleatoria
              # Simulacion en R

x <- w <- rnorm(1000)
for(t in 2:1000) x[t] <- x[t-1] + w[t]
plot(x, type = "l", main = "Caminata Aleatoria Simulada", 
     xlab = "t", ylab = expression(x[t]), 
     sub = expression(x[t]==x[t-1]+w[t]))
acf(x, main = "")
title(main = "Correlograma para la caminata aleatoria simulada", 
      sub = expression(x[t]==x[t-1]+w[t]))

###

        # Modelos Ajustados y graficas de diagnostico
      # Series de caminatas aleatorias simuladas

# El correlograma de las series de diferencias puede usarse para evaluar si una serie dada
# puede modelarse como una caminata aleatoria

acf(diff(x), main = "")
title(main = "Correlograma de la serie de diferencias", 
      sub = expression(nabla*x[t]==x[t]-x[t-1]))

#### Modelos AR(p), MA(q) y ARMA(p, q)

# Modelos AR(p)

# Correlograma de un proceso AR(1)

rho <- function(k, alpha) alpha^k
plot(0:10, rho(0:10, 0.7), type = "h", ylab = "", xlab = "")
title(main = "Correlograma para un proceso AR(1)",
      ylab = expression(rho[k] == alpha^k),
      xlab = "lag k",
      sub = expression(x[t]==0.7*x[t-1]+w[t]))

plot(0:10, rho(0:10, -0.7), type = "h", ylab = "", xlab = "")
title(main = "Correlograma para un proceso AR(1)",
      ylab = expression(rho[k] == alpha^k),
      xlab = "lag k",
      sub = expression(x[t]==-0.7*x[t-1]+w[t]))
abline(h = 0)

###

# Simulacion en R

# Un proceso AR(1) puede ser simulado en R como sigue:

set.seed(1)
x <- w <- rnorm(100)
for(t in 2:100) x[t] <- 0.7 * x[t-1] + w[t]
plot(x, type = "l", xlab = "", ylab = "")
title(main = "Proceso AR(1) simulado",
      xlab = "Tiempo",
      ylab = expression(x[t]),
      sub = expression(x[t]==0.7*x[t-1]+w[t]))

#

acf(x, main = "")
title(main = "Correlograma del proceso AR(1) simulado", 
      sub = expression(x[t]==0.7*x[t-1]+w[t]))

#

pacf(x, main = "")
title(main = "Correlograma Parcial del proceso AR(1) simulado", 
      sub = expression(x[t]==0.7*x[t-1]+w[t]))

###

# Modelos Ajustados

# Ajuste de modelos a series simuladas

x.ar <- ar(x, method = "mle")
x.ar$order
x.ar$ar
x.ar$ar + c(-2, 2)*sqrt(x.ar$asy.var)

# Serie de temperatura global: Ajuste de un modelo AR

Global <- scan("global.txt")
Global.ts <- ts(Global, st = c(1856, 1), end = c(2005, 12), fr = 12)
Global.annual <- aggregate(Global.ts, FUN = mean)
plot(Global.ts, xlab = "Tiempo", ylab = "Temperatura en °C", 
     main = "Serie de Temperatura Global",
     sub = "Serie mensual: Enero de 1856 a Diciembre de 2005")
plot(Global.annual, xlab = "Tiempo", ylab = "Temperatura en °C", 
     main = "Serie de Temperatura Global",
     sub = "Serie anual de temperaturas medias: 1856 a 2005")

#

mean(Global.annual)
Global.ar <- ar(Global.annual, method = "mle")
Global.ar$order
Global.ar$ar
acf(Global.ar$res[-(1:Global.ar$order)], lag = 50, main = "")
title(main = "Correlograma de la serie de residuales",
      sub = "Modelo AR(4) ajustado a la serie de temperaturas globales anuales")

####################################################################################################################################################

# Modelos MA(q)

# Ejemplos en R: Correlograma y Simulacion

# Funcion en R para calcular la Funcion de Autocorrelacion

rho <- function(k, beta){
  q <- length(beta) - 1
  if(k > q) ACF <- 0 else {
    s1 <- 0; s2 <- 0
    for(i in 1:(q-k+1)) s1 <- s1 + beta[i]*beta[i + k]
    for(i in 1:(q+1)) s2 <- s2 + beta[i]^2
    ACF <- s1/s2}
  ACF}

# Correlograma para un proceso MA(3)

beta <- c(1, 0.7, 0.5, 0.2)
rho.k <- rep(1, 10)
for(k in 1:10) rho.k[k] <- rho(k, beta)
plot(0:10, c(1, rho.k), ylab = expression(rho[k]), xlab = "lag k", type = "h",
     sub = expression(x[t] == w[t] + 0.7*w[t-1] + 0.5*w[t-2] + 0.2*w[t-3]),
     main = "Funcion de autocorrelacion para un proceso MA(3)")
abline(0, 0)

# Correlograma para otro proceso MA(3)

beta <- c(1, -0.7, 0.5, -0.2)
rho.k <- rep(1, 10)
for(k in 1:10) rho.k[k] <- rho(k, beta)
plot(0:10, c(1, rho.k), ylab = expression(rho[k]), xlab = "lag k", type = "h",
     sub = expression(x[t] == w[t] - 0.7*w[t-1] + 0.5*w[t-2] - 0.2*w[t-3]),
     main = "Funcion de autocorrelacion para un proceso MA(3)")
abline(0, 0)

####################################################################################################################################################

# Simulacion de un proceso MA(3)

set.seed(1)
b <- c(0.8, 0.6, 0.4)
x <- w <- rnorm(1000)
for(t in 4:1000){
  for(j in 1:3) x[t] <- x[t] + b[j]*w[t-j]
}

plot(x, type = "l", ylab = expression(x[t]), xlab = "Tiempo t",
     sub = expression(x[t] == w[t] + 0.8*w[t-1] + 0.6*w[t-2] + 0.4*w[t-3]),
     main = "Serie de tiempo simulada de un proceso MA(3)")

###

acf(x, main = "")
title(main = "Correlograma para un proceso MA(3) simulado", 
      sub = expression(x[t] == w[t] + 0.8*w[t-1] + 0.6*w[t-2] + 0.4*w[t-3]))

####################################################################################################################################################

# Ajuste de modelos MA 

x.ma <- arima(x, order = c(0, 0, 3))
x.ma

####################################################################################################################################################

# Modelos ARMA(p, q)


# Simulaci?n y Ajuste

set.seed(1)
x <- arima.sim(n = 10000, list(ar = -0.6, ma = 0.5))
plot(x[1:100], type = "l", xlab = "")
title(main = "Serie simulada", xlab = "Tiempo", 
      sub = expression(x[t] == -0.6*x[t-1] + w[t] + 0.5*w[t-1]))

#

coef(arima(x, order = c(1, 0, 1)))

#### Predicci?n

# Serie de producci?n de electricidad

CBE <- read.csv("cbe.csv", header = TRUE)
Elec.ts <- ts(CBE[, 3], start = 1958, freq = 12)
plot(Elec.ts, xlab = "", ylab = "")
title(main = "Serie de Produccion de Electricidad",
      xlab = "Tiempo",
      ylab = "Produccion de electricidad")

#

plot(log(Elec.ts), xlab = "", ylab = "")
title(main = "Serie-log de Produccion de Electricidad",
      xlab = "Tiempo",
      ylab = "Log de Produccion de electricidad")

#

Time <- 1:length(Elec.ts)
Imth <- cycle(Elec.ts)
Elec.lm <- lm(log(Elec.ts) ~ Time + I(Time^2) + factor(Imth))

#

acf(resid(Elec.lm), main = "")
title(main = "Correlograma de la serie de residuales del modelo de regresion",
      sub = "Serie de produccion de electricidad")

#

plot(resid(Elec.lm), type = "l", main = "", xlab = "", ylab = "")
title(main = "Serie de residuales del modelo de regresion ajustado",
      sub = "Serie de produccion de electricidad",
      xlab = "Tiempo",
      ylab = "Residuales")

###

# Codigo para encontrar el mejor modelo ARMA(p, q) considerando el AIC 
# (Akaike Information Criterion)

best.order <- c(0, 0, 0)
best.aic <- Inf
for(i in 0:2)for(j in 0:2){
  model <- arima(resid(Elec.lm), order = c(i, 0, j))
  fit.aic <- AIC(model)
  if(fit.aic < best.aic){
    best.order <- c(i, 0, j)
    best.arma <- arima(resid(Elec.lm), order = best.order)
    best.aic <- fit.aic
  }
}

best.order

#

acf(resid(best.arma), main = "")
title(main = "Serie de residuales del modelo ARMA(2, 0) ajustado",
      sub = "Serie de residuales del modelo de regresion ajustado a los datos de electricidad")

###

new.time <- seq(length(Elec.ts)+1, length = 36)
new.data <- data.frame(Time = new.time, Imth = rep(1:12, 3))
predict.lm <- predict(Elec.lm, new.data)
predict.arma <- predict(best.arma, n.ahead = 36)
elec.pred <- ts(exp(predict.lm + predict.arma$pred), start = 1991, freq = 12)

#

ts.plot(cbind(Elec.ts, elec.pred), lty = 1:2, 
        col = c("blue", "red"), xlab = "Tiempo", 
        ylab = "Producci?n de electricidad",
        main = "Prediccion de los datos de produccion de electricidad",
        sub = "Prediccion de 36 meses")


