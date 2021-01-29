library(DBI)
library(RMySQL)
library(ggplot2)
MyDataBase <- dbConnect(
  drv = RMySQL::MySQL(),
  dbname = "shinydemo",
  host = "shiny-demo.csa7qlmguqrf.us-east-1.rds.amazonaws.com",
  username = "guest",
  password = "guest")
library(dplyr)
dbListTables(MyDataBase)
languages <- dbGetQuery(MyDataBase, "select * from CountryLanguage")
head(languages)
esp <-  languages %>% filter(Language == "Spanish")
esp
esp %>% ggplot(aes( x = CountryCode, y=Percentage, fill = IsOfficial )) +
  geom_bar(position = "dodge", stat="identity")+
  geom_bin2d()+
  coord_flip()
