# 1. Descargue los archivos csv que corresponden a las temporadas 2017/2018,
# 2018/2019, 2019/2020 y 2020/2021 de la Bundesliga 1 y que se encuentran en el
#siguiente enlace https://www.football-data.co.uk/germanym.php

url1 <- "https://www.football-data.co.uk/mmz4281/1718/D1.csv"
url2 <- "https://www.football-data.co.uk/mmz4281/1819/D1.csv"
url3 <- "https://www.football-data.co.uk/mmz4281/1920/D1.csv"
url4 <- "https://www.football-data.co.uk/mmz4281/2021/D1.csv"

setwd("C:/Users/monts/SantanderBEDU/MODULO2/Sesion2/Retos/Reto3")

download.file(url = url1, destfile = "temp1718.csv", mode = "wb")
download.file(url =  url2, destfile = "temp1819.csv", mode = "wb")
download.file(url =  url3, destfile = "temp1920.csv", mode = "wb")
download.file(url =  url4, destfile = "temp2021.csv", mode = "wb")


#2. Importe los archivos descargados a R

temp17_18 <- read.csv("temp1718.csv")
temp18_19 <- read.csv("temp1819.csv")
temp19_20 <- read.csv("temp1920.csv")
temp20_21 <- read.csv("temp2021.csv")

# 3. Usando la función select del paquete dplyr, seleccione únicamente las columnas:
#Date
#HomeTeam
#AwayTeam
#FTHG
#FTAG
#FTR

suppressMessages(suppressWarnings(library(dplyr)))

attach(temp17_18)
t17_18 <- select(temp17_18, Date, HomeTeam, AwayTeam, FTHG, FTAG, FTR)
detach(temp17_18)

attach(temp18_19)
t18_19 <- select(temp18_19, Date, HomeTeam, AwayTeam, FTHG, FTAG, FTR)
detach(temp18_19)

attach(temp19_20)
t19_20 <- select(temp19_20, Date, HomeTeam, AwayTeam, FTHG, FTAG, FTR)
detach(temp19_20)

attach(temp20_21)
t20_21 <- select(temp20_21, Date, HomeTeam, AwayTeam, FTHG, FTAG, FTR)
detach(temp20_21)

#4. Combine cada uno de los data frames en un único data frame con ayuda de las funciones:
#rbind
t17_20 <- rbind(t17_18,t18_19,t19_20,t20_21, deparse.level = 1) 


#do.call
lista <- lapply(dir(), read.csv)
lista2 <- lapply(lista, select, Date, HomeTeam:FTR)
data <- do.call(rbind, lista2)
head(data)
dim(data)
