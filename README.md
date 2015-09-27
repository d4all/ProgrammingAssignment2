### Introduction

This solution to the second programming assignment provides an R
function that is able to cache potentially time-consuming computations.

The function packeage to improve performance when repetative use of 
matrix inverse is needed using a chaching approach.  

### Usage

first create a cahceMatrix then call cacheSolve

### Example

m<-matrix( runif(25), 5, 5)
y<-makeCacheMatrix(m)
cacheSolve(y)
cacheSolve(y)
cacheSolve(y)

### Notice
The inverse is calculated first time the cacheSolve() is invoked. Subsequent 
cacheSolve calls (when the underlying matrix has not been changed) results in
return of the cached inverse.

### Verification
Following should result in Identity matrix (or very close due to round off errors)

y\$getnvrs() \%\*\% y\$get()

### Functions

makeChaceMatrix  takes a square matrix and constructs a cache list composed  
                 of the input matrix, a placeholder for its inverse 

cacheSolve  takes a cache list object corresponding to a square matrix 
            and returns inverse of the square matrix