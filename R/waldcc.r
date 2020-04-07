#' Wald Confidence Interval (with continuity correction)
#'
#' The simple Wald type interval with continuity corrections for multinomial proportions which is symmetrical about the sample proportions.
#'
#' @md
#' @param inpmat the cell counts of given contingency tables corresponding to categorical data
#' @param alpha a number in `[0..1]` to get the upper 100(1-`alpha`) percentage point of the chi square distribution
#' @return `tibble` with original and adjusted limits of multinomial proportions together with product of length of k intervals as volume of simultaneous confidence intervals
#' @author Dr M Subbiah
#' @export
#' @examples
#' y <- c(44, 55, 43, 32, 67, 78)
#' z <- 0.05
#' scimp_waldcc(y, z)
scimp_waldcc <- function(inpmat, alpha) {

  k <- length(inpmat)
  s <- sum(inpmat)
  chi <- qchisq(1 - alpha, df = 1)
  pi <- inpmat / s

  waldcc_ll = pi - (sqrt(chi*(pi)*(1-pi)/s))-(1/(2*s))
  waldcc_ul = pi + (sqrt(chi*(pi)*(1-pi)/s))+(1/(2*s))

  adj_ll <- adj_ul <- 0

  for (r in 1:length(inpmat)) {
    if (waldcc_ll[r] < 0) adj_ll[r] <- 0 else adj_ll[r] <- waldcc_ll[r]
    if (waldcc_ul[r] > 1) adj_ul[r] <- 1 else adj_ul[r] <- waldcc_ul[r]
  }

  ci_length <- adj_ul - adj_ll
  volume <- round(prod(ci_length), 8)

  tibble(
    method = "waldcc",
    lower_limit = waldcc_ll,
    upper_limit = waldcc_ul,
    adj_ll = adj_ll,
    adj_ul = adj_ul,
    volume = volume
  ) -> ret

  ret

}
