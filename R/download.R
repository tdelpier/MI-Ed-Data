


# there's nothing specific about the FID in here
# maybe change this to "download_file"
download_file <- function(url, path = getwd()) {
  
  file_name <- basename({{ url }})
  
  
  headers = c(
    `user-agent` = 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/102.0.5005.61 Safari/537.36'
  )
  
  raw_xlsx <- httr::GET(url = {{ url }}, httr::add_headers(.headers=headers))$content
  
  path <- paste0({{ path }}, "/", file_name)

  writeBin(raw_xlsx, path)
  
  
}


# maybe this is the function for download FID
purrr::map(.x = fid_urls(), .f = ~download_file(., tt_dir_projects("test")))


download_file("https://www.michigan.gov/cepi/-/media/Project/Websites/cepi/MISchoolData/2022-23/2023CEPI_32_33_35_Data.zip",
              tt_dir_projects("test"))



