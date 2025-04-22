



#' import FID Revenue data
#'
#' @export
fid_rev_import <- function() {
  
  read_rds(paste0(selected_directory, "/FID/data_clean/FID_Rev.rds"))
  
}


