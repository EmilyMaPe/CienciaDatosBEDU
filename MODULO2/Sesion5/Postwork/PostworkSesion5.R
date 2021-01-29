# 1. A partir del conjunto de datos de soccer de la liga española de las 
#    temporadas 2017/2018, 2018/2019 y 2019/2020, crea el data frame SmallData, 
#    que contenga las columnas date, home.team, home.score, away.team y 
#    away.score; esto lo puede hacer con ayuda de la función select del paquete 
#    dplyr. Luego establece un directorio de trabajo y con ayuda de la función 
#    write.csv guarda el data frame como un archivo csv con nombre soccer.csv.
#    Puedes colocar como argumento row.names = FALSE en write.csv.


library(dplyr)
setwd("C:/Users/monts/SantanderBEDU/MODULO2/Data/Football")
t1718 <- read.csv("temp1718.csv")
t1819 <- read.csv("temp1819.csv")
t1920 <- read.csv("temp1920.csv")
t1718 <- rename(t1718, date = Date,  home.team = HomeTeam , home.score=FTHG, away.team= AwayTeam,  away.score=   FTAG )
t1819 <- rename(t1819, date = Date,  home.team = HomeTeam , home.score=FTHG, away.team= AwayTeam,  away.score=   FTAG )
t1920 <- rename(t1920, date = Date,  home.team = HomeTeam , home.score=FTHG, away.team= AwayTeam,  away.score=   FTAG )
t1718 <- t1718 %>% select(date, home.team,home.score, away.team, away.score)
t1819 <- t1819 %>% select(date, home.team,home.score, away.team, away.score)
t1920 <- t1920 %>% select(date, home.team,home.score, away.team, away.score)
SmallData <- rbind(t1718, t1819, t1920)
SmallData <- mutate(SmallData, date = as.Date(date, "%d/%m/%Y"))
SmallData$date <- gsub('0017', '2017', SmallData$date)
SmallData$date <- gsub('0018', '2018', SmallData$date)
SmallData

setwd("C:/Users/monts/SantanderBEDU/MODULO2/Sesion5/Postwork")
write.csv(SmallData, "soccer.csv", row.names = FALSE)

# 2. Con la función create.fbRanks.dataframes del paquete fbRanks importe el
#    archivo soccer.csv a R y al mismo tiempo asignelo a una variable llamada 
#    listasoccer. Se creará una lista con los elementos scores y teams que son 
#    data frames listos para la función rank.teams. Asigna estos data frames a 
#    variables llamadas anotaciones y equipos.
library(fbRanks)
listasoccer <- create.fbRanks.dataframes(scores.file = "soccer.csv")

anotaciones <- listasoccer$scores
equipos <- listasoccer$teams
  
# 3. Con ayuda de la función unique crea un vector de fechas (fecha) que no se 
#    repitan y que correspondan a las fechas en las que se jugaron partidos. Crea
#    una variable llamada n que contenga el número de fechas diferentes.
#    Posteriormente, con la función rank.teams y usando como argumentos los data
#    frames anotaciones y equipos, crea un ranking de equipos usando unicamente 
#    datos desde la fecha inicial y hasta la penúltima fecha en la que se jugaron
#    partidos, estas fechas las deberá especificar en max.date y min.date. Guarda 
#    los resultados con el nombre ranking.

fecha <- unique(anotaciones$date)
fecha <- sort(fecha)
n <- length(fecha)
ranking <- rank.teams(anotaciones, teams = equipos, max.date = fecha[n-1], min.date = fecha[1])

# 4. Finalmente estima las probabilidades de los eventos, el equipo de casa gana,
#    el equipo visitante gana o el resultado es un empate para los partidos que
#    se jugaron en la última fecha del vector de fechas fecha. Esto lo puedes 
#    hacer con ayuda de la función predict y usando como argumentos ranking y 
#    fecha[n] que deberá especificar en date.

predict(ranking, date = fecha[n])
