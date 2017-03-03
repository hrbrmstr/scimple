#' Wald Confidence Interval
#'
#' The simple Wald type interval for multinomial proportions which is symmetrical about the
#' sample proportions. In this method no continuity corrections are made to avoid zero width
#' intervals when the sample proportions are at extreme.
#'
#' @md
#' @param inpmat the cell counts of given contingency tables corresponding to categorical data
#' @param alpha a number in `[0..1]` to get the upper 100(1-`alpha`) percentage point of the chi square distribution
#' @return `tibble` with original and adjusted limits of multinomial proportions together with product of length of k intervals as volume of simultaneous confidence intervals
#' @author Dr M Subbiah
#' @references Wald, A Tests of statistical hypotheses concerning several parameters when the number of observations is large, Trans. Am. Math. Soc. 54 (1943) 426-482.
#' @export
#' @examples
#' y <- c(44, 55, 43, 32, 67, 78)
#' z <- 0.05
#' scimp_wald(y, z)
scimp_wald <- function(inpmat, alpha) {

  k <- length(inpmat)
  s <- sum(inpmat)
  chi <- qchisq(1 - alpha, df = 1)
  pi <- inpmat / s

  wald_ll = pi - (sqrt(chi*(pi)*(1-pi)/s))
  wald_ul = pi + (sqrt(chi*(pi)*(1-pi)/s))

  adj_ll <- adj_ul <- 0

  for (r in 1:length(inpmat)) {
    if (wald_ll[r] < 0) adj_ll[r] <- 0 else adj_ll[r] <- wald_ll[r]
    if (wald_ul[r] > 1) adj_ul[r] <- 1 else adj_ul[r] <- wald_ul[r]
  }

  ci_length <- adj_ul - adj_ll
  volume <- round(prod(ci_length), 8)

  data_frame(
    method = "wald",
    lower_limit = wald_ll,
    upper_limit = wald_ul,
    adj_ll = adj_ll,
    adj_ul = adj_ul,
    volume = volume
  ) -> ret

  ret

}
