#' data simulation function for SHC testing. 
#' File also includes a "fixed" version of the pvclust function
#' which originally called on dist(..) with the transposed dataset
#'
#' @author Patrick Kimes

#'
#' n
#' p
#' delta
#' K
#' arr
#'

simulator <- function(n, p, delta, K, arr) {

    if (K == 1) {
        ##use delta as spike size
        matrix(rnorm(n*p), n, p) %*% diag(c(delta, rep(1, p-1)))

    } else if (K == 2) {
        cbind(delta/2*rep(c(-1, 1), each=n), matrix(1, 2*n, p-1)) +
            matrix(rnorm(2*n*p), 2*n, p)

    } else if (K == 3) {
        if (arr == "triangle") {
            m1 <- c(-delta/2, -delta*sqrt(3)/4, rep(0, p-2))
            m2 <- c(      0,  delta*sqrt(3)/4, rep(0, p-2))
            m3 <- c( delta/2, -delta*sqrt(3)/4, rep(0, p-2))
            mui <- rbind(m1, m2, m3)
            mui[rep(1:3, n), ] +
                matrix(rnorm(3*n*p), 3*n, p)
            
        } else if (arr == "line") {
            m1 <- c(-delta, rep(0, p-1))
            m2 <- c(    0, rep(0, p-1))
            m3 <- c( delta, rep(0, p-1))
            mui <- rbind(m1, m2, m3)        
            mui[rep(1:3, n), ] +
                matrix(rnorm(3*n*p), 3*n, p)
            
        }

    } else if (K == 4) {
        if (arr == "line") {
            m1 <- c(-1.5*delta, rep(0, p-1))
            m2 <- c(-0.5*delta, rep(0, p-1))
            m3 <- c( 0.5*delta, rep(0, p-1))
            m4 <- c( 1.5*delta, rep(0, p-1))
            mui <- rbind(m1, m2, m3, m4)
            mui[rep(1:4, n), ] +
                matrix(rnorm(4*n*p), 4*n, p)
            
        } else if (arr == "square") {
            m1 <- c(-delta/2, -delta/2,  rep(0, p-2))
            m2 <- c( delta/2, -delta/2,  rep(0, p-2))
            m3 <- c(-delta/2,  delta/2,  rep(0, p-2))
            m4 <- c( delta/2,  delta/2,  rep(0, p-2))
            mui <- rbind(m1, m2, m3, m4)
            mui[rep(1:4, n), ] +
                matrix(rnorm(4*n*p), 4*n, p)

        } else if (arr == "tetra") {
            m1 <- c(-delta/2,       0, -delta/sqrt(8), rep(0, p-3))
            m2 <- c( delta/2,       0, -delta/sqrt(8), rep(0, p-3))
            m3 <- c(      0, -delta/2,  delta/sqrt(8), rep(0, p-3))
            m4 <- c(      0,  delta/2,  delta/sqrt(8), rep(0, p-3))
            mui <- rbind(m1, m2, m3, m4)
            mui[rep(1:4, n), ] +
                matrix(rnorm(4*n*p), 4*n, p)

        } else if (arr == "rect") {
            m1 <- c( delta*3/4,  delta/2, rep(0, p-2))
            m2 <- c( delta*3/4, -delta/2, rep(0, p-2))
            m3 <- c(-delta*3/4,  delta/2, rep(0, p-2))
            m4 <- c(-delta*3/4, -delta/2, rep(0, p-2))
            mui <- rbind(m1, m2, m3, m4)
            mui[rep(1:4, n), ] +
                matrix(rnorm(4*n*p), 4*n, p)
            
        }
    }
} 

