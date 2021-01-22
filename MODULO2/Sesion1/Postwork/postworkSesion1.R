###
#    1. Importar los datos  
###

data <- read.csv('https://www.football-data.co.uk/mmz4281/1920/SP1.csv')

###
#    2. Extraer columnas de goles de casa (FTHG) y visitante (FTAG)
###

FTHG  <- data$FTHG
FTAG <- data$FTAG

###
#    3. Consulta como fuciona la funcion table
###

?table

###
#    4. Elabora tablas de frecuencias relativas  
###

casa <- table(FTHG) 
visitante <- table(FTAG) 
goles <- table(FTHG,FTAG)

###
#    5. Obten la probabilidad marginal de que el equipo
#       en casa o de visita anote x goles
###

total <-sum(goles)
probCasa <- casa/total
probVisita <- visitante/total

###
#    6. Obten la probabilidad conjunta de que el equipo
#       que juega en casa anote x goles y el equipo que
#       juega de visita anote y goles
###

probConjunta <- goles/total
probConjunta
