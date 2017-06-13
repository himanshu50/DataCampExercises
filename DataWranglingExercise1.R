library(dplyr)
library(tidyr)
refine_original <- read.csv(file="refine_original.csv", header=TRUE, sep=",")
#print(refine_original)

substrRight <- function(x, n){
  substr(x, nchar(x)-n+1, nchar(x))
}
# print(substrRight(toString(refine_original$company), 2))
# print(substrRight(toString(refine_original$company), 2))

my_function <- function(x) {
  print(substrRight(toString(x), 2))
  if(endsWith(toString(x), "ps"))
    return("philips")
  else if(endsWith(toString(x), "pS"))
    return("philips")
  else if(endsWith(toString(x), "o"))
    return("akzo")
  else if(endsWith(toString(x), "O"))
    return("akzo")
  else if(endsWith(toString(x), "0"))
    return("akzo")
  else if(endsWith(toString(x), "er"))
    return("unilever")
  else if(endsWith(toString(x), "en"))
    return("van houten")
  else
    return(toString(x))
}

my_function1 <- function(x) {
  print(toString(x))
  if(toString(x) == "p")
    return("Smartphone")
  else if(toString(x)== "v")
    return("TV")
  else if(toString(x)== "x")
    return("Laptop")
  else if(toString(x)== "q")
    return("Tablet")
  else
    return(toString(x))
}
#sapply(refine_original$company, my_function)

refine_new <- 
(refine_original %>%
  select(company:name) %>%
    mutate(company_new = sapply(refine_original$company, my_function)) %>%
      separate(Product.code...number, c("Product_Code", "Product_Number"), "-") %>%
      mutate(Product_Category = sapply(Product_Code, my_function1)) %>%
      mutate(full_address = paste(address, city, country, sep=",")) %>%
      mutate(company_philips = as.numeric(company_new == "philips"), company_akzo = as.numeric(company_new == "akzo"), company_van_houten = as.numeric(company_new == "van houten"), company_unilever = as.numeric(company_new == "unilever")) %>%
      mutate(product_smartphone = as.numeric(Product_Category == "Smartphone"), product_tv = as.numeric(Product_Category == "TV"), product_laptop = as.numeric(Product_Category == "Laptop"), product_tablet = as.numeric(Product_Category == "Tablet")))
refine_final <- refine_new[-1]
write.csv(refine_final, file = "refine_final.csv",row.names=FALSE, na="")

#print(refine_new)
#print(refine_final)