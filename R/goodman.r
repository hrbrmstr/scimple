#' Goodman Confidence Interval
#'
#' The simultaneous confidence interval for multinomial proportions based on the method proposed in Goodman (1965)
#'
#' @md
#' @param inpmat the cell counts of given contingency tables corresponding to categorical data
#' @param alpha a number in `[0..1]` to get the upper 100(1-`alpha`) percentage point of the chi square distribution
#' @return `tibble` with original and adjusted limits of multinomial proportions together with product of length of k intervals as volume of simultaneous confidence intervals
#' @author Dr M Subbiah
#' @references Goodman, L.A. (1965). On Simultaneous Confidence Intervals for Multinomial Proportions. Technometrics 7: 247-254.
#' @export
#' @examples
#' y <- c(44, 55, 43, 32, 67, 78)
#' z <- 0.05
#' scimp_goodman(y, z)
scimp_goodman <- function(inpmat, alpha) {

  k <- length(inpmat)
  s <- sum(inpmat)
  chi <- qchisq(1 - (alpha/k), df = 1)
  pi <- inpmat/s

  goodman_ul <- (chi + 2*inpmat + sqrt(chi*chi + 4*inpmat*chi*(1 - pi)))/(2*(chi+s))
  goodman_ll <- (chi + 2*inpmat - sqrt(chi*chi + 4*inpmat*chi*(1 - pi)))/(2*(chi+s))

  adj_ll <- adj_ul <- 0

  for (r in 1:length(inpmat)) {
    if (goodman_ll[r] < 0) adj_ll[r] <- 0 else adj_ll[r] <- goodman_ll[r]
    if (goodman_ul[r] > 1) adj_ul[r] <- 1 else adj_ul[r] <- goodman_ul[r]
  }

  ci_length <- adj_ul - adj_ll
  volume <- round(prod(ci_length), 8)

  data_frame(
    method = "goodman",
    lower_limit = goodman_ll,
    upper_limit = goodman_ul,
    adj_ll = adj_ll,
    adj_ul = adj_ul,
    volume = volume
  ) -> ret

  ret

}
