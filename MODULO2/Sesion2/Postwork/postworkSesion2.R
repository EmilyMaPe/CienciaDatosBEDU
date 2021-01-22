# 1. Importa los datos de soccer de las temporadas 2017/2018, 2018/2019 y 
#    2019/2020 de la primera division de la liga española a R, los datos los 
#    puedes encontrar en el siguiente enlace: https://www.football-data.co.uk/spainm.php

setwd("C:/Users/monts/SantanderBEDU/MODULO2/Data/Football")
lista <- lapply(dir(), read.csv)
# 2. Obten una mejor idea de las caracteristicas de los data frames al usar las
#    funciones: str, head, View y summary
lapply(lista, str)
lapply(lista, head)
lapply(lista, summary)

# 3. Con la funcion select del paquete dplyr selecciona unicamente las columnas
#    Date, HomeTeam, AwayTeam, FTHG, FTAG y FTR; esto para cada uno de los data 
#    frames. (Hint: tambien puedes usar lapply).

lista2 <- lapply(lista, select, Date, HomeTeam:FTR)

# 4. Asegurate de que los elementos de las columnas correspondientes de los
#    nuevos data frames sean del mismo tipo (Hint 1: usa as.Date y mutate para 
#    arreglar las fechas). Con ayuda de la funcion rbind forma un unico data 
#    frame que contenga las seis columnas mencionadas en el punto 3 
#    (Hint 2: la funcion do.call podria ser utilizada).

lista2 <- lapply(lista2, mutate)
data <- do.call(rbind, lista2)

