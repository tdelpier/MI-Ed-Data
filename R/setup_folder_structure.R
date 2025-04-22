


setup_folder_structure <- function() {
  
  dir.create(path = paste0(selected_directory, "/FID"))
  dir.create(path = paste0(selected_directory, "/FID/data_downloads"))
  dir.create(path = paste0(selected_directory, "/FID/data_raw"))
  dir.create(path = paste0(selected_directory, "/FID/data_clean"))
  dir.create(path = paste0(selected_directory, "/FID/documentation"))
  
  
}


# initiate file structure

# FID
  # downloads
  # extracted
  # clean
