This is my title
========================================================

This is a subtitle
--------------------

Here is some random data


```r
x = rnorm(10)
x
```

```
##  [1]  0.7818  0.4397  1.4950  0.5732 -0.7955 -0.7513  0.4210  0.2349
##  [9]  0.0949 -2.2293
```

```r
y = rnorm(10)
y
```

```
##  [1] -0.3095  1.4714  0.4685 -1.3121  0.8035 -0.6431 -0.7729 -0.2797
##  [9]  0.2615  0.3928
```

```r
plot(x, y)
lines(lowess(x, y))
```

![plot of chunk unnamed-chunk-1](figure/unnamed-chunk-1.png) 



This is an R Markdown document. Markdown is a simple formatting syntax for authoring web pages (click the **MD** toolbar button for help on Markdown).

When you click the **Knit HTML** button a web page will be generated that includes both content as well as the output of any embedded R code chunks within the document. You can embed an R code chunk like this:


```r
summary(cars)
```

```
##      speed           dist    
##  Min.   : 4.0   Min.   :  2  
##  1st Qu.:12.0   1st Qu.: 26  
##  Median :15.0   Median : 36  
##  Mean   :15.4   Mean   : 43  
##  3rd Qu.:19.0   3rd Qu.: 56  
##  Max.   :25.0   Max.   :120
```


You can also embed plots, for example:


```r
plot(cars)
```

![plot of chunk unnamed-chunk-3](figure/unnamed-chunk-3.png) 


