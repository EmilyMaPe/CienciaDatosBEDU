###
#   Con el conjunto de datos soccer.csv realiza lo siguiente
###
setwd("C:/Users/monts/SantanderBEDU/MODULO2/Sesion6/Retos/Reto3")
data <- read.csv("soccer.csv")
data <- mutate(data, date = as.Date(date, "%Y-%m-%d"))
# 1. Crea un data frame para el Barcelona que indique el número de goles 
#    anotados en cada fecha que ha jugado.


casa <- data %>% select(date, home.team, home.score) %>% 
  filter(home.team == "Barcelona") %>% 
  rename(fecha = date, equipo = home.team, goles = home.score)

visita <- data %>% select(date, away.team, away.score) %>% 
  filter(away.team == "Barcelona") %>% 
  rename(fecha = date, equipo = away.team, goles = away.score)

anotaciones <- rbind(casa, visita)
# 2. Obtén un data frame que indique el promedio de goles anotados en cada mes 
#    que ha jugado

anotaciones <- mutate(anotaciones, Ym = format(fecha, "%Y-%m"))
barcelona <- anotaciones %>% group_by(Ym) %>% summarise(goles = mean(goles))
# 3. Crea una serie de tiempo mensual para el número promedio de goles anotados 
#    por el Barcelona

tsBarcelona <- ts(barcelona$goles, start = c(1,1), end = c(3,5), frequency = 10) 

# 4. Realiza los pasos 1 a 3 para el Real Madrid
casa <- data %>% select(date, home.team, home.score) %>% 
  filter(home.team == "Real Madrid") %>% 
  rename(fecha = date, equipo = home.team, goles = home.score)

visita <- data %>% select(date, away.team, away.score) %>% 
  filter(away.team == "Real Madrid") %>% 
  rename(fecha = date, equipo = away.team, goles = away.score)

anotaciones <- rbind(casa, visita)
anotaciones <- mutate(anotaciones, Ym = format(fecha, "%Y-%m"))
realMadrid <- anotaciones %>% group_by(Ym) %>% summarise(goles = mean(goles))
tsRealMadrid <- ts(realMadrid$goles, start = c(1,1), end = c(3,5), frequency = 10) 

# 5. Muestra en una misma imagen las gráficas de las series de tiempo anteriores

ts.plot(cbind(tsBarcelona, tsRealMadrid), col = c(2, 4), ylim = c(0, 5))
abline(h = mean(tsBarcelona), lwd = 2, col = 2, lty = 2)
abline(h = mean(tsRealMadrid), lwd = 2, col = 4, lty = 2)
legend(x = 2, y = 5,
       legend = c("Barcelona", "Real Madrid"),
       col = c(2, 4), lty = c(1, 1))
