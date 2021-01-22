#1. Genera un vector de 44 entradas (aleatorias) llamado ran
#2. Escribe un loop que eleve al cubo las primeras 15 entradas y les sume 12
#3. Guarda el resultado en un data frame, donde la primera columna sea el numero aleatorio y la segunda el resultado, nombralo df.al
#4. Escribe el pseudocódigo del loop anterior

ran <- rnorm(44)
ran

cubo <- 0

for(x in 1:15){
    cubo[x] <- ran[x]**3 + 12
}

df.al <- data.frame(ran[1:15], cubo)
df.al



#for(x in 1:15){  loop desde 1 hasta 15
#    cubo[x] <- ran[x]**3 + 12   se realiza la operacion
#}