


fid_rev_construct_from_scratch <- function() {
  
  setup_folder_structure()
  
  fid_urls <- fid_urls()  # just using a couple files for speed
  download_files(urls = fid_urls, path = paste0(selected_directory,"/FID/data_downloads"))
  
  
  
  ## unzipping from download
  unzip_files(data_downloads = paste0(selected_directory, "/FID/data_downloads"),
              data_raw = paste0(selected_directory,"/FID/data_raw"))
  
  
  copy_datafiles(data_downloads = paste0(selected_directory, "/FID/data_downloads"),
                 data_raw = paste0(selected_directory,"/FID/data_raw"))
  
  
  move_documentation(data_raw = paste0(selected_directory,"/FID/data_raw"),
                     documentation = paste0(selected_directory,"/FID/documentation"))
  
  
  
  # construct 
  
  fid_rev_construct()
  
  
  
  
  
}