# 1. Realiza la siguiente simulación con las siguientes características: 
#    n = 1000 valores de un proceso ARIMA(1, 1, 1) con parámetros 
#    ar = 0.6 y ma = 0.2

set.seed(1)
x <- arima.sim(model = list(order = c(1, 1, 1), ar = 0.6, ma = 0.2), n = 1000)

# 2. Ajusta un modelo Arima a la serie simulada para estimar los parámetros y
#    observe las estimaciones de los parámetros

ar.aj <- arima(x, order = c(1, 1, 1))
coefficients(ar.aj)


# 3. Obtén el correlograma de los residuales del ajuste

acf(resid(ar.aj), main = "")
title(main = "Autocorrelaciones para los Residuales del Ajuste")


# 4. Realiza tres predicciones con ayuda del modelo ajustado y la función predict

predicciones <- predict(ar.aj, n.ahead = 3)
predicciones$pred

x.pred <- ts(exp(predicciones$pred), start = 1002, freq = 1)
ts.plot(cbind(x, x.pred), lty = 1:2,
        col = c("blue", "red"), xlab = "Tiempo")
