
# library(devtools)
# library(TannersTools)

if (!require('tidyverse')) install.packages('tidyverse'); library('tidyverse')
if (!require('devtools')) install.packages('devtools'); library('devtools')
if (!require('remotes')) install.packages('remotes'); library('remotes')
remotes::install_github(repo = "tdelpier/MI-Ed-Data", options(download.file.method = "wininet"))
devtools::install_github("tdelpier/MI-Ed-Data", options(download.file.method = "libcurl"))

library(MIEdData)

# load_all()



selected_directory <- rstudioapi::selectDirectory()

fid_rev_construct_from_scratch()

fidr <- fid_rev_import()









# 
# 
# 
# ## download FID files
# fid_urls <- fid_urls()  # just using a couple files for speed
# download_files(urls = fid_urls, path = paste0(selected_directory,"/FID/data_downloads"))
# 
# 
# 
# ## unzipping from download
# unzip_files(data_downloads = paste0(selected_directory, "/FID/data_downloads"),
#             data_raw = paste0(selected_directory,"/FID/data_raw"))
# 
# 
# copy_datafiles(data_downloads = paste0(selected_directory, "/FID/data_downloads"),
#                data_raw = paste0(selected_directory,"/FID/data_raw"))
# 
# 
# move_documentation(data_raw = paste0(selected_directory,"/FID/data_raw"),
#                    documentation = paste0(selected_directory,"/FID/documentation"))
# 
# 
# 
# # construct 
# 
# fid_rev_construct()
# 
# 
# # import FID revenue
# 
# 
# # fid_download
# # fid_construct
# # fid_import
# 



