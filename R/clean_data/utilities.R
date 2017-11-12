#---UTILS---#
#-- Print the stats of the data displaying NA and Empty values --#

printStats <- function(x, data){
  missNA<-sum(is.na(data[,x]))
  missVoid<-sum(data[,x] == "" & !is.na(data[,x])) #if data[,x] == "" -> returns NA
  cat(sprintf("\n---%s---\nNA count: %d --> %.2f%%\nEmpty count: %d --> %.2f%%\n",
              names(data)[x], missNA, 100*missNA/nrow(data), missVoid, 100*missVoid/nrow(data)))
  
  tempMatrix <- matrix(c(nrow(data)-missNA-missVoid, missNA, missVoid), nrow = 3, ncol = 1)
}


#-------ACCOUNT-------#
#---Get account age----#

get_account_age <- function(x, data, currentYear) {
  age_vector <- unlist(strsplit(data$date[x], ""))
  age_vector <- paste(age_vector[1:2], collapse = "")
  age <- currentYear-(as.numeric(age_vector)+1900)
}

#--Get client age----#

get_client_age <- function(x, data, currentYear) {
  age_vector <- unlist(strsplit(data$birth_number[x], ""))
  age_vector <- paste(age_vector[1:2], collapse = "")
  age <- currentYear - (as.numeric(age_vector)+1900)
  
  
}

#-------CLIENT-------#
#--Get client gender--#
get_client_gender <- function(x, data) {
  gender_vector <- unlist(strsplit(data$birth_number[x], ""))
  gender_vector <- paste(gender_vector[3:4], collapse = "")
  gender <- c(gender_vector)
  gender_vector <- paste(gender, collapse = "")
  gender_final <- if(gender_vector > 12) {"F"} else {"M"}
}

#--Create a Bar Plot --#

createPlot <- function(name, legendPlaceX, legendPlaceY){
  #make histogram
  colours <- c("red", "yellow", "blue")
  bplot <- barplot(stats, main=name, ylab = "Count", 
                   beside=TRUE, col=colours, las = 3,font.lab = 1, cex.lab = 0.8, cex.names = 0.7, bty='L')
  par(xpd=TRUE)
  legend(legendPlaceX, legendPlaceY, c("Value","NA","Empty"), bty="n", fill=colours,  cex = 0.6)
}