# 1. Leer el archivo "netflix_titles.csv" desde Github (https://raw.githubusercontent.com/ecoronadoj/Sesion_1/main/Data/netflix_titles.csv),
# almacenarlo en un df llamado netflix

netflix <- read.csv("https://raw.githubusercontent.com/ecoronadoj/Sesion_1/main/Data/netflix_titles.csv")

# 2. Obtener la dimensión y el tipo de objeto que se obtiene

dim(netflix)

# 3. Obtener los títulos que se estrenaron después del 2015. Almacenar este df en una variable llamada net.2015 (Hint: primero podrías filtrar solo aquellas filas del data frame que corresponden a estrenos después del 2015, por ejemplo, dataframe[columna > 2015, ])

data <- netflix[which(netflix$release_year > 2015),]
data$title

# 4. Escribir los resultados en un archivo .csv llamado res.netflix.csv (Hint: consulta la función write.csv)

write.csv(x = data$title, file = 'res.netflix.csv')
