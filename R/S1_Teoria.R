#########################
##  Syllabus Session 1 ##
#########################

"
- Introducción a los entornos de trabajo. Interprete de R y RStdudio.
- Objetos en R.
- Tipos de datos y estructuras de lenguajes: vectores, listas, matrices, dataframes y datatables.
- Sintaxis básica y estructuras de control como bucles, sentencias condicionales.

"

###################
#### 3. Objects ###
###################

a <- "abc"
mode(a)
ls()
objects()
rm(list=ls())

###################
## 4. Data Types ##
###################

## 4.1 Vector

#### Creation
a = c(1, 3, 5, 7)
b = vector(mode = "numeric", length = 2)
c <- c(1,2)
d = c("a", 1)

typeof(a)
mode(a)

#### Concat
g <- c(a,c)
f <- c(a,d)
class(f)

#### Arithmetic operations
a+b; a+c;
a*5
sum(a)
mean(a)
median(a)
a+median(a)

#### Selection
a[2]
a[2:3]
a[-(2:3)]
a[c(2,4)]

a[a > 3]
a[a %in% c(1:3)]

x <- c(1,2,3,4)
names(x) <- c("a","b","c","d")
x["a"]

rm(list=ls())

## 4.2 Matrix

#### Creation
A <- matrix(nrow = 2, ncol = 3, sample(1:10, size = 6, replace = FALSE))
B <- matrix(nrow = 2, ncol = 3, rep(1:2, length(6)))
C <- matrix(nrow = 2, ncol = 3, rep(1:2, length(6)), byrow = T)

#### Selection
A[1,]
B[1,2]
C[1,1:2]

#### Functions
t(B) # t returns the transpose of x
diag(A) # Extract or replace the diagonal of a matrix, or construct a diagonal matrix
crossprod(B,C)

## 4.3 List
v = list(a=c(2, 3, 5), b=c("a", "e", "i", "o", "u"))

#### Selection
v$a
v[[1]]
v$a[1]

attach(v)
a
detach(v)

## 4.4 Data Frames
help("mtcars")
str(mtcars)
summary(mtcars)

DF_mtcars <- mtcars

#### Selection
DF_mtcars[["mpg"]]
DF_mtcars[1,]
DF_mtcars[1:6,]
head(DF_mtcars)
DF_mtcars[3,c("hp","cyl")]

#### Add Column
DF_mtcars <- cbind(new = 0, DF_mtcars)
DF_mtcars$new_2 <- "A"

#### Delete Column
DF_mtcars$new <- NULL
DF_mtcars$new_2 <- NULL

#### Subset
DF_mtcars[DF_mtcars$hp < 175 & DF_mtcars$cyl >= 6,]

#### Order
DF_mtcars[order(DF_mtcars$hp),]
head(DF_mtcars[order(DF_mtcars$hp, decreasing = T),], n=10)

#### Compute
DF_mtcars$metric <- round(DF_mtcars$wt / DF_mtcars$hp, digits = 2)
DF_mtcars <- transform(DF_mtcars, metric_2 = round(DF_mtcars$wt / DF_mtcars$hp, digits = 2))
DF_mtcars$metric_3 <- apply(DF_mtcars[,c("gear","carb")], MARGIN = 1, function(x) sum(x) ) # Rows

## 4.5 Data Tables
# install.packages("data.table")
library("data.table")
DT = data.table(ID = c("b","b","b","a","a","c"), a = 1:6, b = 7:12, c = 13:18)
DT_mtcars <- as.data.table(mtcars)
str(DT_mtcars)

#### Subset rows in "i"
DT_mtcars[hp < 175 & cyl >= 6]

#### Order
DT_mtcars[order(hp,-cyl)]
mtcars[order(mtcars$hp, -mtcars$cyl),]

#### Arithmetic operations
DT_mtcars[,sum(wt)]
DT_mtcars[hp < 175 & cyl >= 6,sum(wt)]

#### Set key
setkey(DT_mtcars,cyl)
key(DT_mtcars)

####  Subset with key
DT_mtcars[.(8)]
DT_mtcars[.(6), mult = "first"]
DT_mtcars[.(6), mult = "last"]