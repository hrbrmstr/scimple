#' Fitzpatrick and Scott Confidence Interval
#'
#' The simultaneous confidence interval for multinomial proportions based on the method proposed in Fitzpatrick and Scott (1987)
#'
#' @md
#' @param inpmat the cell counts of given contingency tables corresponding to categorical data
#' @param alpha a number in `[0..1]` to get the upper 100(1-`alpha`) percentage point of the chi square distribution
#' @return `tibble` with original and adjusted limits of multinomial proportions together with product of length of k intervals as volume of simultaneous confidence intervals
#' @author Dr M Subbiah
#' @references Fitzpatrick, S. and Scott, A. (1987). Quick simultaneous confidence interval for multinomial proportions. Journal of American Statistical Association 82(399): 875-878.
#' @export
#' @examples
#' y <- c(44, 55, 43, 32, 67, 78)
#' z <- 0.05
#' scimp_fs(y, z)
scimp_fs <- function(inpmat, alpha) {

  k <- length(inpmat)
  s <-  sum(inpmat)
  zval <- abs(qnorm(1 - (alpha/2)))
  pi <- inpmat/s

  fs_ll <- pi - (zval / (2 * sqrt(s)))
  fs_ul <- pi + (zval / (2 * sqrt(s)))

  adj_ll <- adj_ul <- 0

  for (r in 1:length(inpmat)) {
    if (fs_ll[r] < 0) adj_ll[r] <- 0 else adj_ll[r] <- fs_ll[r]
    if (fs_ul[r] > 1) adj_ul[r] <- 1 else adj_ul[r] <- fs_ul[r]
  }

  ci_length <- adj_ul - adj_ll
  volume <- round(prod(ci_length), 8)

  data_frame(
    method = "fs",
    lower_limit = fs_ll,
    upper_limit = fs_ul,
    adj_ll = adj_ll,
    adj_ul = adj_ul,
    volume = volume
  ) -> ret

  ret

}
