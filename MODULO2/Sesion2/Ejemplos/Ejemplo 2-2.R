# 2.1 Caracteristicas de los objetos (str sobre df, summary, head y view)

# Funcion str

# str es una funcion que muestra de manera compacta la estructura interna 
# de un objeto de R. Por ejemplo, si usamos como argumento de str el 
# conjunto de datos iris que podemos encontrar en R

str(iris)

# entonces la salida de la instruccion nos muestra el tipo de objeto, 
# numero de observaciones y de variables, asi como el tipo de dato al 
# que corresponde cada variable.

# Funcion summary

# La funcion summary es una funcion generica usada para obtener resumenes 
# de diferentes objetos de R, por ejemplo

summary(1:100)
summary(mtcars)

# Tambien es util para obtener resumenes de los resultados de diferentes
# ajustes a modelos

set.seed(57)
x <- rnorm(35)
e <- rnorm(35)
y <- 5 + 2*x + e
modelo <- lm(y~x)
summary(modelo)

# Funcion head

# La funcion head devuelve la primera parte de un data frame, tabla, 
# matriz, vector o funcion. Por ejemplo, al usar el data frame mtcars
# como argumento de la funcion head, se devolveran unicamente las
# primeras seis filas del data frame

head(mtcars)

# la funcion tail funciona de manera similar, pero en lugar de devolver
# la primera parte de un objeto, devuelve la ultima parte de este,
# por ejemplo, al ejecutarse la siguiente instruccion

tail(mtcars)

# se devolveran las ultimas seis filas del data frame

# Funcion view

# La funcion View aplicada a un objeto de R como un data frame, 
# invoca un visor de datos al estilo de una hoja de calculo, por ejemplo

View(iris)


