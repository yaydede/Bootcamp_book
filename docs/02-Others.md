# Other R Objects

This chapter introduces other types of R objects: matrix, data frame, list, and array.

## Matrices

R stores matrices (and arrays) in a similar way as vectors, but with the attribute called dimension. A matrix is an array that has two dimensions. Data in a matrix are organized into rows and columns. Matrices are commonly used while arrays are rare.  We will not see arrays in this book in detail. Matrices are **homogeneous** data structures, just like atomic vectors, but they can have 2 dimensions, rows and columns, unlike vectors.  

Matrices can be created using the **matrix** function.  In the `matrix()` function, after the data vector, `nrow` and `ncol` specify the desired numbers of rows and columns of the matrix.


```r
#Let's create 5 x 4 numeric matrix containing numbers from 1 to 20
mymatrix <- matrix(1:20, nrow = 5, ncol = 4)  #Here we order the number by columns
mymatrix
```

```
##      [,1] [,2] [,3] [,4]
## [1,]    1    6   11   16
## [2,]    2    7   12   17
## [3,]    3    8   13   18
## [4,]    4    9   14   19
## [5,]    5   10   15   20
```

```r
class(mymatrix)
```

```
## [1] "matrix" "array"
```

```r
dim(mymatrix)
```

```
## [1] 5 4
```

Notice that the matrix is created by filling in the columns. If you want to fill the rows instead of columns, you can add the argument `byrow = TRUE`.


```r
mymatrix <- matrix(1:20, nrow = 5, ncol = 4, byrow = TRUE)
mymatrix
```

```
##      [,1] [,2] [,3] [,4]
## [1,]    1    2    3    4
## [2,]    5    6    7    8
## [3,]    9   10   11   12
## [4,]   13   14   15   16
## [5,]   17   18   19   20
```

We will be using two different variables. Following the usual mathematical convention, lower-case `x` (or any other letter), which stores a vector and capital `X`, which stores a matrix. Don't forget: we can do this because R is case sensitive.  

If the length of the supplied vector is not equal to the number of rows multiplied by the number of columns, R will use the recycling rule on the vector to fill in the matrix, which is usefull:


```r
matrix(6, 3, 3)
```

```
##      [,1] [,2] [,3]
## [1,]    6    6    6
## [2,]    6    6    6
## [3,]    6    6    6
```

After defining a matrix, we can apply various functions on it.


```r
x <- matrix(1:12, nrow = 4)

dim(x)            #the dimension of a matrix         
```

```
## [1] 4 3
```

```r
nrow(x)           #the number of row of a matrix 
```

```
## [1] 4
```

```r
ncol(x)           #the number of column of a matrix 
```

```
## [1] 3
```

### Matrix Operations

Now some key matrix operations:  


```r
X <- matrix(1:9, nrow = 3, ncol = 3)
Y <- matrix(11:19, nrow = 3, ncol = 3)

A <- X + Y
A
```

```
##      [,1] [,2] [,3]
## [1,]   12   18   24
## [2,]   14   20   26
## [3,]   16   22   28
```

```r
B <- X * Y
B
```

```
##      [,1] [,2] [,3]
## [1,]   11   56  119
## [2,]   24   75  144
## [3,]   39   96  171
```

```r
#The symbol %*% is called pipe operator.
#And it carries out a matrix multiplication
#different than a simple multiplication.

C <- X%*%Y  
C
```

```
##      [,1] [,2] [,3]
## [1,]  150  186  222
## [2,]  186  231  276
## [3,]  222  276  330
```

Note that `X * Y` is not a matrix multiplication. It is element by element multiplication. (Same for `X / Y`). Instead, matrix multiplication uses `%*%`. Other matrix functions include `t()` which gives the transpose of a matrix and `solve()` which returns the inverse of a square matrix if it is invertible.  

Here are some operations very useful when using matrices:  


```r
rowMeans(A)
```

```
## [1] 18 20 22
```

```r
colMeans(B)
```

```
## [1]  24.66667  75.66667 144.66667
```

```r
rowSums(B)
```

```
## [1] 186 243 306
```

```r
colSums(A)
```

```
## [1] 42 60 78
```

Last thing: When vectors are coerced to become matrices, they are column vectors. So a vector of length n becomes an $n \times 1$ matrix after coercion.  


```r
x <- 1:5
X <- as.matrix(x)
X
```

```
##      [,1]
## [1,]    1
## [2,]    2
## [3,]    3
## [4,]    4
## [5,]    5
```

### Combine vectors or matrices into a matrix

The `matrix()` function is not the only way to create a matrix. Matrices can also be created by combining vectors as columns, using `cbind()`, or combining vectors as rows, using `rbind()`.  Look at this:  


```r
#Let's create 2 vectors.
x <- rev(c(1:9))  #this can be done by c(9:1). I wanted to show rev()
x
```

```
## [1] 9 8 7 6 5 4 3 2 1
```

```r
y <- rep(2, 9)
y
```

```
## [1] 2 2 2 2 2 2 2 2 2
```

```r
A <- rbind(x, y)
A
```

```
##   [,1] [,2] [,3] [,4] [,5] [,6] [,7] [,8] [,9]
## x    9    8    7    6    5    4    3    2    1
## y    2    2    2    2    2    2    2    2    2
```

```r
B <- cbind(x, y)
B
```

```
##       x y
##  [1,] 9 2
##  [2,] 8 2
##  [3,] 7 2
##  [4,] 6 2
##  [5,] 5 2
##  [6,] 4 2
##  [7,] 3 2
##  [8,] 2 2
##  [9,] 1 2
```

```r
#You can label each column and row
colnames(B) <- c("column1", "column2")
B
```

```
##       column1 column2
##  [1,]       9       2
##  [2,]       8       2
##  [3,]       7       2
##  [4,]       6       2
##  [5,]       5       2
##  [6,]       4       2
##  [7,]       3       2
##  [8,]       2       2
##  [9,]       1       2
```

Also we can append or merge several matrices


```r
m1 <- matrix(1:6, 2, 3)
m1
```

```
##      [,1] [,2] [,3]
## [1,]    1    3    5
## [2,]    2    4    6
```

```r
m2 <- matrix(5:10, 2, 3)
m2
```

```
##      [,1] [,2] [,3]
## [1,]    5    7    9
## [2,]    6    8   10
```

```r
rbind(m1, m2) # Append
```

```
##      [,1] [,2] [,3]
## [1,]    1    3    5
## [2,]    2    4    6
## [3,]    5    7    9
## [4,]    6    8   10
```

```r
cbind(m1, m2) # Merge
```

```
##      [,1] [,2] [,3] [,4] [,5] [,6]
## [1,]    1    3    5    5    7    9
## [2,]    2    4    6    6    8   10
```

### Subsetting Matrix

Like vectors, matrices can be subsetted using square brackets, `[ ]`. However, since matrices are two-dimensional, we need to specify both row and column indices when subsetting.  


```r
Y
```

```
##      [,1] [,2] [,3]
## [1,]   11   14   17
## [2,]   12   15   18
## [3,]   13   16   19
```

```r
Y[1,3]
```

```
## [1] 17
```

```r
Y[,3]
```

```
## [1] 17 18 19
```

```r
Y[2,]
```

```
## [1] 12 15 18
```

```r
Y[2, c(1, 3)] # If we need more than a column (row), we use c()
```

```
## [1] 12 18
```

```r
rownames(Y) <- c("a","b","c")
colnames(Y) <- c("x","y","z")
Yn <- Y[, c(1, 3)]
Yn
```

```
##    x  z
## a 11 17
## b 12 18
## c 13 19
```

If you need to keep the result as a matrix, you can add a third dimension drop = FALSE in the subsetting operation.

Conditional subsetting is the same as before in vectors.  Let's solve this problem:  what's the number in column 1 in `Y` when the number in column 3 is 18?  


```r
Y
```

```
##    x  y  z
## a 11 14 17
## b 12 15 18
## c 13 16 19
```

```r
Y[Y[,3]==18, 1]
```

```
## [1] 12
```

```r
#What are the numbers in a row when the number in column 3 is 18?
Y[Y[,3]==19, ]
```

```
##  x  y  z 
## 13 16 19
```

```r
#Print the rows in Y when the number in column 3 is more than 17?
Y[Y[,3] > 17, ]
```

```
##    x  y  z
## b 12 15 18
## c 13 16 19
```

We will see later how these conditional subsetting can be done much smoother with data frames.  

### `apply()` function  

We will see the `apply` family later in more detail.  The `apply()` function is very handy for matrices if we may want to apply certain function on each row or column. It takes three arguments by default. The first argument is the object, the second argument is the dimension(s) to apply the function on, and the third argument is the function.


```r
apply(Y, 2, mean)
```

```
##  x  y  z 
## 12 15 18
```

```r
apply(Y, 1, mean)
```

```
##  a  b  c 
## 14 15 16
```

```r
apply(Y, 2, sum)
```

```
##  x  y  z 
## 36 45 54
```

```r
apply(Y, 2, sd)
```

```
## x y z 
## 1 1 1
```

```r
apply(Y, 2, function(g) g^2)
```

```
##     x   y   z
## a 121 196 289
## b 144 225 324
## c 169 256 361
```
## Data Frames

We have seen vectors and matrices for storing data. We will now introduce a data frame that is the most common way to store and interact with data.  Data sets for statistical analysis are typically stored in data frames in R. Unlike a matrix, **a data frame can have different data types for each elements (columns)**. A data frame is a list of vectors (columns - you can think of them as "variables"). So, each vector (column) must contain the same data type, but the different vectors (columns) can store different data types.  

**However, unlike a list, the columns (elements) of a data frame must all be vectors and have the same length (number of observations)**  

<img src="png/dataframe.png" width="976" />

Data frames combine the features of matrices and lists.  

Like matrices, data frames are **rectangular**, where the columns are variables and the rows are observations of those variables. like lists, data frames can have elements (column vectors) of **different data types** (some double, some character, etc.) – but they **must be equal length**. Real data sets usually combine variables of different types, so data frames are well suited for storage.   


```r
#One way to do that
mydata <- data.frame(diabetic = c(TRUE, FALSE, TRUE, FALSE), 
                     height = c(65, 69, 71, 73))
mydata
```

```
##   diabetic height
## 1     TRUE     65
## 2    FALSE     69
## 3     TRUE     71
## 4    FALSE     73
```

```r
str(mydata)
```

```
## 'data.frame':	4 obs. of  2 variables:
##  $ diabetic: logi  TRUE FALSE TRUE FALSE
##  $ height  : num  65 69 71 73
```

```r
dim(mydata)
```

```
## [1] 4 2
```

```r
#Or create vectors for each column
diabetic = c(TRUE, FALSE, TRUE, FALSE)
height = c(65, 69, 71, 73)

#And include them in a data frame as follows
mydata <- data.frame(diabetic, height)
mydata
```

```
##   diabetic height
## 1     TRUE     65
## 2    FALSE     69
## 3     TRUE     71
## 4    FALSE     73
```

```r
str(mydata)
```

```
## 'data.frame':	4 obs. of  2 variables:
##  $ diabetic: logi  TRUE FALSE TRUE FALSE
##  $ height  : num  65 69 71 73
```

```r
dim(mydata)
```

```
## [1] 4 2
```

```r
#And more importantly, you can extend it by adding more columns
weight = c(103, 45, 98.4, 70.5)
mydata <- data.frame(mydata, weight)
mydata
```

```
##   diabetic height weight
## 1     TRUE     65  103.0
## 2    FALSE     69   45.0
## 3     TRUE     71   98.4
## 4    FALSE     73   70.5
```

You will have the following mistake a lot.  Let's see it now so you can avoid it later.  


```r
#Try running the code below separately without the comment # and see what happens

#mydata <- data.frame(diabetic = c(TRUE, FALSE, TRUE, FALSE, FALSE), 
                     #height = c(65, 69, 71, 73))
```

The problem in the example above is that there are a different number of rows and columns. Here are some useful tools for diagnosing this problem:  


```r
#Number of columns
ncol(mydata)
```

```
## [1] 3
```

```r
nrow(mydata)
```

```
## [1] 4
```

Often data you’re working with has abstract column names, such as (x1, x2, x3…).The `cars` is data from the 1920s on “Speed and Stopping Distances of Cars”. There is only 2 columns shown below.  


```r
colnames(datasets::cars)
```

```
## [1] "speed" "dist"
```

```r
#Using Base r:
colnames(cars)[1:2] <- c("Speed (mph)", "Stopping Distance (ft)")
colnames(cars)
```

```
## [1] "Speed (mph)"            "Stopping Distance (ft)"
```

```r
#Using GREP:
colnames(cars)[grep("dist", colnames(cars))] <- "Stopping Distance (ft)"
colnames(cars)
```

```
## [1] "Speed (mph)"            "Stopping Distance (ft)"
```

Using `summary()` on a data frame, you get the summary statistics for each variable.


```r
summary(cars)
```

```
##   Speed (mph)   Stopping Distance (ft)
##  Min.   : 4.0   Min.   :  2.00        
##  1st Qu.:12.0   1st Qu.: 26.00        
##  Median :15.0   Median : 36.00        
##  Mean   :15.4   Mean   : 42.98        
##  3rd Qu.:19.0   3rd Qu.: 56.00        
##  Max.   :25.0   Max.   :120.00
```
### Subsetting Data Frames

Subsetting data frames can work much like subsetting matrices using square brackets, `[,]`. Let's use another data given in the `ggplot2` library.    


```r
library(ggplot2)
head(mpg, n = 10)
```

```
## # A tibble: 10 × 11
##    manufacturer model      displ  year   cyl trans drv     cty   hwy fl    class
##    <chr>        <chr>      <dbl> <int> <int> <chr> <chr> <int> <int> <chr> <chr>
##  1 audi         a4           1.8  1999     4 auto… f        18    29 p     comp…
##  2 audi         a4           1.8  1999     4 manu… f        21    29 p     comp…
##  3 audi         a4           2    2008     4 manu… f        20    31 p     comp…
##  4 audi         a4           2    2008     4 auto… f        21    30 p     comp…
##  5 audi         a4           2.8  1999     6 auto… f        16    26 p     comp…
##  6 audi         a4           2.8  1999     6 manu… f        18    26 p     comp…
##  7 audi         a4           3.1  2008     6 auto… f        18    27 p     comp…
##  8 audi         a4 quattro   1.8  1999     4 manu… 4        18    26 p     comp…
##  9 audi         a4 quattro   1.8  1999     4 auto… 4        16    25 p     comp…
## 10 audi         a4 quattro   2    2008     4 manu… 4        20    28 p     comp…
```

And we need to see the cars with highway mpg over 35: 


```r
mpg[mpg$hwy > 35, c("manufacturer", "model", "year")]
```

```
## # A tibble: 6 × 3
##   manufacturer model       year
##   <chr>        <chr>      <int>
## 1 honda        civic       2008
## 2 honda        civic       2008
## 3 toyota       corolla     2008
## 4 volkswagen   jetta       1999
## 5 volkswagen   new beetle  1999
## 6 volkswagen   new beetle  1999
```

An alternative would be to use the `subset()` function, which has a much more readable syntax.  


```r
subset(mpg, subset = hwy > 35, select = c("manufacturer", "model", "year"))
```

```
## # A tibble: 6 × 3
##   manufacturer model       year
##   <chr>        <chr>      <int>
## 1 honda        civic       2008
## 2 honda        civic       2008
## 3 toyota       corolla     2008
## 4 volkswagen   jetta       1999
## 5 volkswagen   new beetle  1999
## 6 volkswagen   new beetle  1999
```

Lastly, we could use the filter and select functions from the `dplyr` package which introduces the `%>%` operator from the `magrittr` package. This is not necessary for this book, however the `dplyr` package is something you should be aware of as it is becoming a popular tool in the R world.  


```r
library(dplyr)
mpg %>% filter(hwy > 35) %>% select(manufacturer, model, year)
```

```
## # A tibble: 6 × 3
##   manufacturer model       year
##   <chr>        <chr>      <int>
## 1 honda        civic       2008
## 2 honda        civic       2008
## 3 toyota       corolla     2008
## 4 volkswagen   jetta       1999
## 5 volkswagen   new beetle  1999
## 6 volkswagen   new beetle  1999
```

We will see `dplyr` later.

### Tibble

Tibbles are data frames, but change some behaviors of data frames to make coding easier. To use the tibble class, you need to install the tibble package, which is part of the `tidyverse` package.


```r
library(tibble)
animal <- rep(c("sheep", "pig"), c(3,3))
year <- rep(2019:2021, 2)
healthy <- c(rep(TRUE, 5), FALSE)
my_tibble <- tibble(animal, year, healthy)
my_tibble
```

```
## # A tibble: 6 × 3
##   animal  year healthy
##   <chr>  <int> <lgl>  
## 1 sheep   2019 TRUE   
## 2 sheep   2020 TRUE   
## 3 sheep   2021 TRUE   
## 4 pig     2019 TRUE   
## 5 pig     2020 TRUE   
## 6 pig     2021 FALSE
```

You can convert a tibble to a data frame or data frame to tibble.


```r
my_data_frame <- data.frame(animal, year,  healthy)
tt <- as_tibble(my_data_frame)
tt
```

```
## # A tibble: 6 × 3
##   animal  year healthy
##   <chr>  <int> <lgl>  
## 1 sheep   2019 TRUE   
## 2 sheep   2020 TRUE   
## 3 sheep   2021 TRUE   
## 4 pig     2019 TRUE   
## 5 pig     2020 TRUE   
## 6 pig     2021 FALSE
```

```r
# Or

bck <- as.data.frame(tt)
bck
```

```
##   animal year healthy
## 1  sheep 2019    TRUE
## 2  sheep 2020    TRUE
## 3  sheep 2021    TRUE
## 4    pig 2019    TRUE
## 5    pig 2020    TRUE
## 6    pig 2021   FALSE
```

In some aspects tibbles are useful, data frames are more common.

### Plotting from data frame

There are many good ways and packages for plotting.  I'll show you one here.  Visualizing the relationship between multiple variables can get messy very quickly. Here is the `ggpairs()` function in the **GGally** package [@Tay_2019].


```r
library(fueleconomy)  #install.packages("fueleconomy")
data(vehicles)
df <- vehicles[1:100, ]
str(df)
```

```
## tibble [100 × 12] (S3: tbl_df/tbl/data.frame)
##  $ id   : num [1:100] 13309 13310 13311 14038 14039 ...
##  $ make : chr [1:100] "Acura" "Acura" "Acura" "Acura" ...
##  $ model: chr [1:100] "2.2CL/3.0CL" "2.2CL/3.0CL" "2.2CL/3.0CL" "2.3CL/3.0CL" ...
##  $ year : num [1:100] 1997 1997 1997 1998 1998 ...
##  $ class: chr [1:100] "Subcompact Cars" "Subcompact Cars" "Subcompact Cars" "Subcompact Cars" ...
##  $ trans: chr [1:100] "Automatic 4-spd" "Manual 5-spd" "Automatic 4-spd" "Automatic 4-spd" ...
##  $ drive: chr [1:100] "Front-Wheel Drive" "Front-Wheel Drive" "Front-Wheel Drive" "Front-Wheel Drive" ...
##  $ cyl  : num [1:100] 4 4 6 4 4 6 4 4 6 5 ...
##  $ displ: num [1:100] 2.2 2.2 3 2.3 2.3 3 2.3 2.3 3 2.5 ...
##  $ fuel : chr [1:100] "Regular" "Regular" "Regular" "Regular" ...
##  $ hwy  : num [1:100] 26 28 26 27 29 26 27 29 26 23 ...
##  $ cty  : num [1:100] 20 22 18 19 21 17 20 21 17 18 ...
```

Let's see how `GGally::ggpairs()` visualizes relationships between quantitative variables:
  

```r
library(GGally) #install.packages("GGally")
new_df <- df[, c("cyl", "hwy", "cty")]
ggpairs(new_df)
```

![](02-Others_files/figure-epub3/unnamed-chunk-27-1.png)<!-- -->

The visualization changes a little when we have a mix of quantitative and categorical variables. Below, fuel is a categorical variable while hwy is a quantitative variable.  


```r
mixed_df <- df[, c("fuel", "hwy")]
ggpairs(mixed_df)
```

![](02-Others_files/figure-epub3/unnamed-chunk-28-1.png)<!-- -->

## Lists
A list is a one-dimensional heterogeneous data structure. So it is indexed like a vector with a single integer value, but each element can contain an element of any type.

<img src="png/List.png" width="1044" />

Lets look at some examples of working with them:


```r
# creation
A <- list(42, "Hello", TRUE)
dim(A)
```

```
## NULL
```

```r
str(A)
```

```
## List of 3
##  $ : num 42
##  $ : chr "Hello"
##  $ : logi TRUE
```

```r
class(A)
```

```
## [1] "list"
```

```r
# Another one
B <- list(
          a = c(1, 2, 3, 4),
          b = TRUE,
          c = "Hello!",
          d = function(arg = 1) {print("Hello World!")},
          X = matrix(0, 4 , 4)
)

B
```

```
## $a
## [1] 1 2 3 4
## 
## $b
## [1] TRUE
## 
## $c
## [1] "Hello!"
## 
## $d
## function(arg = 1) {print("Hello World!")}
## 
## $X
##      [,1] [,2] [,3] [,4]
## [1,]    0    0    0    0
## [2,]    0    0    0    0
## [3,]    0    0    0    0
## [4,]    0    0    0    0
```

```r
dim(B)
```

```
## NULL
```

```r
dim(B$X)
```

```
## [1] 4 4
```

```r
str(B)
```

```
## List of 5
##  $ a: num [1:4] 1 2 3 4
##  $ b: logi TRUE
##  $ c: chr "Hello!"
##  $ d:function (arg = 1)  
##   ..- attr(*, "srcref")= 'srcref' int [1:8] 12 15 12 55 15 55 12 12
##   .. ..- attr(*, "srcfile")=Classes 'srcfilecopy', 'srcfile' <environment: 0x7ff72dc51e28> 
##  $ X: num [1:4, 1:4] 0 0 0 0 0 0 0 0 0 0 ...
```

```r
class(B)
```

```
## [1] "list"
```

Lists can be subset using two types of syntax, the `$` operator, and square brackets `[ ]`. The `$` operator returns a named element of a list. The `[ ]` syntax returns a list, while the `[[ ]]` returns an element of a list.  


```r
#For example to get the matrix in our list
B$X
```

```
##      [,1] [,2] [,3] [,4]
## [1,]    0    0    0    0
## [2,]    0    0    0    0
## [3,]    0    0    0    0
## [4,]    0    0    0    0
```

```r
#or
B[5]
```

```
## $X
##      [,1] [,2] [,3] [,4]
## [1,]    0    0    0    0
## [2,]    0    0    0    0
## [3,]    0    0    0    0
## [4,]    0    0    0    0
```

```r
#or
B[[5]]
```

```
##      [,1] [,2] [,3] [,4]
## [1,]    0    0    0    0
## [2,]    0    0    0    0
## [3,]    0    0    0    0
## [4,]    0    0    0    0
```

```r
#And to get the (1,3) element of matrix X in list B
B[[5]][1,3]
```

```
## [1] 0
```

What's the difference between the results of `B[[5]]` and `B[5]`? The former is the third element of my_list which is a matrix, while the latter is a list containing a single matrix element. Let’s confirm this by looking at their structures.


```r
str(B[[5]])
```

```
##  num [1:4, 1:4] 0 0 0 0 0 0 0 0 0 0 ...
```

```r
str(B[5])
```

```
## List of 1
##  $ X: num [1:4, 1:4] 0 0 0 0 0 0 0 0 0 0 ...
```

## Array

Array can be viewed as an extension of vector and matrix to a higher dimensional space, and still **only contains elements of the same type**.


```r
A <- array(1:24, c(2,3,4))
A
```

```
## , , 1
## 
##      [,1] [,2] [,3]
## [1,]    1    3    5
## [2,]    2    4    6
## 
## , , 2
## 
##      [,1] [,2] [,3]
## [1,]    7    9   11
## [2,]    8   10   12
## 
## , , 3
## 
##      [,1] [,2] [,3]
## [1,]   13   15   17
## [2,]   14   16   18
## 
## , , 4
## 
##      [,1] [,2] [,3]
## [1,]   19   21   23
## [2,]   20   22   24
```

```r
dim(A)
```

```
## [1] 2 3 4
```

The first argument is the data input (`1:241`).  The second argument is the dimension of the array: `2` is the number of rows, `3` is the number of columns, and `4` is how many matrices we will have.  Here is an example with a higher dimension:  


```r
y <- array(0, c(2,3,4,5))
y
```

```
## , , 1, 1
## 
##      [,1] [,2] [,3]
## [1,]    0    0    0
## [2,]    0    0    0
## 
## , , 2, 1
## 
##      [,1] [,2] [,3]
## [1,]    0    0    0
## [2,]    0    0    0
## 
## , , 3, 1
## 
##      [,1] [,2] [,3]
## [1,]    0    0    0
## [2,]    0    0    0
## 
## , , 4, 1
## 
##      [,1] [,2] [,3]
## [1,]    0    0    0
## [2,]    0    0    0
## 
## , , 1, 2
## 
##      [,1] [,2] [,3]
## [1,]    0    0    0
## [2,]    0    0    0
## 
## , , 2, 2
## 
##      [,1] [,2] [,3]
## [1,]    0    0    0
## [2,]    0    0    0
## 
## , , 3, 2
## 
##      [,1] [,2] [,3]
## [1,]    0    0    0
## [2,]    0    0    0
## 
## , , 4, 2
## 
##      [,1] [,2] [,3]
## [1,]    0    0    0
## [2,]    0    0    0
## 
## , , 1, 3
## 
##      [,1] [,2] [,3]
## [1,]    0    0    0
## [2,]    0    0    0
## 
## , , 2, 3
## 
##      [,1] [,2] [,3]
## [1,]    0    0    0
## [2,]    0    0    0
## 
## , , 3, 3
## 
##      [,1] [,2] [,3]
## [1,]    0    0    0
## [2,]    0    0    0
## 
## , , 4, 3
## 
##      [,1] [,2] [,3]
## [1,]    0    0    0
## [2,]    0    0    0
## 
## , , 1, 4
## 
##      [,1] [,2] [,3]
## [1,]    0    0    0
## [2,]    0    0    0
## 
## , , 2, 4
## 
##      [,1] [,2] [,3]
## [1,]    0    0    0
## [2,]    0    0    0
## 
## , , 3, 4
## 
##      [,1] [,2] [,3]
## [1,]    0    0    0
## [2,]    0    0    0
## 
## , , 4, 4
## 
##      [,1] [,2] [,3]
## [1,]    0    0    0
## [2,]    0    0    0
## 
## , , 1, 5
## 
##      [,1] [,2] [,3]
## [1,]    0    0    0
## [2,]    0    0    0
## 
## , , 2, 5
## 
##      [,1] [,2] [,3]
## [1,]    0    0    0
## [2,]    0    0    0
## 
## , , 3, 5
## 
##      [,1] [,2] [,3]
## [1,]    0    0    0
## [2,]    0    0    0
## 
## , , 4, 5
## 
##      [,1] [,2] [,3]
## [1,]    0    0    0
## [2,]    0    0    0
```

```r
dim(y)
```

```
## [1] 2 3 4 5
```


```r
A[1, 2, 3]     #the 3rd matrix with [1,2]
```

```
## [1] 15
```

```r
A[, , 2]       #the 2nd matrix
```

```
##      [,1] [,2] [,3]
## [1,]    7    9   11
## [2,]    8   10   12
```

```r
A[2, , 4]      #the 4th matrix, 2nd row
```

```
## [1] 20 22 24
```

```r
A[-2, 3, -3]   #Expect the 3rd matrix, get the 3rd columns without the 2nd rows
```

```
## [1]  5 11 23
```


```r
apply(A, 1, mean)      #calculate the mean all rows (we have 2 rows)
```

```
## [1] 12 13
```

```r
# Verify them
mean(A[1, , ])         #mean of all 1st rows
```

```
## [1] 12
```

```r
mean(A[2, , ])         #mean of all 2nd rows
```

```
## [1] 13
```

```r
apply(A, 2, sum)       #calculate the sum of all columns
```

```
## [1]  84 100 116
```

```r
apply(A, 3, sd)        #calculate the sd each matrix
```

```
## [1] 1.870829 1.870829 1.870829 1.870829
```

