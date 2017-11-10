#---ACCOUNT DATA CLEAN---#

#---Get the age from the column "date" in account.csv---#
account[,"date"] <- sapply(account[,"date"],as.character)
account["account_age"] <- sapply(1:nrow(account), get_account_age, data =account, currentYear = as.integer(format(Sys.Date(), "%Y")))


#---account missing values (plot)--#
stats<-sapply(1:length(account), printStats, data = account)
colnames(stats) <- names(account)
createPlot("Account Missing Values", legendPlaceX = "topright")

#---CLIENT DATA CLEAN---#

#--Get the age from the column "birth_number" in client.csv--#
client[,"birth_number"] <- sapply(client[, "birth_number"], as.character)
client["client_age"] <- sapply(1:nrow(client), get_client_age, data = client, currentYear = 2017)

#--client missing values (plot)--#
stats<-sapply(1:length(client), printStats, data = client)
colnames(stats) <- names(client)
createPlot("Client Missing Values", legendPlaceX = "topright")

#---DISPOSITION DATA CLEAN---#

#--disposition missing values(plot)--#
stats<-sapply(1:length(client), printStats, data = disposition)
colnames(stats) <- names(disposition)
createPlot("Disposition Missing Values", legendPlaceX = "topright")

#---CREDIT CARD DATA CLEAN ---#

#--credit card missing values(plot)--#
stats<-sapply(1:length(credit_card), printStats, data = credit_card)
colnames(stats) <- names(credit_card)
createPlot("Credit Card Missing Values", legendPlaceX = "topright")

#---DISTRICT DATA CLEAN---#
#--district missing values(plot)--#
stats<-sapply(1:length(district), printStats, data = district)
colnames(stats) <- names(district)
createPlot("District Missing Values", legendPlaceX = "topright")

#--change missing/unknown values (?) to NA--#
cat("\n Clean up the missing values \n")
question_size<-length(district[district == "?"])
cat(sprintf("n Missing Values : %d", question_size)) #missing values == 2




#---LOAN DATA CLEAN---#
#--loan missing values(plot)--#
stats<-sapply(1:length(loan), printStats, data = loan)
colnames(stats) <- names(loan)
createPlot("Loan Missing Values", legendPlaceX = "topright")

#---TRANSACTIONS DATA CLEAN---#
#--transactions missing values(plot)--#
stats<-sapply(1:length(transactions), printStats, data = transactions)
colnames(stats) <- names(transactions)
createPlot("Transactions Missing Values", legendPlaceX = "topright")