source('~/ecac-feup/R/clean_data/lib.R')

#Load data
cat("Loading files...\n")

account <- read.csv("~/Documents/FEUP/ECAC/ecac-feup/data/ficheiros_competicao/account.csv", sep=";")
cat("account done\n")
client <- read.csv("~/Documents/FEUP/ECAC/ecac-feup/data/ficheiros_competicao/client.csv", sep=";")
cat("client done\n")
disposition <- read.csv("~/Documents/FEUP/ECAC/ecac-feup/data/ficheiros_competicao/disp.csv", sep=";")
cat("disposition done\n")
credit_card <- read.csv("~/Documents/FEUP/ECAC/ecac-feup/data/ficheiros_competicao/card_train.csv", sep=";")
cat("credit_card done\n")
loan <- read.csv("~/Documents/FEUP/ECAC/ecac-feup/data/ficheiros_competicao/loan_train.csv", sep=";")
cat("loan done\n")
district <- read.csv("~/Documents/FEUP/ECAC/ecac-feup/data/ficheiros_competicao/district.csv", sep=";")
cat("district done\n")
transactions <- read.csv("~/Documents/FEUP/ECAC/ecac-feup/data/ficheiros_competicao/trans_train.csv", sep=";")
cat("transactions done\n")



summary(account)
describe(account)
str(account)

summary(client)
describe(client)
str(client)

summary(disposition)
describe(disposition)
str(disposition)

summary(credit_card)
describe(credit_card)
str(credit_card)

summary(loan)
describe(loan)
str(loan)

summary(credit_card)
describe(credit_card)
str(credit_card)

summary(district) #tem valores com "?"
describe(district)
str(district)

summary(transactions)
describe(transactions)

