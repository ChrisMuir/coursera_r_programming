## The functions below allow the user to store the output of a matrix inversion computation
## in a cache outside of the current R environment.  This gives the user the ability to
## call upon the matrix inversion output at will without having to recompute multiple times.
## This is especially useful for use in loops in R.

## makeCacheMatrix creates the cache matrix object, and sets up a list of user commands.
## Once the function is run in R, here is an example of the commands to seed the cache:
## a <- makeCacheMatrix()
## x <- matrix(1:4, 2, 2)
## a$set(x)

makeCacheMatrix <- function(x = matrix()) {
        inv <- NULL
        set <- function(y) {
                x <<- y
                inv <<- NULL
        }
        get <- function() x
        setinverse <- function(solve) inv <<- solve
        getinverse <- function() inv
        list(set = set, get = get, setinverse = setinverse, getinverse = getinverse)
}


## cacheSolve calculates the inverse of the matrix created by function makecacheMatrix. 
## Although, prior to this calculation, it looks to see if the matrix inversion has
## previously been calculated.  If so, it returns the output saved in the cache and does
## NOT perform the inversion computation.  If the requested inversion has NOT been stored in 
## the cache, the function will calculate the matrix inversion and record the value of the
## inversion calculation in the cache by way of the setinverse function.

cacheSolve <- function(x, ...) {
        inv <- x$getinverse()
        if(!is.null(inv)) {
                message("getting cached data")
                return(inv)
        }
        data <- x$get()
        inv <- solve(data, ...)
        x$setinverse(inv)
        inv
}
## Going back to the example from above, the command for cacheSolve would look like this:
## cacheSolve(a)
## 
## Which would result in the inverse of our example matrix being returned:
##      [,1] [,2]
## [1,]   -2  1.5
## [2,]    1 -0.5
##