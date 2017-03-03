#' Simultaneous Confidence Intervals for Multinomial Proportions
#'
#' Methods for obtaining simultaneous confidence intervals for multinomial proportions have
#' been proposed by many authors and the present study include a variety of widely
#' applicable procedures. Seven classical methods (Wilson, Quesenberry and Hurst, Goodman,
#' Wald with and without continuity correction, Fitzpatrick and Scott, Sison and Glaz)
#' and Bayesian Dirichlet models are included in the package. The advantage of MCMC pack
#' has been exploited to derive the Dirichlet posterior directly and this also helps in
#' handling the Dirichlet prior parameters. This package is prepared to have equal and
#' unequal values for the Dirichlet prior distribution that will provide better scope for
#' data analysis and associated sensitivity analysis.
#'
#' @name scimple
#' @docType package
#' @author Dr M.Subbiah [primary], Bob Rudis (bob@@rud.is) [tidy version]
#' @import tibble stats MCMCpack
#' @importFrom dplyr mutate select
#' @importFrom purrr map map_df
NULL
