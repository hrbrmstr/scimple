#' Calculate multiple simultaneous confidence intervals using selected methods (excluding Bayesian methods)
#'
#' Return simultaneous confidence intervals for multinomial proportions based on selected methods.
#'
#' @md
#' @param inpmat the cell counts of given contingency tables corresponding to categorical data
#' @param alpha a number in `[0..1]` to get the upper 100(1-`alpha`) percentage point of the chi square distribution
#' @param methods character vector of one or more methods to run over the input parameters
#' @return `tibble` with original and adjusted limits of multinomial proportions together with
#'         product of length of k intervals as volume of simultaneous confidence intervals.
#'         The `inputmat` and `alpha` values are also returned in the `tibble`.
#' @author Bob Rudis (bob@@rud.is)
#' @export
#' @examples
#' y <- c(44,55,43,32,67,78)
#' z <- 0.05
#' scimple_ci(y, z)
#' scimple_ci(y, z, c("goodman", "waldcc", "wilson"))
scimple_ci <- function(inpmat, alpha,
                       methods=c("fs", "goodman", "qh", "sg", "wald", "waldcc", "wilson")) {

  methods <- unique(tolower(methods))
  methods <- match.arg(methods, c("fs", "goodman", "qh", "sg", "wald", "waldcc", "wilson"),
                       several.ok=TRUE)

  map_df(methods, function(func) {
    df <- ci_funcs[[func]](inpmat, alpha)
    mutate(df, inpmat=inpmat, alpha=alpha)
  })

}
