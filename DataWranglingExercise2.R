library(dplyr)
#library(tidyr)
titanic_original <- read.csv(file="titanic_original.csv", header=TRUE, sep=",")
#print(titanic_original)

my_function <- function(x) {
#  if(nchar(toString(x)) == 0)
   if(toString(x) == "")
#  if(is.na(x))
    return("S")
  else
    return(toString(x))
}

my_function1 <- function(x, m = mean(titanic_original$age, na.rm = TRUE)) {
  if(is.na(x))
    return(m)
  else
    return(x)
}
print(mean(titanic_original$age, na.rm = TRUE))
#sapply(refine_original$company, my_function)
#m == mean(titanic_original$age)
titanic_clean <- 
(titanic_original %>%
      mutate(embarked = sapply(embarked, my_function)) %>%
      mutate(age = sapply(age, my_function1)))

write.csv(titanic_clean, file = "titanic_clean.csv",row.names=FALSE, na="")