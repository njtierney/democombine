#' Our own combine method
#'
#' @param x data
#' @param ... extra args
#'
#' @return combined values
#' @export
combine <- function(x, ...){
    UseMethod("combine")
}

#' @export
combine.my_class <- function(x, y,...){
    cat("combining x and y")
    cat("\n")
    c(x, y)
}
