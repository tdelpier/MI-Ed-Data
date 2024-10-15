


rename_variables <- 
  c(FY = "fiscal.year", 
    dcode = "district.code",
    fund = "fund.code",
    func = "function.code",
    object = "object.code",
    grant = "grant.code")



x3 <- x1 %>% 
  janitor::clean_names(sep_out = ".") %>% 
  rename(any_of(rename_variables)) %>% 
  mutate(dnum = as.numeric(dcode)) %>% 
  select(FY, dnum, fund, func, object, grant, amount)


z1 <- TannersTools::tt_import_fid_E()