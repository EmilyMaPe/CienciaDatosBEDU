# Ejemplo 2. Matrices

# Objetivo

# Crear nuevas matrices
# Extraer datos dentro de una matriz
# Calcular sus dimensiones
# Realizar operaciones basicas entre matrices


# Desarrollo

# Se debe seguir el codigo propuesto y tratar de compreder que es lo que realiza

# Crear Matrices. 

(m <- matrix(1:9, nrow = 3, ncol = 3))

# Extrayendo la primera entrada

m[1,1]

# Extrayendo la primer columna, con todas sus filas

m[ ,1]

# ¿Que sucede si se suma un vector y una matriz?

(sum.vecmat <- c(1, 2) + m)

# Creando otra matriz

(n <- matrix(2:7, 4, 6))

# Podemos conocer la dimension de la matriz asi

dim(n)

# Extrayendo subconjuntos de la matriz

n[n > 4] 

# Ahora veremos como localizar la posicion de las entradas anteriores

which(n > 4)

# Uniendo Vectores para formar una matriz

a <- 2:6
b <- 5:9

# Construyendo la matriz utilizando la funcion cbind, para unirlos por culumna

cbind(a,b)

# Construyendo la matriz utilizando la funcion rbind, para unirlos por fila

rbind(a,b)

# Aplicando una funcion a las filas o columnas de una matriz (mean, sort)
# 1 por fila
#2 po columna
apply(n, 1, mean)
apply(n, 2, sort)
apply(n,1,sort)

# Algunas operaciones basicas de matrices

# Producto matricial: A %*% B
# Producto elemento a elemento: A*B
# Traspuesta: t(A)
# Determinante: det(A)
# Extraer la diagonal: diag(A)
# Resolver un sistema de ecuaciones lineales (( Ax=b )): solve(A,b)
# Inversa: solve(A)
# Autovalores y autovectores: eigen(A)