###
#   De la siguiente dirección donde se muestran los sueldos para Data Scientists
#
#   https://www.glassdoor.com.mx/Sueldos/data-scientist-sueldo-SRCH_KO0,14.htm
#
#   realiza las siguientes acciones:
###

# 1. Extraer la tabla del HTML


library(rvest)
url <- "https://www.glassdoor.com.mx/Sueldos/data-scientist-sueldo-SRCH_KO0,14.htm"
file <- read_html(url)
tables <- html_nodes(file, "table") 
table1 <- html_table(tables[1], fill = TRUE)
tabla <- na.omit(as.data.frame(table1)) 
tabla
# 2. Quitar los caracteres no necesarios de la columna sueldos (todo lo que no 
#    sea número), para dejar solamente la cantidad mensual (Hint: la función 
#    gsub podría ser de utilidad)
class(tabla)
sueldos <- tabla$Sueldo
sueldos <- gsub('MXN','',sueldos)
sueldos <- gsub(',','',sueldos)
sueldos <- gsub('/mes','',sueldos)
sueldos <- gsub('\\$','',sueldos)
# 3. Asignar ésta columna como tipo numérico para poder realizar operaciones 
#    con ella

sueldos <- as.numeric(sueldos)

# 4. Ahora podrás responder esta pregunta ¿Cuál es la empresa que más paga y 
#    la que menos paga?
empresa <- tabla$Cargo
empresa <- gsub("Sueldos para Data Scientist en ", "", empresa)
empresa <- gsub("[]-.* ", "", tabla$Cargo)

empresa
result <- cbind(tabla, sueldos)
result
# Sueldo más alto
max.sueldo <- which.max(result$sueldos)
result[max.sueldo,]

# Sueldo más bajo
min.sueldo <- which.min(result$sueldos)
result[min.sueldo,]



#Link al otro repo --> Reto 3
# https://github.com/EmilyMaPe/Reto_Sesion_7