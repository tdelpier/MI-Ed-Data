
library(devtools)
library(TannersTools)
library(dplyr)

load_all()



# FID Download workflow


## setup folder structures 
selected_directory <- rstudioapi::selectDirectory()
setup_folder_structure()


## download FID files
fid_urls <- fid_urls()  # just using a couple files for speed
download_files(urls = fid_urls, path = paste0(selected_directory,"/FID/data_downloads"))



## unzipping from download
unzip_files(data_downloads = paste0(selected_directory, "/FID/data_downloads"),
            data_raw = paste0(selected_directory,"/FID/data_raw"))


copy_datafiles(data_downloads = paste0(selected_directory, "/FID/data_downloads"),
               data_raw = paste0(selected_directory,"/FID/data_raw"))


move_documentation(data_raw = paste0(selected_directory,"/FID/data_raw"),
                   documentation = paste0(selected_directory,"/FID/documentation"))



# fid_download
# fid_construct
# fid_import




