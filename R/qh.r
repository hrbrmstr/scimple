#' Quesenberry & Hurst Confidence Interval
#'
#' The simultaneous confidence interval for multinomial proportions based on the method proposed in Quesenberry and Hurst (1964)
#'
#' @md
#' @param inpmat the cell counts of given contingency tables corresponding to categorical data
#' @param alpha a number in `[0..1]` to get the upper 100(1-`alpha`) percentage point of the chi square distribution
#' @return `tibble` with original and adjusted limits of multinomial proportions together with product of length of k intervals as volume of simultaneous confidence intervals
#' @author Dr M Subbiah
#' @references Quesensberry, C.P. and Hurst, D.C. (1964). Large Sample Simultaneous Confidence Intervals for Multinational Proportions. Technometrics, 6: 191-195.
#' @export
#' @examples
#' y <- c(44, 55, 43, 32, 67, 78)
#' z <- 0.05
#' scimp_qh(y, z)
scimp_qh <- function(inpmat, alpha) {

  k <- length(inpmat)
  s <- sum(inpmat)
  chi <- qchisq(1-alpha, df=k-1)
  pi <- inpmat/s

  qh_ul <- (chi + 2*inpmat + sqrt(chi*chi + 4*inpmat*chi*(1 - pi)))/(2*(chi+s))
  qh_ll <- (chi + 2*inpmat - sqrt(chi*chi + 4*inpmat*chi*(1 - pi)))/(2*(chi+s))

  adj_ll <- adj_ul <- 0

  for (r in 1:length(inpmat)) {
    if (qh_ll[r] < 0) adj_ll[r] <- 0 else adj_ll[r] <- qh_ll[r]
    if (qh_ul[r] > 1) adj_ul[r] <- 1 else adj_ul[r] <- qh_ul[r]
  }

  ci_length <- adj_ul - adj_ll
  volume <- round(prod(ci_length), 8)

  data_frame(
    method = "qh",
    lower_limit = qh_ll,
    upper_limit = qh_ul,
    adj_ll = adj_ll,
    adj_ul = adj_ul,
    volume = volume
  ) -> ret

  ret

}
