#---ACCOUNT DATA CLEAN---#

#---Get the age from the column "date" in account.csv---#
account[,"date"] <- sapply(account[,"date"],as.character)
account["account_age"] <- sapply(1:nrow(account), get_account_age, data =account, currentYear = as.integer(format(Sys.Date(), "%Y")))
account <- subset(account, select = -date)

write.csv(account, "modified/accounts.csv")

#---account missing values (plot)--#
stats<-sapply(1:length(account), printStats, data = account)
colnames(stats) <- names(account)
createPlot("Account Missing Values", legendPlaceX = "topright")

#---CLIENT DATA CLEAN---#

#--Get the age from the column "birth_number" in client.csv--#
client[,"birth_number"] <- sapply(client[, "birth_number"], as.character)
client["client_age"] <- sapply(1:nrow(client), get_client_age, data = client, currentYear = 2017)
client ["gender"] <- sapply(1:nrow(client), get_client_gender, data=client)
#--client missing values (plot)--#
stats<-sapply(1:length(client), printStats, data = client)
colnames(stats) <- names(client)
createPlot("Client Missing Values", legendPlaceX = "topright")

#write.csv(client, "modified/clients.csv")

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


#--change missing/unknown values (?) to NA--#
cat("\n Clean up the missing values \n")
question_size<-length(district[district == "?"])
cat(sprintf("\n Missing Values (marked with ?) : %d", question_size)) #missing values == 2

district[district == "?"] <- NA

#--district missing values(plot)--#
stats<-sapply(1:length(district), printStats, data = district)
colnames(stats) <- names(district)
createPlot("District Missing Values", legendPlaceX = "topright")

#--change values to numeric due to error "need numeric data"--#

district[,c("unemploymant.rate..95","no..of.commited.crimes..95")] <- 
  sapply(district[,c("unemploymant.rate..95","no..of.commited.crimes..95")],as.numeric)

#--changing column name "code" to "district_id" for an easier join--#
colnames(district)[1] <- "district_id"

#--fill missing district ids with median of the others--#

cat("\n Filling District NAs with median...\n")
district$unemploymant.rate..95[is.na(district$unemploymant.rate..95)] <- median(district$unemploymant.rate..95, na.rm = TRUE)
district$no..of.commited.crimes..95[is.na(district$no..of.commited.crimes..95)] <- median(district$no..of.commited.crimes..95, na.rm = TRUE)

write.csv(district, "modified/districts.csv")

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


write.csv(loan, "modified/loans.csv")
write.csv(credit_card, "modified/cards.csv")
write.csv(disposition, "modified/disps.csv")
write.csv(loan, "modified/loans.csv")
write.csv(transactions, "modified/transactions.csv")




#---MERGES---#

#merge with disposition
temp <- merge(client, disposition, by = "client_id")

#merge account
temp <- merge(temp, account, by = "account_id", all.x = TRUE)
# Remove non owners
temp <- temp[!temp$type=="DISPONENT",] 
# Remove column
temp <- subset(temp, select = -type) 


#--merge with loan--#
temp <- merge(temp, loan, by = "account_id", all.x = TRUE)
temp <- subset(temp, select = -loan_id)
temp <- subset(temp, select = -c(district_id, disp_id))

meansTemp <- subset(transactions, select = c(account_id, amount, balance))
means <- aggregate(.~account_id, data=meansTemp, mean)
colnames(means)[2] <- "Avg_amount"
colnames(means)[3] <- "Avg_balance"
temp <- merge(temp, means, by = "account_id", all.x = TRUE)

auxTemp <- subset(transactions, select = c(account_id, balance))
min_final <- aggregate(.~account_id, data=auxTemp, min)
colnames(min_final)[2] <- "Min_Balance"
temp <- merge(temp, min_final, by = "account_id", all.x = TRUE)

maxTemp <- subset(transactions, select =  c(account_id, balance))
max_final <- aggregate(.~account_id, data=maxTemp, max)
colnames(max_final)[2] <- "Max_Balance"
temp <- merge(temp, max_final, by = "account_id", all.x = TRUE)

avgExpensesTemp <- subset(transactions, select = c(account_id, amount, type))
avgExpensesTemp <- avgExpensesTemp[!avgExpensesTemp$type=="credit",]
avgExpenses <- aggregate(.~account_id, data=avgExpensesTemp, mean)
colnames(avgExpenses)[2] <- "Average Expenses (Withrawals)"
temp <- merge(temp, avgExpenses, by = "account_id", all.x = TRUE)
temp <- subset(temp, select = -type) 

avgIncomesTemp <- subset(transactions, select = c(account_id, amount, type))
avgIncomesTemp <- avgIncomesTemp[avgIncomesTemp$type=="credit",]
avgIncomes <- aggregate(.~account_id, data=avgIncomesTemp, mean)
colnames(avgIncomes)[2] <- "Average Income (Credit)"
temp <- merge(temp, avgIncomes, by = "account_id", all.x = TRUE)
temp <- subset(temp, select = -type) 

#-- Calculate total withrawals --#
totalExpensesTemp <- subset(transactions, select = c(account_id, amount, type))
totalExpensesTemp <- totalExpensesTemp[!totalExpensesTemp$type=="credit",]
totalExpenses <- aggregate(.~account_id, data= totalExpensesTemp, sum)
colnames(totalExpenses)[2] <- "Total Withrawals"
temp <- merge(temp, totalExpenses, by = "account_id", all.x = TRUE)
temp <- subset(temp, select = -type) 

#-- Calculate total withrawals --#
totalIncomeTemp <- subset(transactions, select = c(account_id, amount, type))
totalIncomeTemp <- totalExpensesTemp[totalIncomeTemp$type=="credit",]
totalIncomes <- aggregate(.~account_id, data= totalIncomeTemp, sum)
colnames(totalIncomes)[2] <- "Total Income"
temp <- merge(temp, totalIncomes, by = "account_id", all.x = TRUE)
temp <- subset(temp, select = -type) 
temp <- subset(temp, select = -payments) 
temp <- subset(temp, select = -duration) 
temp <- subset(temp, select = -amount) 
temp <- subset(temp, select = -date) 

#-- Calculate number of loans --#
totalLoansTemp <- subset(loan, select = c(account_id, status))
totalLoansTemp <- totalLoansTemp[totalLoansTemp$status==1,]
totalLoans <- aggregate(.~account_id, data= totalLoansTemp, sum)

#--remove NA values--#

final <- na.omit(temp)
write.csv(final, "clean1.csv")


#final print
stats<-sapply(1:length(final), printStats, data = final)
colnames(stats) <- names(final)
createPlot("FinalMissing Values", legendPlaceX = "topright", legendPlaceY = 4500)