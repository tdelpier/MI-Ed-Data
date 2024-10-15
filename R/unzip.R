



# unzip(zipfile = test_zip, exdir = tt_dir_projects("test"))
# purrr::map(.x = file.name.long, .f = ~unzip(zipfile = ., exdir = tt_dir_projects("test")))



get_file_extention <- function(file){ 
  ex <- strsplit(basename(file), split="\\.")[[1]]
  return(ex[-1])
} 


filter_only_files <- function(df, ...) {
  
  df %>% 
    data.frame() %>% 
    dplyr::mutate(file.extention = purrr::map(.x = ., .f = get_file_extention)) %>% 
    dplyr::filter(file.extention %in% c(...)) %>% 
    dplyr::select(".") %>% 
    dplyr::pull()
  
}

select_data_files_from_zip <- function(file) {
  
  file %>% 
    archive::archive() %>% 
    dplyr::select(path) %>% 
    dplyr::pull() %>% 
    filter_only_files("dbf", "xlsx")
  
}




files <- dir(tt_dir_projects("test"),  full.names = TRUE)


files %>% 
  filter_only_files("zip") %>% 
  head(1) %>% 
  select_data_files_from_zip() %>% 
  head(1) %>% 
  unzip(exdir = tt_dir_projects("test"))
  archive::archive_extract(dir = tt_dir_projects("test"))


files[1] %>% 
  select_data_files_from_zip() %>% 
  head(1) 
  unzip(exdir = tt_dir_projects("test"))
archive::archive_extract(dir = tt_dir_projects("test"))

files_to_extract <- 
  files[1] %>% 
  select_data_files_from_zip()


files[1] %>% archive::archive_extract(dir = tt_dir_projects("test"), files = files_to_extract)
files[2] %>% archive::archive_extract(dir = tt_dir_projects("test"))




files[1] %>% extract_data_files()


extract_data_files <- function(directory) {
  
  
  extract_data_file <- function(file) {
    
    files_to_extract <- 
      file %>% 
      select_data_files_from_zip()
    
    file %>% 
      archive::archive_extract(dir = tt_dir_projects("test"), 
                               files = files_to_extract)
    
  }
  
  
  directory %>% 
    list.files(full.names = TRUE) %>% 
    filter_only_files("zip") %>% 
    purrr::map(.x = ., .f = extract_data_file)
    
  
}


extract_data_files(tt_dir_projects("test"))
  










