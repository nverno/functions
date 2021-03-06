## Question on SO
## Example data: list of data.frames
set.seed(0)
ns <- c(10,5,3)                                 # number of rows in each data.frame
ids <- runif(sum(ns), 0, 100)                   # some ids
cll <- quote(data.frame(var     = rnorm(i),     # call to create data.frames
                        id      = ids[1:i],
                        y       = 1:i,
                        x       = 1:i,
                        pos     = letters[1:i],
                        stringsAsFactors = F))
lstForm <- lapply(ns, function(i)               # create list of data.frames
                  eval(cll, list(i = i)))

## Desired output: list of matrices
ncols <- max(unlist(lapply(lstForm, nrow)))     # number cols of each matrix
nrows <- length(lstForm)                        # number of rows for each matrix
colNames <- names(lstForm[[1]])                 # matrix names
matForm <- lapply(colNames, FUN = function(x)   # initialize matrices
                  matrix(NA, nrow = nrows, ncol = ncols))
names(matForm) <- colNames

## Filling the matrices using for loops
for (i in seq_along(lstForm)) {
    n <- nrow(lstForm[[i]])                     # number of columns to fill
    for (column in colNames) {
        matForm[[column]][i, 1:n] <- lstForm[[i]][[column]]
    }
}
