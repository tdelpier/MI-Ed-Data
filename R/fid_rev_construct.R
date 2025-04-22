



#' construct FID revenue data 
#'
#' @export
fid_rev_construct <- function() {
  
  fid_metadata <- fid_metadata()
  
  func1 <- function(path) {
    
    readxl::read_xlsx(path = {{ path }},
                      sheet = "District Revenue Data",
                      skip = 4) %>%
      fid_rev_clean()
    
  }
  
  
  func2 <- function(path) {
    
    readxl::read_xlsx(path = {{ path }},
                      sheet = "Revenue Data",
                      skip = 4) %>% 
      fid_rev_clean()
    
  }
  
  
  func3 <- function(path) {
    
    readxl::read_xlsx(path = {{ path }},
                      sheet = "Data",
                      skip = 4) %>% 
      fid_rev_clean()
    
    
  }
  
  
  func4 <- function(path) {
    
    readxl::read_xlsx(path = {{ path }},
                      sheet = "Data",
                      skip = 2) %>% 
      fid_rev_clean()
    
    
  }
  
  
  func5 <- function(path) {
    
    readxl::read_xlsx(path = {{ path }},
                      sheet = "REVENUE",
                      skip = 0) %>% 
      mutate(fiscal.year = 2014) %>% 
      fid_rev_clean()
    
  }
  
  
  func6 <- function(path) {
    
    
    readxl::read_xlsx(path = {{ path }},
                      skip = 0) %>% 
      fid_rev_clean()
    
    
  }
  
  
  
  
  # func7 here
  func7<- function(path) {
    
    foreign::read.dbf(file = {{ path }}, as.is = TRUE) %>%
      tibble() %>% 
      mutate(FY = 2010) %>% 
      fid_rev_clean()
    
    
  }
  
  
  func8<- function(path) {
    
    foreign::read.dbf(file = {{ path }}, as.is = TRUE) %>%
      tibble() %>% 
      mutate(FY = 2011) %>% 
      fid_rev_clean()
    
    
  }
  
  
  
  func9<- function(path) {
    
    foreign::read.dbf(file = {{ path }}, as.is = TRUE) %>%
      tibble() %>% 
      fid_rev_clean()
    
    
  }
  
  
  reading_func <- function(metadata, func) {
    
    
    paths <- {{ metadata }} %>% select(file.path) %>% pull()
    ids <- {{ metadata }} %>% select(file.id) %>% pull()
    file.name.long <- purrr::set_names(paths, ids)
    
    data <- 
      purrr::map_dfr(.x = file.name.long, .f = ~{{func}}(.), .id = "data.source" )
    
    return(data)
    
  }
  
  
  
  
  fidr_04_09 <- 
    fid_metadata %>% 
    filter(type == "rev",
           FY %in% c(2004:2009)) %>% 
    reading_func(func9)
  
  fidr_10 <- 
    fid_metadata %>% 
    filter(type == "rev",
           FY %in% c(2010)) %>% 
    reading_func(func7)
  
  
  fidr_11 <- 
    fid_metadata %>% 
    filter(type == "rev",
           FY %in% c(2011)) %>% 
    reading_func(func8)
  
  fidr_12_13 <- 
    fid_metadata %>% 
    filter(type == "rev",
           FY %in% c(2013, 2012)) %>% 
    reading_func(func6)
  
  
  fidr_14 <- 
    fid_metadata %>% 
    filter(type == "rev",
           FY %in% c(2014)) %>% 
    reading_func(func5)
  
  
  fidr_15 <- 
    fid_metadata %>% 
    filter(type == "rev",
           FY %in% c(2015)) %>% 
    reading_func(func4)
  
  
  fidr_16_17 <- 
    fid_metadata %>% 
    filter(type == "rev",
           FY %in% c(2017, 2016)) %>% 
    reading_func(func3)
  
  
  fidr_18 <- 
    fid_metadata %>% 
    filter(type == "rev",
           FY %in% c(2018)) %>% 
    reading_func(func2)
  
  
  fidr_19_23 <- 
    fid_metadata %>% 
    filter(type == "rev",
           FY >= 2019) %>% 
    reading_func(func1)
  
  
  
  x2 <- 
    fidr_04_09 %>% 
    bind_rows(fidr_10) %>%
    bind_rows(fidr_11) %>% 
    bind_rows(fidr_12_13) %>% 
    bind_rows(fidr_14) %>% 
    bind_rows(fidr_15) %>% 
    bind_rows(fidr_16_17) %>% 
    bind_rows(fidr_18) %>% 
    bind_rows(fidr_19_23) %>% 
    ungroup() %>% 
    mutate(amount = ifelse(FY == 2012, amount * -1, amount))
  
  
  
  x2 %>% 
    write_rds(file = paste0(selected_directory, "/FID/data_clean/FID_Rev.rds"))
  
  
  
}

