# Ejemplo 3. Listas y data frames

# Objetivo
# Crear listas y data frames
# Extraer información de estos
# Cálculo de estadísticos básicos

# Requisitos

# Prework
# R, RStudio
# Ejemplos 1 y 2

# Desarrollo

# Seguir el contenido y tratar de comprender el código mostrado a continuación

# Listas

(milista <- list(nombre = "Pepe", no.hijos = 3, edades.hijos = c(4, 7, 9)))

# propiedades de la lista

str(milista)

# Extrayendo elementos de la lista, recuerda que para ingresar se debe usar el símbolo $
  
milista$nombre

# Creando data frames

x <- 6:8
y <- c("A", "B", "C")
(myfile <- data.frame(edad = x, grupo = y))


#str es de estructura
str(myfile)

# Extrayendo información del df, se hace igual que con las matrices

myfile[1]
myfile[,1]
myfile$edad

# Calculando algunos estadísticos básicos

mean(myfile$edad)

# Podemos hacer uso de la función `paste` para agregar un mensaje

paste("La media de la edad es:", mean(myfile$edad))
print("La media de la edad es:", mean(myfile$edad))

# Podemos inspeccionar a detalle el df utilizando `summary`

summary(myfile)

# También se puede conocer su dimensión
#filas columnas
dim(myfile)

# Podemos agregar una columna extra con datos

myfile$sexo <- c("H", "M", "H")
myfile

# Si fuera el caso, se puede eliminar una columna

myfile$sexo <- NULL
myfile
