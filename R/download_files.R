


# download a singular file
download_file <- function(url, path) {
  
  file_name <- basename({{ url }})
  
  headers = c(
    `user-agent` = 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/102.0.5005.61 Safari/537.36'
  )
  
  raw_xlsx <- httr::GET(url = {{ url }}, httr::add_headers(.headers=headers))$content
  
  path <- paste0({{ path }}, "/", file_name)
  
  writeBin(raw_xlsx, path)
  
}


# download multiple files
download_files <- function(urls, path) {
  
  purrr::map(.x = {{ urls }}, .f = ~download_file(., path = {{ path }}))
  
  
}







