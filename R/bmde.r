#' Bayesian Multinomial Dirichlet Model (Equal Prior)
#'
#' This method provides 95 percent simultaneous confidence interval for multinomial proportions based on Bayesian Multinomial Dirichlet model. However, it provides a mechanism through which user can split the Dirichlet prior parameter vector and suitable distributions can be incorporated for each of two groups.
#'
#' @md
#' @param x cell counts of given contingency table corresponding to a categorical data - non negative integers
#' @param p equal value for the Dirichlet prior parameter - positive real number
#' @param seed random seed for reproducible results
#' @return `tibble` with original limits of multinomial proportions together with product of length of k intervals as volume of simultaneous confidence intervals and the mean
#' @author Dr M Subbiah
#' @references Gelman, A., Carlin, J.B., Stern, H.S., and Rubin, D.B. (2002). Bayesian Data Analysis. Chapman & Hall, London.
#' @export
#' @examples
#' y <- c(44, 55, 43, 32, 67, 78)
#' z <- 1
#' scimp_bmde(y, z)
scimp_bmde <- function(x, p, seed=1492) {

  k <- length(x)
  n_r <- 10000
  for(m in 1:k) {
    if(x[m]<0) {warning('Arguments must be non-negative integers') }
  }

  set.seed(seed)

  po <- x+p
  dr <- rdirichlet(n_r,po)
  a <- l <- u <- dif <- 0

  for(j in 1:k) {
    a[j] <- round(mean(dr[,j]), 4)
    l[j] <- round(quantile(dr[,j], 0.025),4)
    u[j] <- round(quantile(dr[,j], 0.975),4)
    dif[j] <- u[j] - l[j]
  }

  tibble(
    method = "bmde",
    lower_limit = l,
    upper_limit = u,
    volume = prod(dif),
    mean = a
  )

}
