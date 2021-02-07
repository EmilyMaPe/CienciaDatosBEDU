library(shiny)
library(shinydashboard)
library(dplyr)
library(ggplot2)
library(reshape2)
library(data.table)
library(TSA)
library(forecast)
ui <- fluidPage(

   dashboardPage(
       dashboardHeader(title = "Proyecto Final"),
       dashboardSidebar(
           sidebarMenu(
               menuItem("Explora los stock price", tabName = "stock", icon = icon("chart-line")),
               menuItem("Prediccion", tabName = "predict", icon = icon("question")),
               menuItem("Comparación", tabName = "volume", icon = icon("chart-bar")),
               menuItem("Equipo", tabName = "equipo", icon = icon("users"))
           )
       ),
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

# Define server logic required to draw a histogram
server <- function(input, output) {

    output$Result <- renderPlot({
        library(data.table)
        setwd("C:/Users/monts/SantanderBEDU/MODULO2/Proyecto/stocks")
        # Read all the files and create a FileName column to store filenames
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
        actual <- ts(data %>% select(y), start = c(2019, 1), end = c(2020,12), 365)
        actual2 <- ts(data %>% select(y),start = c(2019,1), end = c(2021,2), 365)
        fit = auto.arima(actual, allowdrift = T)
        future = forecast(fit, h=100)
        par(mfrow = c(1,2))
        plot(future, main = "Prediccion")
        ts.plot(actual2, main = "Real")
        
    })
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
        volume$Date <- as.Date(volume$Date)
        volume$Date <- format(volume$Date, "%Y-%m")
        meses <- volume %>% group_by(Date) %>% summarise(sum(Volume), mean(Close))
        datos <- as.data.frame(meses)
        datos <- rename(datos, Volume = 'sum(Volume)')
        datos <- rename(datos, Close = 'mean(Close)')
        range01 <- function(x){(x-min(x))/(max(x)-min(x))}
        datos$Volume <- range01(datos$Volume)
        datos$Close <- range01(datos$Close)
        fin <- dim(datos)[1]
        inicio = fin-25
        datos1 <- datos[inicio:fin,]
        row.names(datos1) <- NULL
        grafica <- melt(cbind(datos1[1], as.matrix(datos1[-1])), id = c("Date"))
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

# Run the application 
shinyApp(ui = ui, server = server)
