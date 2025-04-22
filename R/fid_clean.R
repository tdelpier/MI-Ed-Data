


  


#' FID revenue clean
#'
#' @export
fid_rev_clean <- function(df) {

  lookup <- c(
    FY = "fy",
    FY = "fiscalyear",
    icode = "isdcode",
    icode = "isd",
    icod = "ISD",
    iname = "isdname",
    dcode = "districtcode",
    dcode = "DCODE",
    dname = "districtname",
    dname = "DISTNAME",
    dname = "distname",
    fund = "fundcode",
    suffix = "suffixcode",
    majorclass = "MAJORCLASS",
    majorclass = "majorclasscode"
  )
  
  
  
  data <- 
    df %>% 
  janitor::clean_names(sep_out = "") %>% 
    rename(any_of(lookup)) %>% 
    mutate(FY = as.numeric(FY),
           dnum = as.numeric(dcode),
           fund = as.numeric(fund),
           majorclass = as.numeric(majorclass),
           suffix = as.numeric(suffix),
           amount = as.numeric(amount) * -1) %>% 
    select(FY, dnum, dcode, dname, icode, iname, fund, majorclass, suffix, amount) %>% 
    filter(!is.na(dnum)) %>% 
    mutate(dcode = stringr::str_pad(as.character(dnum), 5, side = "left", pad = "0" ),
           icode = stringr::str_pad(as.character(dnum), 2, side = "left", pad = "0" ))
  return(data)
  
}










