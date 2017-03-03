ci_funcs <- c(scimp_fs, scimp_goodman, scimp_qh, scimp_sg, scimp_wald, scimp_waldcc, scimp_wilson)
names(ci_funcs) <- c("fs", "goodman", "qh", "sg", "wald", "waldcc", "wilson")

#' @title Simple tranlsation table from method shorthand to full method name
#' @docType data
#' @export
#' @examples
#' scimple_short_to_long[c("waldcc", "sg", "qh)]
scimple_short_to_long <- c(wilson="Wilson", waldcc="Wald (continuity correction)",
                           wald="Wald", fs="Fitzpatrick & Scott", goodman="Goodman",
                           sg="Sison & Glaz", qh="Quesenberry and Hurst")
