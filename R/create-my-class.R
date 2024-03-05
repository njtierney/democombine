#' Create your own class
#'
#' @param x object
#' @param ... args
#'
#' @return "my_class" object
#' @export
my_class <- function(x, ...){
    class(x) <- c("my_class", class(x))
    x
}
