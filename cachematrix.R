## This file contains two functions
## The first creates a special "matrix" object that can cache its inverse.
## The second computes the inverse of the special "matrix" returned by the first


## Using a square matrix input this function
## checks if the input matrix is invertible
## creates a special "matrix" object that can cache its inverse

makeCacheMatrix <- function(x = matrix()) {
  ## x: a square matrix
  ## return: a list containing functions to
  ##              1. set the matrix
  ##              2. get the matrix
  ##              3. set the inverse
  ##              4. get the inverse
  ##         this list is used as the input to cacheSolve()
  
  ## check if empty (NA) matrix 
  ## check the matrix determinant det(), 
  ## if zero matrix is singular and inverse cannot be calculated
  test <- det(x)
  if (all(is.na(x) == FALSE)){
    if (test == 0){
      print("Matrix is not invertible")
    } 
  }
  
  
  inv = NULL
  set = function(y) {
    # use `<<-` to assign a value to an object in an environment (as cache)
    # different from the current environment. 
    x <<- y
    inv <<- NULL
  }
  get = function() x
  setinv = function(inverse) inv <<- inverse 
  getinv = function() inv
  list(set=set, get=get, setinv=setinv, getinv=getinv)
}


## This function takes the output of makeCacheMatrix()
## and returns the inverse of the matrix initially input 

cacheSolve <- function(x, ...) {
  ## Return a matrix that is the inverse of 'x'
  ## input x == output of makeCacheMatrix()
  ## returns inverse of the original matrix input to makeCacheMatrix() above
  
  inv = x$getinv()
  
  # if the inverse has already been calculated
  if (!is.null(inv)){
    # get it from the cache and skips the computation. 
    message("getting cached data")
    return(inv)
  }
  
  # otherwise, calculates the inverse 
  mat.data = x$get()
  inv = solve(mat.data, ...)
  
  # sets the value of the inverse in the cache via the setinv function.
  x$setinv(inv)
  
  return(inv)
}
