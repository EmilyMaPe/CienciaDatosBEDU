###
#   En el archivo de datos csv adjunto se encuentran observaciones 
#   correspondientes a dos clases diferentes indicadas por la variable y. 
#   Únicamente hay dos variables predictoras o características. A continuación 
#   realice los siguientes requerimientos (Hint: transforme primero la variable 
#   de respuesta y a variable categórica con las funciones mutate y factor):
### 

setwd("C:/Users/monts/SantanderBEDU/MODULO2/Sesion5/Retos/Reto2")
data <- read.csv("datosclases.csv")
data <- mutate(data, y = factor(y))
# 1. Carga los paquetes ggplot2 y e1071; observe algunas características del
#    data frame con las funciones tail y dim. Obtenga el gráfico de dispersión 
#    de los datos diferenciando las dos clases.

library(ggplot2)
library(e1071)
tail(data)
dim(data)
plot(data$x.1, data$x.2, main="Grafico de dispercion")

# 2. Genera de manera aleatoria un vector de índices para filtrar un conjunto
#    de entrenamiento a partir del conjunto de datos dado. Con ayuda de las 
#    funciones tune y svm ajuste máquinas de vectores de soporte con un kernel
#    radial a los datos de entrenamiento, para valores del parámetro cost igual 
#    a 0.1, 1, 10, 100, 1000 y valores del parámetro gamma igual a 0.5, 1, 2, 
#    3, 4. Obtenga un resumen de los resultados.

train <- sample(300, 150)
tail(as.data.frame(train))


tune.out <- tune(svm, y~., data = data[train, ], 
                 kernel = "radial", 
                 ranges = list(cost = c(0.1, 1, 10, 100, 1000), 
                               gamma = c(0.5, 1, 2, 3, 4)))

summary(tune.out)

# 3. Con el modelo que tuvo el mejor desempeño en el paso anterior realiza 
#    clasificación con la función predict y el conjunto de datos de prueba.
#    Muestre la matriz de confusión.

table(true = data[-train, "y"], 
      pred = predict(tune.out$best.model, newdata = data[-train,]))
