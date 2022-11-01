# Programing basics

In this section we see three main applications: conditional flows, loops, and functions, that are main pillars of any type of programming.  

## Conditional flows

### if/else

The main syntax is as follows  

`if (condition) {`  
      **some R code**  
 `} else {`  
      **more R code**  
`}` 

Here is a simple example:  


```r
x <- c("what","is","truth")

if("Truth" %in% x) {
   print("Truth is found")
} else {
   print("Truth is not found")
}
```

```
## [1] "Truth is not found"
```

How about this:  


```r
x <- c(1, 4, 4)
a <- 3

#Here is a nice if/Else
if(length(x[x == a]) > 0) {
  print(paste("x has", length(x[x==a]), a))
} else {
  print(paste("x doesn't have any", a))
}
```

```
## [1] "x doesn't have any 3"
```

```r
#Another one with pipping
a <- 4
if(a %in% x) {
  print(paste("x has", length(x[x==a]), a))
} else {
  print(paste("x doesn't have any", a))
}
```

```
## [1] "x has 2 4"
```

### Nested conditions  


```r
#Change the numbers to see all conditions
x <- 0
y <- 4
if (x == 0 & y!= 0) {
  print("a number cannot be divided by zero")
} else if (x == 0 & y == 0) {
  print("a zero cannot be divided by zero")
} else {
  a <- y/x 
  print(paste("y/x = ", a))
}
```

```
## [1] "a number cannot be divided by zero"
```

Building multiple conditions without else (it's a silly example!):  


```r
z <- 0
w <- 4
x <- 5
y <- 3
if(z > w) print("z is bigger than w")
if(w > z) print("w is bigger than z")
```

```
## [1] "w is bigger than z"
```

```r
if(x > y) print("x is bigger than y")
```

```
## [1] "x is bigger than y"
```

```r
if(y > x) print("y is bigger than x")
if(z > x) print("z is bigger than x")
if(x > z) print("x is bigger than z")
```

```
## [1] "x is bigger than z"
```

```r
if(w > y) print("w is bigger than y")
```

```
## [1] "w is bigger than y"
```

```r
if(y > w) print("y is bigger than w")
```

### Simpler `ifelse`
A simpler, one-line `ifelse`: 


```r
#Change the numbers
x <- 0
y <- 4
ifelse (x > y, "x is bigger than y", "y is bigger than x")
```

```
## [1] "y is bigger than x"
```

```r
#Better (ifelse will fail if x = y.  Try it!)
ifelse (x == y, "x is the same as y",
        ifelse(x > y, "x is bigger than y", "y is bigger than x"))
```

```
## [1] "y is bigger than x"
```

A simpler, without else!  


```r
z <- 0
w <- 4
if(z > w) print("w is bigger than z")

#Change the numbers
x <- 5
y <- 3
if(x > y) print("x is bigger than y")
```

```
## [1] "x is bigger than y"
```

```r
#See that both of them moves to the next line.
```


The `ifelse()` function only allows for one “if” statement, two cases. You could add nested “if” statements, but that’s just a pain, especially if the 3+ conditions you want to use are all on the same level, conceptually. Is there a way to specify multiple conditions at the same time?  


```r
#Let's create a data frame:
df <- data.frame("name"=c("Kaija", "Ella", "Andis"), "test1" = c(FALSE, TRUE, TRUE),
                 "test2" = c(FALSE, FALSE, TRUE))
df
```

```
##    name test1 test2
## 1 Kaija FALSE FALSE
## 2  Ella  TRUE FALSE
## 3 Andis  TRUE  TRUE
```

Suppose we want  separate the people into three groups:
  
- People who passed both tests: Group A  
- People who passed one test: Group B 
- People who passed neither test: Group C 

`dplyr` has a function for exactly this purpose: `case_when()`.


```r
library(dplyr)
df <- df %>% 
mutate(group = case_when(test1 & test2 ~ "A", # both tests: group A
                         xor(test1, test2) ~ "B", # one test: group B
                         !test1 & !test2 ~ "C" # neither test: group C
))
df
```

```
##    name test1 test2 group
## 1 Kaija FALSE FALSE     C
## 2  Ella  TRUE FALSE     B
## 3 Andis  TRUE  TRUE     A
```


## Loops

What would you do if you needed to execute a block of code multiple times? In general, statements are executed sequentially. A loop statement allows us to execute a statement or group of statements multiple times and the following is the general form of a loop statement in most programming languages.  There are 3 main loop types: `while()`, `for()`, `repeat()`.  

Here are some examples for `for()` loop:  


```r
x <- c(3, -1, 4, 2, 10, 5)

for (i in 1:length(x)) {
  x[i] <- x[i] * 2
}

x
```

```
## [1]  6 -2  8  4 20 10
```

Note that this just for an example.  If we want to multiply each element of a vector by 2, a loop isn't the best way.  Although it is very normal in many programming languages, we would simply use a vectorized operation in R.  


```r
x <- c(3, -1, 4, 2, 10, 5)
x <- x * 2
x
```

```
## [1]  6 -2  8  4 20 10
```

### Conditional loops

But some times it would be very handy. If the element in $x > 3$, multiply it with the subsequent element:


```r
x <- c(3, -1, 0, 2, 10, 5)

x_new <- c() #empty container
for (i in 1:(length(x)-1)) {
  ifelse(x[i] > 3,  x_new[i] <- x[i] * x[i + 1], x_new[i] <- 0)  
}

x
```

```
## [1]  3 -1  0  2 10  5
```

```r
x_new
```

```
## [1]  0  0  0  0 50
```

Inside the `if` and `else` clause, you can use `next` and `break` to further control the flow.  The `next` function goes directly to the next loop cycle, while `break` jumped out of the current loop.


```r
x <- c(9, -1, 0, 5, -7, 16, 22)
zn <- c()

for(i in 1:length(x)){ 
  if(x[i] < 0){ 
    next
  } 
  zn <- c(zn,  sqrt(x[i]))
}

zn
```

```
## [1] 3.000000 0.000000 2.236068 4.000000 4.690416
```

Inside the `if` and `else` clause, you can use `next` and `break` to further control the flow.  The `next` function goes directly to the next loop cycle, while `break` jumped out of the current loop.


```r
x <- c(9, 1, 0, 5, 7, 16, 22)
bn <- c()

for(i in 1:length(x)){ 
  if(x[i] > 10){ 
    break
  } 
  bn <- c(bn,  sqrt(x[i]))
}

bn
```

```
## [1] 3.000000 1.000000 0.000000 2.236068 2.645751
```

### `while()` and `repeat()`

Here are some examples for `while()` loop:  


```r
# Let's use our first example

x <- 3
cnt <- 1

while (cnt < 11) {
   x = x * 2
   cnt = cnt + 1
}
x
```

```
## [1] 3072
```

Here are some examples for `repeat()` loop:  


```r
# Let's use our first example

x <- 3
cnt <- 1

repeat {
   x = x * 2
   cnt = cnt + 1
  
   if(cnt > 10) break
}
x
```

```
## [1] 3072
```

### Nested loops

It is also common to put one loop inside another one.  Let’s say we want to create a 5x5 matrix where each element  $A_{i j}=i+j$


```r
A <- matrix(0, 5, 5) #initialize the matrix A

for (i in 1:5)       #loop over index i
  for (j in 1:5){    #loop over index j
    A[i, j] <- i + j #set the (i, j)-th element of A
  }
A
```

```
##      [,1] [,2] [,3] [,4] [,5]
## [1,]    2    3    4    5    6
## [2,]    3    4    5    6    7
## [3,]    4    5    6    7    8
## [4,]    5    6    7    8    9
## [5,]    6    7    8    9   10
```

### `outer()`
`outer()` takes two vectors and a function (that itself takes two arguments) and builds a **matrix** by calling the given function for each combination of the elements in the two vectors.  


```r
x <- c(0, 1, 2)
y <- c(0, 1, 2, 3, 4)

m <- outer (
   y,     # First dimension:  the columns (y)
   x,     # Second dimension: the rows    (x)
   function (x, y)   x+2*y
)

m
```

```
##      [,1] [,2] [,3]
## [1,]    0    2    4
## [2,]    1    3    5
## [3,]    2    4    6
## [4,]    3    5    7
## [5,]    4    6    8
```
  
In place of the function, an operator can be given, which makes it easy to create a matrix with simple calculations (such as multiplying):  


```r
m <- outer(c(10, 20, 30, 40), c(2, 4, 6), "*")
m
```

```
##      [,1] [,2] [,3]
## [1,]   20   40   60
## [2,]   40   80  120
## [3,]   60  120  180
## [4,]   80  160  240
```

It becomes very handy when we build a polynomial model:  


```r
x <- sample(0:20, 10, replace = TRUE)
x
```

```
##  [1] 18  5 16  9  8 12 13 12  4 17
```

```r
m <- outer(x, 1:4, "^")
m
```

```
##       [,1] [,2] [,3]   [,4]
##  [1,]   18  324 5832 104976
##  [2,]    5   25  125    625
##  [3,]   16  256 4096  65536
##  [4,]    9   81  729   6561
##  [5,]    8   64  512   4096
##  [6,]   12  144 1728  20736
##  [7,]   13  169 2197  28561
##  [8,]   12  144 1728  20736
##  [9,]    4   16   64    256
## [10,]   17  289 4913  83521
```

We can also use `outer()` for this example


```r
outer(1:5, 1:5, "+")
```

```
##      [,1] [,2] [,3] [,4] [,5]
## [1,]    2    3    4    5    6
## [2,]    3    4    5    6    7
## [3,]    4    5    6    7    8
## [4,]    5    6    7    8    9
## [5,]    6    7    8    9   10
```

```r
# Or

outer(1:4, 1:4, function(i, j){0.5^{abs(i-j)}})
```

```
##       [,1] [,2] [,3]  [,4]
## [1,] 1.000 0.50 0.25 0.125
## [2,] 0.500 1.00 0.50 0.250
## [3,] 0.250 0.50 1.00 0.500
## [4,] 0.125 0.25 0.50 1.000
```

## The `apply()` family
The `apply()` family is one of the R base packages and is populated with functions to manipulate slices of data from matrices, arrays, lists and data frames in a repetitive way. These functions allow crossing the data in a number of ways and avoid explicit use of loop constructs. They act on an input list, matrix or array and apply a named function with one or several optional arguments. The family is made up of the `apply()`, `lapply()` , `sapply()`, `vapply()`, `mapply()`, `rapply()`, and `tapply()` functions.    

### `apply()`
  
The R base manual tells you that it’s called as follows: `apply(X, MARGIN, FUN, ...)`, where, X is an array or a matrix if the dimension of the array is 2; MARGIN is a variable defining how the function is applied: when `MARGIN=1`, it applies over rows, whereas with `MARGIN=2`, it works over columns. Note that when you use the construct `MARGIN=c(1,2)`, it applies to both rows and columns; and FUN, which is the function that you want to apply to the data. It can be any R function, including a User Defined Function (UDF).  


```r
# Construct a 5x6 matrix
X <- matrix(rnorm(30), nrow=5, ncol=6)

# Sum the values of each column with `apply()`
apply(X, 2, sum)
```

```
## [1] -0.5269156  3.2202032 -0.8057803  2.2538354  1.8624807  2.6518255
```

```r
apply(X, 2, length)
```

```
## [1] 5 5 5 5 5 5
```

```r
apply(X, 1, length)
```

```
## [1] 6 6 6 6 6
```

```r
apply(X, 2, function (x) length(x)-1)
```

```
## [1] 4 4 4 4 4 4
```

```r
#If you don’t want to write a function inside of the arguments
len <- function(x){
  length(x)-1
}
apply(X,2, len)
```

```
## [1] 4 4 4 4 4 4
```

```r
#It can also be used to repeat a function on cells within a matrix
X_new <- apply(X[1:2,], 1, function(x) x+1)
X_new
```

```
##            [,1]       [,2]
## [1,] 0.49333557  0.5222127
## [2,] 0.27520664  3.7329509
## [3,] 1.35178715  1.1350886
## [4,] 0.88959105  1.0616108
## [5,] 0.04956577  0.9137828
## [6,] 2.77633119 -0.4805825
```

Since `apply()` is used only for matrices, if you apply `apply()` to a data frame, it first coerces your data.frame to an array which means all the columns must have the same type. Depending on your context, this could have unintended consequences.  For a safer practice in data frames, we can use `lappy()` and `sapply()`:  

### `lapply()`
  
You want to apply a given function to every element of a list and obtain a list as a result. When you execute `?lapply`, you see that the syntax looks like the `apply()` function.  The difference is that it can be used for other objects like data frames, lists or vectors. And the output returned is a list (which explains the “l” in the function name), which has the same number of elements as the object passed to it.  `lapply()` function does not need MARGIN.   


```r
A<-c(1:9)
B<-c(1:12)
C<-c(1:15)
my.lst<-list(A,B,C)
lapply(my.lst, sum)
```

```
## [[1]]
## [1] 45
## 
## [[2]]
## [1] 78
## 
## [[3]]
## [1] 120
```
  
### `sapply()`
  
`sapply` works just like `lapply`, but will simplify the output if possible. This means that instead of returning a list like `lapply`, it will return a vector instead if the data is simplifiable.   


```r
A<-c(1:9)
B<-c(1:12)
C<-c(1:15)
my.lst<-list(A,B,C)
sapply(my.lst, sum)
```

```
## [1]  45  78 120
```

### `tapply()`
  
Sometimes you may want to perform the apply function on some data, but have it separated by factor. In that case, you should use `tapply`. Let’s take a look at the information for `tapply`.  


```r
X <- matrix(c(1:10, 11:20, 21:30), nrow = 10, ncol = 3)
tdata <- as.data.frame(cbind(c(1,1,1,1,1,2,2,2,2,2), X))
tdata
```

```
##    V1 V2 V3 V4
## 1   1  1 11 21
## 2   1  2 12 22
## 3   1  3 13 23
## 4   1  4 14 24
## 5   1  5 15 25
## 6   2  6 16 26
## 7   2  7 17 27
## 8   2  8 18 28
## 9   2  9 19 29
## 10  2 10 20 30
```

```r
tapply(tdata$V2, tdata$V1, mean)
```

```
## 1 2 
## 3 8
```

What we have here is an important tool:  We have a conditional mean of column 2 (V2) with respect to column 1 (V1). You can use `tapply` to do some quick summary statistics on a variable split by condition.  


```r
summary <- tapply(tdata$V2, tdata$V1, function(x) c(mean(x), sd(x)))
summary
```

```
## $`1`
## [1] 3.000000 1.581139
## 
## $`2`
## [1] 8.000000 1.581139
```

### `mapply()`
  
`mapply()` would be used to create a new variable. For example, using dataset `tdata`, we could divide one column by another column to create a new value. This would be useful for creating a ratio of two variables as shown in the example below.   


```r
tdata$V5 <- mapply(function(x, y) x/y, tdata$V2, tdata$V4)
tdata$V5
```

```
##  [1] 0.04761905 0.09090909 0.13043478 0.16666667 0.20000000 0.23076923
##  [7] 0.25925926 0.28571429 0.31034483 0.33333333
```

## Functions

An R function is created by using the keyword function. Let's write our first function:  


```r
first <- function(a){
  b <- a ^ 2
  return(b)
}

first(1675)
```

```
## [1] 2805625
```

Let's have a function that find the z-score (standardization).  That's subtracting the sample mean, and dividing by the sample standard deviation.  

$$
\frac{x-\overline{x}}{s}
$$
  


```r
z_score <- function(x){
  return((x - mean(x))/sd(x))
}

set.seed(1)
x <- rnorm(10, 3, 30)
z <- z_score(x)
z
```

```
##  [1] -0.97190653  0.06589991 -1.23987805  1.87433300  0.25276523 -1.22045645
##  [7]  0.45507643  0.77649606  0.56826358 -0.56059319
```

Lets create a function that prints the factorials:


```r
fact <- function(a){
  b <- 1
  for (i in 1:(a-1)) {
    b <- b*(i+1) 
  }
  b
}

fact(5)
```

```
## [1] 120
```

Creating loops is an act of art and requires very careful thinking.  The same loop can be done by many different structures.  And it always takes more time to understand somebody else's loop than your own!   

## `source()`

You can use the `source()` function in R to reuse functions that you create in another R script.  The function uses the following basic syntax: `source("path/to/some/file.R")`

Suppose we have the following R script called `some_functions.R` that contains two simple user-defined functions:

`divide_by_two <- function(x) {`
  `return(x/2)`
`}`

`multiply_by_three <- function(x) {`
  `return(x*3)`
`}`

Now suppose we’re currently working with some R script called `main_script.R`.  Assuming `some_functions.R` and main_script.R are located within the same folder, we can use source at the top of our `main_script.R` to allow us to use the functions we defined in the `some_functions.R` script:


```r
source("some_functions.R")

df <- data.frame(team=c('A', 'B', 'C', 'D', 'E', 'F'),
                 points=c(14, 19, 22, 15, 30, 40))

df$half_points <- divide_by_two(df$points)

df$triple_points <- multiply_by_three(df$points)
df
```

```
##   team points half_points triple_points
## 1    A     14         7.0            42
## 2    B     19         9.5            57
## 3    C     22        11.0            66
## 4    D     15         7.5            45
## 5    E     30        15.0            90
## 6    F     40        20.0           120
```
  
We can use as many source functions as we’d like if we want to reuse functions defined in several different scripts.
