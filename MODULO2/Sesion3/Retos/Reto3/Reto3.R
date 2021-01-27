library(forecast)
data(AirPassengers)
AP <- AirPassengers

head(AP)
class(AP)
summary(AP)
# 1. Realiza la grafica de la serie de tiempo

plot(AP, main = "Serie de tiempo", ylab = "Temp", xlab = "Año")

# 2. Descompon la serie de tiempo en aditiva y multiplicativa y realiza sus graficas

decAdit <- decompose(AP, type = "additive")
plot(decAdit)
decMult<- decompose(AP, type = "multiplicative")
plot(decMult)

# 3. Realiza la grafica de la descomposicion aditiva con la tendencia y la estacionalidad utilizando el comando lines

plot(decAdit$trend , main  = "Aditiva", ylab = "Tendencia", xlab = "Año")
lines(decAdit$seasonal + decAdit$trend, col = 2, lty = 2, lwd = 2 )


# 4. Realiza la grafica de la descomposicion multiplicativa con la tendencia y la estacionalidad utilizando el comando lines

plot(decMult$trend , main  = "Multiplicativa", ylab = "Tendencia", xlab = "Año")
lines(decMult$seasonal + decMult$trend, col = 2, lty = 2, lwd = 2 )
