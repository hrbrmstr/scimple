tibble <- function(...) {

  out <- data.frame(..., stringsAsFactors = FALSE)

  class(out) <- c("tbl_df", "tbl", "data.frame")

  out

}
