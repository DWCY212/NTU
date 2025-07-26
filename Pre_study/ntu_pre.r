"
1. Basic Commands

1.1. Variable
    x = 1
    x <- 1
    x
    print(x)

1.2. Vectors
from… to… with increment 1
    1:6
    6:1
seq function to create a sequence
    seq(from = 1, to = 6)
    seq(from = 0, to = 2, by = 0.5)
    seq(from = 3, to = 2, length = 7)
c function to combine numbers and vectors
    x <- c(2, 0, 1, 6)
    y <- c(x, 0, 8, 1, 0)
    z <- c(-x, y); z # equivalent to (z <- c(-x, y))
    length(x)
    x<-0
    for(i in 1:4){x[i]=i^2}

1.3. Matrices
    x <- matrix(data = 1:6)
    y <- matrix(data = 1:6, nrow = 2)
    z <- matrix(data = 1:6, ncol = 3)
    w <- matrix(data = 1:6, nrow = 2, byrow = TRUE)
    t(y) # transpose

1.4. Data frames
#Like matrices, but can have different data types in the columns.
    head(iris)
    dim(iris)
    iris[1:3, ]
    summary(iris)
    str(iris)
    pairs(iris[, -5])
    boxplot(iris[, -5])
    cov(iris[, 1:4])
    cor(iris[, 1:4])
    apply(iris[, 1:4], 2, mean)
    x=scale(iris[, 1:4])
"

"
2. Operations

2.1. Vector operations
    x <- c(2.0, 1.7, 0.1, 2.3)
    y <- c(3.2, 1.0, 7.1, 0.2)
    c(x, y)
    x - y
    x * y # element-wise multiplication
    t(x) %*% y# equivalent to crossprod(x,y); %*% performs matrix multiplication x^T y
    length(x)
    sqrt(y)
    log(x)
    sum(x)
    prod(y)

2.2. Matrix operations
    A <- matrix(1:4, nrow=2)
    A

    B <- matrix(1:4, ncol=2, byrow = TRUE)
    B

    C <- cbind(x, y)
    C

    D <- rbind(x, y)
    D

    det(A)

    solve(A) # 'solve(A)' outputs the inverse of A; 'solve(A,B)' outputs A^{-1}B;

    C %*% D

    diag(x) # compose diagonal matrix with a input-vector

    diag(A) # extract diagonal components from a input-matrix (as a vector)

    eA <- eigen(A)
    eA

    eA$values

    eA$vectors

    D=diag(eA$values)
    P=eA$vectors
    P%*%D%*%solve(P)

# List type
    listex<-list(result1=x,result2=D)

    PP=list(vec=x, mat=A)
    PP

    PP$vec
    PP$mat
    PP[[1]]
    PP[[2]]

2.3 Basic Statistics
    a <- c(1, 7, 0, 8)
    b <- c(1, 9, 4, 5)
    min(a)
    max(a)
    which.min(a) # index of the minimum value
    which.max(a) # index of the maximum value
    median(a)
    mean(a)
    var(a) # variance
    sd(a) # standard deviation
    cov(a, b) # covariance
    cor(a, b) # correlation coefficient

2.4 Indexing data
# matrix function to generate matrix

    x <- matrix(1:20, nrow = 4, byrow = TRUE)
    x

    x[2, 3]
    x[2, ] # second row
    x[, 3] # third column
    x[2:4, c(1, 2, 4)]
    x[-(2:3), -c(1, 2, 4)]
    -(2:3) # negative indexing to exclude rows
    -2:3 # negative indexing to exclude columns

    test<--1
    test

    dim(x)

    x[2, 3] <- x[2, 3] + 2016
    x

    rep(0,6) # repeat 0 six times
    rep(1,6) # repeat 1 six times
    diag(rep(1,6)) # diagonal matrix with 1s on the diagonal

    x[1,]==3
    x[1,]>3
    x[1,]>=3
    x[1,]<3
    x[1,]<=3
    x[1,]!=3
    !(x[1,]==3)
    which(x[1, ] == 3)

    x[1, which(x[1, ] == 3)] <- 0
    x
"

"
3. Probability distributions

3.0 Format: prefix + distribution_name (arguments)

    prefix	---meaning	                ---argument associated with prefix
    d	    ---PDF/PMF	                ---x (any value in the domain of distribution)
    p	    ---CDF	                    ---q (any value in the domain of distribution)
    q	    ---quantile value	        ---p (any desired quantile level)
    r	    ---generate random sample	---n (sample size)

    distribution	---R name	---additional arguments associated with distribution
    uniform	        ---unif	    ---min, max
    binomial	    ---binom	---size, prob
    exponential	    ---exp	    ---rate (expectation of exp(rate) = 1/rate)
    normal	        ---norm	    ---mean, sd

    dexp(x = 1, rate = 1)
    pbinom(q = 1, size = 3, prob = 0.5)
    qunif(p = 0.5, min = 0, max = 6)
    rnorm(3, mean = 0, sd = 1)

# Reproduce the same random sample
    rnorm(3, mean = 0, sd = 1)
    rnorm(3, mean = 0, sd = 1)

    set.seed(1) # for reproducibility
    rnorm(3, mean = 0, sd = 1)
    set.seed(1)
    rnorm(3, mean = 0, sd = 1)
    set.seed(2018)
    rnorm(3, mean = 0, sd = 1)

    sample(1:10,3) # sampling without replacement
    sample(1:10,3,replace=TRUE) # sampling with replacement (bootstrap)
    sample(1:10)
    sample(1:10,replace=TRUE)

3.1 Multivariate normal distribution
# Generate a random sample with size n from the multivariate normal distribution
# \ (N_3(\ mu,\ Sigma)\ ),
# where \ [ \ mu=\ left( \ begin{array}{c} 3 \\ 1 \\ 4 \ end{array} \ right),
# \ Sigma=\ left( \ begin{array}{ccc} 3 & 0 & 2 \\ 0 & 1 & 1 \\ 2 & 1 & 9 \\ \ end{array} \ right) \ ]

3.1.1. Using mvrnorm()
    # install.packages('mvnfast')
    library('mvnfast')

    # ?rmvt

    # install.packages('MASS')
    library(MASS)
    set.seed(1)
    mu <- c(3, 1, 4)
    Sigma <- matrix(c(3, 0, 2, 0, 1, 1, 2, 1, 9), ncol = 3)
    Data5 <- mvrnorm(n = 5, mu = mu, Sigma = Sigma)
    Data5

    apply(Data5, 2, mean)

    cov(Data5)

# Repeat with 500 samples, now the sample means and covariance matrix are closer to \ (\ mu\ ) and \ (\ Sigma\ )
    Data500 <- mvrnorm(n = 500, mu = mu, Sigma = Sigma)
    apply(Data500, 2, mean)

    cov(Data500)

3.1.2. Not using mvrnorm()
# Generate random numbers from \ (N_p(\ mu,\ Sigma)\ ) using number
    mvn <- function(n, mu, Sigma) {
        p <- length(mu)
        eS <- eigen(Sigma)
        U <- eS$vectors
        Lambda <- diag(eS$values)
        A <- U %*% sqrt(Lambda)
        Data <- A %*% matrix(rnorm(p * n), ncol = n) +
                matrix(rep(mu, n), ncol = n)
        return(t(Data))
    }
"

"
4. Graphic
# plot function to plot R objects.
    x <- rnorm(100)
    y <- rnorm(100)
    plot(x, y, main='X-Y Plot', xlab='x-axis')
    abline(0,1) # add a y=x line
"

"
5. Control sequences
# if (else if) else
    a <- 1
    b <- 2
    if (a < b) {
    3
    } else if (a==b) {
    4
    } else {
    5
    }

    ifelse(a < b, 3, 4)

# for
    for (i in 4:1) {
        for (j in seq(1,7,by=2)){
            print(i+j) # Check: 5, 7, 9, 11, 4, 6, 8, 10, ...
        }
    }
"

"
6. Writing user-defined functions
    dif <- function(a=1, b=0) {
    # return(a - b)
        temp=a-b
        temp
    }
    pun_dif <- function(a, b) {
    t=a-b
    return(t)
    }
    dif

    dif(2, 1)
    dif(1, 2)
    dif(a = 2, b = 1)
    dif(b = 1, a = 2) # named arguments can be in any order
    dif(2) # b defaults to 0
"

"
7. More functions
# List down all existing objects
    ls() # list objects in the current environment
    ls.str() # list objects with their structure

# Remove objects
    rm(a, b)

# Remove all objects
    rm(list = ls())
"

"
8. Replication of the previous examples

# Day 1, page 29, univariate function example
    f<-function(x){exp(x)/(exp(x) + 1)}
    curve(f,-10,10)

# Day 1, pages 31-34, multivariate function example: Gumbel Copula
    CG<-function(u,v,delta=2){
    exp(-((-log(u))^delta+(-log(v))^delta)^(1/delta))
    }
    useq=seq(0,5,length=100);vseq=seq(0,5,length=100);CGseq=outer(useq,vseq,CG)

    # install.packages('plot3D')
    library(plot3D)

    # Perspective Plot
    par(mfrow = c(1,1), mar = c(1,5,1,5))
    persp3D(useq,vseq,CGseq,theta=45,phi=45,main='Perspective Plot',xlab='u',ylab='v',zlab='C_G')

    # Contour Plot
    par(mfrow = c(1,1), mar = c(3,5,2,5))
    contour2D(CGseq,main='Contour Plot',xlab='u',ylab='v', lwd = 2)

    # Correct the axes' values in the contour plot:
    xcuts <- seq(min(useq),max(useq),length.out = 6)
    ycuts <- seq(min(vseq),max(vseq),length.out = 6)
    xvals <- cut(useq, xcuts)
    yvals <- cut(vseq, ycuts)
    factsx <- levels(xvals) # factsx <- levels_pc2_cut # or something like that
    xlabsFacts <- rep(NA,length(factsx))
    for(i in 1:(length(factsx))){
    comma_sep <- unlist(gregexpr(pattern =',',factsx[i])) # location of the comma in the factor
    #taking section of text and converting to numbers
    xlabsFacts[i] <- as.numeric(substr(factsx[i],2,comma_sep-1))
    xlabsFacts[i+1] <- as.numeric(substr(factsx[i],comma_sep+1,nchar(factsx[i])-1))
    }
    factsy <- levels(yvals) # factsy <- levels_pc1_cut # or something like that
    ylabsFacts <- rep(NA,length(factsy))
    for(i in 1:(length(factsy))){
    comma_sep <- unlist(gregexpr(pattern =',',factsy[i])) # location of the comma in the factor
    #taking section of text and converting to numbers
    ylabsFacts[i] <- as.numeric(substr(factsy[i],2,comma_sep-1))
    ylabsFacts[i+1] <- as.numeric(substr(factsy[i],comma_sep+1,nchar(factsy[i])-1))
    }
    # Contour Plot with Correct Axes' values
    contour2D(CGseq,main='Contour Plot',xaxt='n', yaxt='n', xlab='u',ylab='y', lwd = 2)
    axis(side=1,at=seq(0,1,length.out = length(xlabsFacts)),labels=round(xlabsFacts,2))
    axis(side=2,at=seq(0,1,length.out = length(ylabsFacts)),labels=round(ylabsFacts,2))

    # Heat Map
    par(mfrow = c(1,1), mar = c(3,5,2,5))
    image2D(CGseq,main='Heat Map',xlab='u',ylab='v', lwd = 2)

    # Heat Map with Correct Axes' values
    image2D(CGseq,main='Heat Map',xaxt='n', yaxt='n', xlab='u',ylab='v', lwd = 2)
    axis(side=1,at=seq(0,1,length.out = length(xlabsFacts)),labels=round(xlabsFacts,2))
    axis(side=2,at=seq(0,1,length.out = length(ylabsFacts)),labels=round(ylabsFacts,2))

    # Surface+Contour Plots
    par(mfrow = c(1,2), mar = c(3,5,2,5))
    persp3D(useq,vseq,CGseq,contour=TRUE,theta=45,phi=45, zlim= c(-max(CGseq), max(CGseq)),main='Surface+Contour Plots',xlab='u',ylab='v',zlab='C_G')
    persp3D(z = CGseq, contour=list(side=c('zmax', 'z')), zlim= c(min(CGseq),
    1.5*max(CGseq)-min(CGseq)/2), phi=45, theta=45, d=10 ,
    main='Surface+Contour Plots',xlab='u',ylab='v',zlab='C_G')

# Day 1, page 35, vector function example
    xseq=seq(-4, 4, 0.5)
    yseq=seq(-4, 4, 0.5)
    F1<-function(x,y){x^3*y+3*x*y^3}
    F2<-function(x,y){x^4+2*x^2*y^2+y^4}
    xvals=matrix(0,nrow=length(xseq),ncol=length(yseq))
    yvals=matrix(0,nrow=length(xseq),ncol=length(yseq))
    F1vals=matrix(0,nrow=length(xseq),ncol=length(yseq))
    F2vals=matrix(0,nrow=length(xseq),ncol=length(yseq))
    for(i in 1:length(xseq)){
    for(j in 1:length(yseq)){
        xvals[i,j]=xseq[i]
        yvals[i,j]=yseq[j]
        F1vals[i,j]=F1(xseq[i],yseq[j])
        F2vals[i,j]=F2(xseq[i],yseq[j])
    }
    }
    xvals=as.vector(xvals)
    yvals=as.vector(yvals)
    F1vals=as.vector(F1vals)
    F2vals=as.vector(F2vals)
    F1vals2=F1vals/(max(F1vals)-min(F1vals))/2 #Scaled down
    F2vals2=F2vals/(max(F2vals)-min(F2vals))/2 #Scaled down
    # install.packages('grid')
    # install.packages('ggplot2')
    library(grid)
    library(ggplot2)

    df <- data.frame(x=xvals,y=yvals,dx=F1vals2,dy=F2vals2)
    ggplot(data=df, aes(x=x, y=y)) + geom_segment(aes(x=x, y=y,xend=x+dx, yend=y+dy),
        arrow = arrow(length = unit(0.15,'cm')))

# Day 2, page 16, Gauss-Jordan elimination example
    A=matrix(c(1,1,2,-5,2,5,-1,-9,2,1,-1,3,1,-3,2,7),nrow=4,byrow=TRUE)
    b=c(3,-3,-11,-5)

    # Reduced row echelon form
    # install.packages('pracma')
    library(pracma)
    rref(cbind(A,b))

# Day 2, page 28, eigenvalues and eigenvectors example
    A=matrix(c(1,-1,2,4),2,2)
    eigen(A)

# Day 2, page 32, diagonalization example
    A11=matrix(c(1,2,2,1),2,2)
    A12=matrix(0,2,2)
    A1=cbind(A11,A12)
    A2=cbind(A12,A11)
    A=rbind(A1,A2)
    eigen(A)

    P=eigen(A)$vectors
    D=diag(eigen(A)$values)
    solve(P,A)%*%P

# Day 4, page 5, integral example
    f<-function(x){x*exp(2*x^2)}
    integrate(f,0,1)
"
