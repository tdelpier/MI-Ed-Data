



## Unzip files from data_downloads ----------------------------------------------

get_file_extention <- function(file){ 
  ex <- strsplit(basename(file), split="\\.")[[1]]
  return(ex[-1])
} 



filter_only_files <- function(files, ...) {
  
  files <- 
    files %>% 
    data.frame() %>% 
    dplyr::mutate(file.extention = purrr::map(.x = ., .f = get_file_extention)) %>% 
    dplyr::filter(file.extention %in% c(...)) %>% 
    dplyr::select(".") %>% 
    dplyr::pull()
  
  return(files)
  
}


unzip_files <- function(data_downloads, data_raw) {
  
  files_to_unzip <- dir({{ data_downloads }},  full.names = TRUE) %>% filter_only_files("zip") 

  purrr::map(.x = files_to_unzip, 
             .f = ~archive::archive_extract(
               archive = .,
               dir = {{ data_raw }}))
  
}

unzip_files(data_downloads = paste0(selected_directory, "/FID/data_downloads"),
            data_raw = paste0(selected_directory,"/FID/data_raw"))



## Move excel files from data_downloads to data_raw

copy_datafiles <- function(data_downloads, data_raw) {
  
  data_based_files <- 
    list.files({{ data_downloads }}, full.names = TRUE) %>% 
    filter_only_files("xls", "csv", "dbf", "DBF", "xlsx")
  
  
  purrr::map(.x = data_based_files, 
             .f = ~file.copy(from = .,
                             to = {{ data_raw }}))
  

}




## move documentation to documentation folder


move_documentation <- function(data_raw, documentation) {
  
  text_based_files <- 
    list.files({{ data_raw }}, full.names = TRUE) %>% 
    filter_only_files("pdf", "rtf", "txt", "doc", "docx")
  
  
  purrr::map(.x = text_based_files, 
             .f = ~file.copy(from = .,
                             to = {{ documentation }}))
  
  file.remove(text_based_files)
  
}















# unzip(zipfile = test_zip, exdir = tt_dir_projects("test"))
# purrr::map(.x = file.name.long, .f = ~unzip(zipfile = ., exdir = tt_dir_projects("test")))































































######################################################################################




# 
# select_data_files_from_zip <- function(file) {
#   
#   file %>% 
#     archive::archive() %>% 
#     dplyr::select(path) %>% 
#     dplyr::pull() %>% 
#     filter_only_files("dbf", "xlsx")
#   
# }
# 
# select_data_files_from_zip(paste0(selected_directory,"/FID/data_downloads", "/13_FID_datasets.zip"))
# 
# 
# 
# 
# extract_data_file <- function(data_downloads, data_raw, file) {
#   
#   files_to_extract <- 
#     file %>% 
#     select_data_files_from_zip()
#   
#   file %>% 
#     archive::archive_extract(dir = {{ data_downloads }}, 
#                              files = files_to_extract)
#   
# }
# 
# 
# 
# 
# archive::archive_extract(archive = paste0(selected_directory,"/FID/data_downloads", "/13_FID_datasets.zip"),
#                          dir = paste0(selected_directory,"/FID/data_raw"))
# 
# 
# 
# 
# purrr::map(.x = {{ urls }}, .f = ~download_file(., path = {{ path }}))
# 
# 
# unzip_files <- function(data_downloads, data_raw) {
#   
#   extract_data_file()
#   
#   directory %>% 
#     list.files(full.names = TRUE) %>% 
#     filter_only_files("zip") %>% 
#     purrr::map(.x = ., .f = extract_data_file)
#     
#   
# }
# 
#   
# 
# 





