


fid_metadata <- function() {
  
  
  bad.names.2017 <- c( "cepi_32_fid_balance_sheet_datav2.xlsx",
                       "cepi_33_fid_revenue_datav2.xlsx",
                       "cepi_34_fid_expenditures_datav2.xlsx",
                       "cepi_35_fid_esp_data_v2.xlsx")
  
  # creating meta data from names
  fid_file_metadata <- 
    list.files(path = paste0(selected_directory,"/FID/data_raw"), full.names = TRUE) %>% 
    filter_only_files("xlsx", "dbf", "DBF") %>% 
    tibble() %>% 
    rename(file.path = ".") %>% 
    
    # section to check if the system is categorizing correctly 
    mutate(file.name = str_to_lower(basename(file.path)),
           # flag.bal.num = str_detect(string.lower, "_32_"),
           flag.bal.txt = str_detect(file.name, "bal"),
           
           # flag.rev.num = str_detect(string.lower, "_33_"),
           flag.rev.txt = str_detect(file.name, "rev"),
           
           # flag.exp.num = str_detect(string.lower, "_34_"),
           flag.exp.txt = str_detect(file.name, "exp"),
           
           # flag.esp.num = str_detect(string.lower, "_35_"),
           flag.esp.txt = str_detect(file.name, "esp"),
           
           flag.problem.data.type = ifelse(flag.bal.txt + flag.rev.txt + flag.exp.txt + flag.esp.txt != 1, 1, 0)) %>% 
    
    mutate(type = ifelse(flag.bal.txt == TRUE, "bal", NA),
           type = ifelse(flag.rev.txt == TRUE, "rev", type),
           type = ifelse(flag.exp.txt == TRUE, "exp", type),
           type = ifelse(flag.esp.txt == TRUE, "esp", type),
           type = ifelse(file.name == "bs2009.dbf", "bal", type)) %>% 
    
    mutate( FY = stringr::str_extract_all(file.name, "[[:digit:]]{4}" ),
            FY = as.numeric(FY),
            looking.for.year = str_remove_all(file.name, "32"),
            looking.for.year = str_remove_all(looking.for.year, "33"),
            looking.for.year = str_remove_all(looking.for.year, "34"),
            
            looking.for.year = str_remove_all(looking.for.year, "35"),
            
            FY = ifelse(is.na(FY), stringr::str_extract_all(looking.for.year, "[[:digit:]]{2}" ), FY),
            FY = ifelse(FY < 100, as.numeric(paste0("20", as.character(FY))), FY  ),
            FY = as.numeric(FY),
            FY = ifelse(file.name %in% bad.names.2017, 2017, FY),
            
            flag.problem.year = ifelse(FY > 2003 & FY < 2099, 0, 1)) %>% 
    mutate(file.ext = str_extract(file.name, "[^.]*$")) %>% 
    
    select(file.path, file.name, file.ext, type, FY) %>% 
    group_by(FY, type) %>% 
    mutate(n = n(),
      file.id = paste0("FID_",type,"_",FY,"_",n,"_",file.name))
  
  return(fid_file_metadata)
  
}



