#########################
##  Syllabus Session 2 ##
#########################

"
- Carga de datos
- Google Analytics Reporting API
- Gráficos
- 
"

####################
## Carga de datos ##
####################
library(data.table)

help(iris)
str(iris)
dim(iris)

write.table(iris, file = "iris.test.csv", sep = ";", row.names=FALSE)
DT<-fread("iris.test.csv",sep = ";", fill = T)
DT<-fread("iris.test.csv",sep = ";", fill = T, select = c("Species","Sepal.Width"))
head(DT)

# install.packages("rjson")
library(rjson)
## Read JSON file
json_example <- fromJSON('{"id":1,"name":"leche","price":12.5,"tags":["desnatada","sin lactosa"]}')
class(json_example)
json_example
cat(paste("El producto con Id:",json_example$id, sep = " ","tiene un precio de",json_example$price))
json_example$tags[1]
json_example$tags[2]

####################
###### GA API ######
####################

# install.packages("RCurl")
# install.packages("jsonlite")
# install.packages("bitops")
# install.packages("devtools")
# library(devtools) # Cargamos devtools
# install_github("rga", "skardhamar")

library(rga)

client.id <- ""
client.secret <- ""

# Instanciamos
rga.open(instance="ga", client.id=client.id, client.secret=client.secret)

# Query A
date.start <- "2017-01-01"
date.end <- "2017-05-31"
ids <- 123

datos.a <- ga$getData(ids, date.start, date.end, 
                      metrics = "ga:hits, ga:sessions, ga:users, ga:pageviews, ga:avgSessionDuration", 
                      dimensions = "ga:date, ga:deviceCategory", 
                      sort = "", filters = "", segment = "",
                      start = 1)

nrow(datos.a)
head(datos.a)
summary(datos.a)

# write.csv(datos, file = "ReportGA.csv")

####################
###### GRAPHS ######
####################

f = c("H","M","M","M","M","H","M","H","M","M")
sex = factor(f,levels=c("H","M"),ordered=TRUE)
table(f)
plot(sex, main = "Factor Plot")

c <- sample(1:1000, size = 200, replace = FALSE)
plot(c, main = "Numeric Vector", xlab = "Vector Pos", ylab = "Vector Value")

m <- matrix(nrow = 6, ncol = 5, sample(1:3, replace = FALSE))
plot(m, main = "Matrix")

#### Hist
d <- sample(c(1,2,3), size = 100, replace = T)
hist(d, main = "Histogram of Vector d", ylab = "Total", xlab = "Value", xlim = c(1,3), breaks = c(1,2,3))

BMI<-rnorm(n=1000, mean = 25.6, sd=2.2)
hist(BMI, breaks = 25)

#### Heatmap
x <- 1:10; y <- 1:15; z <- matrix(nrow = 10, ncol = 15, sample(1:30, replace = T))
image(x,y,z)
