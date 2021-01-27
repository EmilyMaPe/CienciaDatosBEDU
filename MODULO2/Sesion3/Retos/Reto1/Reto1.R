library(ggplot2)

# 1. Carga el data set BD_Altura_Alunos.csv
alturas <- read.csv("C:/Users/monts/SantanderBEDU/MODULO2/Sesion3/Retos/Reto1/BD_Altura_Alunos.csv", sep = ";")

# 2. Realiza el histograma con la funcion hist(), nativa de R

hist(alturas$Altura, breaks = seq(140,200, 5), 
     main = "Histograma de Alturas de los alumnos",
     xlab = "Altura",
     ylab = "Frecuencia")

# 3. Ahora realiza el histograma con la funcion ggplot. (Recuerda que debes instalar el paquete ggplot2)
ggplot(alturas, aes(Altura))+
  geom_histogram(binwidth = 4, col = "black", fill = "slateblue") +
  ggtitle("Histograma de Alturas de los alumnos") + 
  ylab("Frecuencia") + 
  xlab("Altura") + 
  theme_light()
