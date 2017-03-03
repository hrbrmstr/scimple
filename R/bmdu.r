#' Bayesian Multinomial Dirichlet Model (Unequal Prior)
#'
#' This method provides 95 percent simultaneous confidence interval for multinomial proportions based on Bayesian Multinomial Dirichlet model. However, it provides a mechanism through which user can split the Dirichlet prior parameter vector and suitable distributions can be incorporated for each of two groups.
#'
#' @md
#' @param x cell counts of given contingency table corresponding to a categorical data - non negative integers
#' @param d number of divisions required to split the prior vector of Dirichlet distribution to assign unequal values from U(0,1) and U(1,2)
#' @param seed random seed for reproducible results
#' @return `tibble` with original limits of multinomial proportions together with product of length of k intervals as volume of simultaneous confidence intervals and the mean
#' @author Dr M Subbiah
#' @references Gelman, A., Carlin, J.B., Stern, H.S., and Rubin, D.B. (2002). Bayesian Data Analysis. Chapman & Hall, London.
#' @export
#' @examples
#' y <- c(44, 55, 43, 32, 67, 78)
#' z <- 2
#' scimp_bmdu(y, z)
scimp_bmdu <- function(x, d, seed=1492) {
  return(BMDU(x, d, seed))
}
