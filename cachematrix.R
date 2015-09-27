## This is a function packeage to improve performance when repetative use of 
## matrix inverse is needed using a chaching approach.  
## Usage: first create a cahceMatrix then call cacheSolve
## Example:
## y<-makeCacheMatrix(matrix( runif(25), 5, 5))
## cacheSolve(y)
## cacheSolve(y)
## cacheSolve(y)
## Verification: following should result in Identity matrix (or very close
##               due to round off errors)
## y$getnvrs() %*% y$get()

## makeChaceMatrix  takes a square matrix and constructs a cache list composed  
##                  of the input matrix, a placeholder for its inverse 

makeCacheMatrix <- function(x = matrix()) {

    ### initialize nvrs (matrix inverse) to NULL
    nvrs <- NULL
    ### function object to assign input matrix as list member
    set <- function(y) {
        ### from help: using "<<-" operator:
        ### "cause a search made through parent environments for an existing 
        ### definition of the variable being assigned. If such a variable is 
        ### found (and its binding is not locked) then its value is redefined, 
        ### otherwise assignment takes place in the global environment." 
        x <<- y
        nvrs <<- NULL
    }
    ### function object to retrive underlying matrix
    get <- function() x
    ### function object to calculate inverse and assign it to list member nvrs
    setnvrs <- function(solve) nvrs <<- solve
    ### function object to get nvrs
    getnvrs <- function() nvrs
    ### instantiating the cache list
    list(set = set, get = get,
         setnvrs = setnvrs,
         getnvrs = getnvrs)
    
}


## cacheSolve  takes a cache list object corresponding to a square matrix 
##             and returns inverse of the square matrix
cacheSolve <- function(x, ...) {
        
    ### Retrive the nvrs member of the cache list
    nvrs <- x$getnvrs()
    ### A none-NULL value for nvrs means we calculated inverse earlier and 
    ### cached it, hence use the cache value to help performance.
    if(!is.null(nvrs)) {
        message("getting cached data")
        ### cacheSolve execution flow will terminate after calling return
        return(nvrs)
    }
    ### The remaider of the function body is reacheable only if nvrs is NULL
    ### i.e. was not calculated/cached earlier.
    ### Get the underlying matrix from the list
    data <- x$get()
    ### calculate the inverse
    nvrs <- solve(data, ...)
    ### cache the inverse
    x$setnvrs(nvrs)
    ### display the calculated inverse
    nvrs
}
