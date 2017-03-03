#' Sison & Glaz Confidence Interval
#'
#' The simultaneous confidence interval for multinomial proportions based on the method proposed in Sison and Glaz (1995).
#'
#' @md
#' @param inpmat the cell counts of given contingency tables corresponding to categorical data
#' @param alpha a number in `[0..1]` to get the upper 100(1-`alpha`) percentage point of the chi square distribution
#' @return `tibble` with original and adjusted limits of multinomial proportions together with product of length of k intervals as volume of simultaneous confidence intervals
#' @author Dr M Subbiah
#' @references Sison, P.C. and Glaz J. (1995). Simultaneous Confidence Intervals and Sample Size Determination for Multinomial Proportions. Journal of the American Statistical Association 90: 366-369.
#' @export
#' @examples
#' y <- c(44, 55, 43, 32, 67, 78)
#' z <- 0.05
#' scimp_sg(y, z)
scimp_sg <- function(inpmat, alpha) {
  return(SG(inpmat, alpha))
}
