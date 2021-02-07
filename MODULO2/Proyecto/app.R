#####
#   Para la reproduccion de este proyecto 
#      *  es necesario cambiar las rutas de acceso hacia la carpeta stocks 
#         en las lineas : 217, 239, 286
#      *  contar con la carpeta www con la imagen contenida
#      *  contar con los datasets contenidos en la carpeta stocks
#   
#####

#####
#   Cargamos las librerias que estaremos utilizando
#####
library(shiny)
library(shinydashboard)
library(dplyr)
library(ggplot2)
library(reshape2)
library(data.table)
library(TSA)
library(forecast)

#####
#   Empezamos el segmento de la interfaz de usuario de nuestra shiny web app
#####

ui <- fluidPage(

   dashboardPage(
       dashboardHeader(title = "Proyecto Final"),
       #####
       #   Declaramos las pestañas que queremos en nuestro menu lateral
       #####
       dashboardSidebar(
           sidebarMenu(
               menuItem("Explora los stock price", tabName = "stock", icon = icon("chart-line")),
               menuItem("Prediccion", tabName = "predict", icon = icon("question")),
               menuItem("Comparación", tabName = "volume", icon = icon("chart-bar")),
               menuItem("Equipo", tabName = "equipo", icon = icon("users"))
           )
       ),
       #####
       #   Declaramos los estilos que queremos usar en nuestra shiny web app
       #####
       dashboardBody(
           tags$head(tags$style(HTML('
                                /*Proyecto Final*/
                                .skin-blue .main-header .logo {
                                background-color: #a66ccc; 
                                }
                                .skin-blue .main-header .navbar {
                                background-color: #a66ccc;
                                }

                                /* sidebar */
                                .skin-blue .main-sidebar {
                                background-color: #a66ccc;
                                }
                                .skin-blue .main-sidebar .sidebar .sidebar-menu a{
                                background-color: #a66ccc;
                                color: #000000;
                                }

                                /* item seleccionado*/
                                .skin-blue .main-sidebar .sidebar .sidebar-menu .active a{
                                background-color: #ff69b4;
                                }

                                /* items hover */
                                .skin-blue .main-sidebar .sidebar .sidebar-menu a:hover{
                                background-color: #7e15c2;
                                }
                                
                                /* toggle button when hovered  */
                                 /* toggle button when hovered  */
                                .skin-blue .main-header .navbar .sidebar-toggle{
                                background-color: #7e15c2;
                                }
                                .skin-blue .main-header .navbar .sidebar-toggle:hover{
                                background-color: #a66ccc;
                                }

                                /* body */
                                .content-wrapper, .right-side {
                                background-color: #fff985;
                                }

                                '))),
           #####
           #   Que contenido va a tener cada pestaña de nuestra app
           #   --> tab name : el nombre que se declaro en las pestañas
           #   --> selectInput : opciones dinamicas
           #   --> dateInput : seleccion de fechas
           #   --> mainPanel: Donde se mostraran nuestras graficas
           #####
           tabItems(
               tabItem(
                   tabName = "stock",
                   fluidRow(
                       titlePanel("Serie de tiempo"),
                       column(3,
                              selectInput("company",
                                          h3("Company"),
                                          choices= c("Apple" = "AAPL", 
                                                     "AMC Entertainment" = "AMC",
                                                     "Amazon" = "AMZN",
                                                     "Black Berry" = "BB",
                                                     "Facebook" = "FB",
                                                     "General Motors" = "GM",
                                                     "GameStop" = "GME",
                                                     "Coca Cola" = "KO",
                                                     "Microsoft" = "MSFT",
                                                     "Tesla" = "TSLA"),
                                          selected = "Apple")),
                       column(3,
                              selectInput("price",
                                          h3("Price"),
                                          choices= c("Open price" = "Open", 
                                                     "Close Price" = "Close",
                                                     "Higher Price" = "High",
                                                     "Lower Price" = "Low"),
                                          selected = "Apple")),
                       column(3,
                              dateInput("start_date",
                                        h3("Start Date"),
                                        value="2016-05-01")),
                       column(3,
                              dateInput("end_date",
                                        h3("End Date"),
                                        value="2017-05-01")),
                       mainPanel(
                           plotOutput("Result")
                       )
                   )
               ),
               tabItem(
                   tabName = "predict",
                   fluidRow(
                       titlePanel("Predicción de Enero 2021 con datos del 2020 con Arima"),
                       column(5,
                              selectInput("companyts",
                                          h3("Company"),
                                          choices= c("Apple" = "AAPL", 
                                                     "AMC Entertainment" = "AMC",
                                                     "Amazon" = "AMZN",
                                                     "Black Berry" = "BB",
                                                     "Facebook" = "FB",
                                                     "General Motors" = "GM",
                                                     "GameStop" = "GME",
                                                     "Coca Cola" = "KO",
                                                     "Microsoft" = "MSFT",
                                                     "Tesla" = "TSLA"),
                                          selected = "Apple")),
                       column(5,
                              selectInput("pricets",
                                          h3("Price"),
                                          choices= c("Open price" = "Open", 
                                                     "Close Price" = "Close",
                                                     "Higher Price" = "High",
                                                     "Lower Price" = "Low"),
                                          selected = "Apple")),
                       mainPanel(
                           plotOutput("Predict")
                       )
                   )
               ),
               tabItem(
                   tabName = "volume",
                   fluidRow(
                       titlePanel("Relacion precio vs volumen"),
                       column(5,
                              selectInput("companyvol",
                                          h3("Company"),
                                          choices= c("Apple" = "AAPL", 
                                                     "AMC Entertainment" = "AMC",
                                                     "Amazon" = "AMZN",
                                                     "Black Berry" = "BB",
                                                     "Facebook" = "FB",
                                                     "General Motors" = "GM",
                                                     "GameStop" = "GME",
                                                     "Coca Cola" = "KO",
                                                     "Microsoft" = "MSFT",
                                                     "Tesla" = "TSLA"),
                                          selected = "Apple")),
                       mainPanel(
                           plotOutput("Volume")
                       )
                   )
               ),
               tabItem(
                   tabName = "equipo",
                   fluidRow(
                       titlePanel("Programacion y estadistica con R Equipo 9"),
                       h3("Emily"),
                       h3("Samantha"),
                       h3("Sofia"),
                       img(src = "bedusantander.png",
                           height = 300, width = 600)
                       
                       
                   )
               )
           )
       )
   )
)

#####
#   En cada output estaremos guardando las graficas y resultados para mostrar en el ui
#####
server <- function(input, output) {

    #####
    #   Exploracion de los datos con series de tiempo
    #####
    output$Result <- renderPlot({
        library(data.table)
        setwd("C:/Users/monts/SantanderBEDU/MODULO2/Proyecto/stocks")
        # Leemos los archivos y los juntamos en un solo dataframe
        list_of_files <- list.files(path = ".", recursive = TRUE,
                                    pattern = "\\.csv$", 
                                    full.names = TRUE)
        DT <- rbindlist(sapply(list_of_files, fread, simplify = FALSE),
                        use.names = TRUE, idcol = "FileName")
        DT$FileName <- gsub(".csv", "", DT$FileName)
        DT$FileName <- gsub("./", "", DT$FileName)
        y<- input$price
        ts.p <- ts(filter(DT, FileName  == input$company) %>% select(y),  start = input$start_date, end = input$end_date)
        ts.plot(ts.p, main = input$company, col = 4, ylab = paste(input$price, " Price"))
        
        
    })
    #####
    #   Hipotesis: la prediccion de los precios sera acertada para mercados estables
    #   Con el analisis de las graficas pudimos ver que para la mayoria de los casos
    #   el precio real se mantiene dentro de nuestro intervalo de prediccion. 
    #####
    output$Predict <- renderPlot({
        library(data.table)
        setwd("C:/Users/monts/SantanderBEDU/MODULO2/Proyecto/stocks")
        list_of_files <- list.files(path = ".", recursive = TRUE,
                                    pattern = "\\.csv$", 
                                    full.names = TRUE)
        DT <- rbindlist(sapply(list_of_files, fread, simplify = FALSE),
                        use.names = TRUE, idcol = "FileName")
        DT$FileName <- gsub(".csv", "", DT$FileName)
        DT$FileName <- gsub("./", "", DT$FileName)
        data <- filter(DT, FileName == input$companyts)
        y<- input$pricets
        #####
        #   Se crean dos series de tiempo, una con datos hasta diciembre de 2020
        #   y otra hasta febrero de 2021.
        #   La primera para poder predecir el precio de enero de 2021 y la segunda
        #   para poder ver que tan acertada fue nuestra prediccion
        #####
        actual <- ts(data %>% select(y), start = c(2019, 1), end = c(2020,12), 365)
        actual2 <- ts(data %>% select(y),start = c(2019,1), end = c(2021,2), 365)
        #####
        #   Con la primera serie haremos una prediccion con ayuda de la funcion 
        #   arima y la funcion forecast
        #####
        fit = auto.arima(actual, allowdrift = T)
        future = forecast(fit, h=100)
        #####
        #   Graficamos nuestra grafica con la prediccion y nuestra grafica con 
        #   los datos reales/verdaderos
        #####
        par(mfrow = c(1,2))
        plot(future, main = "Prediccion")
        ts.plot(actual2, main = "Real")
        
    })
    #####
    #   Hipotesis: El volumen de acciones vendidas tiene relacion con el precio
    #   promedio de las acciones. Es decir a mayor demanda, mayor precio. 
    #   Segun los resultados que nos dieron pudimos notar que no siempre tiene 
    #   una relacion significativa, llegamos a la conclusion de que existen factores 
    #   externos que determinan el precio de las acciones, siendo una de ellos el 
    #   volumen de acciones vendidas. 
    ###
    output$Volume <- renderPlot({
        library(dplyr)
        library(ggplot2)
        library(reshape2)
        library(data.table)
        
        setwd("C:/Users/monts/SantanderBEDU/MODULO2/Proyecto/stocks")
        list_of_files <- list.files(path = ".", recursive = TRUE,
                                    pattern = "\\.csv$", 
                                    full.names = TRUE)
        DT <- rbindlist(sapply(list_of_files, fread, simplify = FALSE),
                        use.names = TRUE, idcol = "FileName")
        DT$FileName <- gsub(".csv", "", DT$FileName)
        DT$FileName <- gsub("./", "", DT$FileName)
        data <- filter(DT, FileName == input$companyvol)
        volume <- data %>% select(Date, Volume, Close)
        #####
        #   Manipulamos los tipos de datos para poder hacer el analisis deseado. 
        #   En este caso la agrupacion de los datos por meses, sumando el total,
        #   de acciones vendidas y sacando el promedio del precio de la accion
        #   en un mes deterimnado.
        #####
        volume$Date <- as.Date(volume$Date)
        volume$Date <- format(volume$Date, "%Y-%m")
        meses <- volume %>% group_by(Date) %>% summarise(sum(Volume), mean(Close))
        datos <- as.data.frame(meses)
        datos <- rename(datos, Volume = 'sum(Volume)')
        datos <- rename(datos, Close = 'mean(Close)')
        #####
        #   Para un mejor analisis realizaremos una estandarizacion de los datos
        #####
        range01 <- function(x){(x-min(x))/(max(x)-min(x))}
        datos$Volume <- range01(datos$Volume)
        datos$Close <- range01(datos$Close)
        fin <- dim(datos)[1]
        inicio = fin-25
        datos1 <- datos[inicio:fin,]
        row.names(datos1) <- NULL
        #####
        #   Hacemos un reshape de los datos para poderlos graficar
        #####
        grafica <- melt(cbind(datos1[1], as.matrix(datos1[-1])), id = c("Date"))
        #####
        #   Graficamos los la media del precio por mes, y el volumen total de venta
        #####
        ggplot(grafica) +
            ggtitle(input$companyvol) +
            geom_bar(aes(y = Date, x = value, fill = variable), 
                     stat="identity", position = "dodge", width = 0.7) +
            scale_fill_manual("Result\n", values = c("red","blue"), 
                              labels = c("Volume", "Close")) +
            labs(x="\nNumber",y="Result\n") +
            theme_bw(base_size = 14)
    })
}

shinyApp(ui = ui, server = server)
