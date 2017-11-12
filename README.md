### FEUP: Knowledge Extraction and Machine Learning - EIC0096 - 2017/2018

# Task description
The bank wants to improve their services. For instance, the bank managers have only vague idea, who is a good client (whom to offer some additional services) and who is a bad client (whom to watch carefully to minimize the bank loses). Fortunately, the bank stores data about their clients, the accounts (transactions within several months), the loans already granted, the credit cards issued. The bank managers hope to improve their understanding of customers and seek specific actions to improve services. A mere application of a discovery tool will not be convincing for them.  

To test a data mining approach to help the bank managers, it was decided to address two problems, a descriptive and a predictive one. While the descriptive problem was left open, the predictive problem is the prediction of whether a loan will end successfuly.

## Data description

<img src= "https://github.com/luistelmocosta/ecac-feup/blob/master/img/data.gif"/>

The data about the clients and their accounts consist of following relations:

- relation **account** (4500 objects - each record describes static characteristics of an account,
- relation **client** (5369 objects) - each record describes characteristics of a client,
- relation **disposition** (5369 objects) - each record relates together a client with an account i.e. this relation describes the rights of **clients** to operate accounts,
- relation **permanent** order (6471 objects) - each record describes characteristics of a payment order,
- relation **transaction** (1056320 objects) - each record describes one transaction on an account,
- relation **loan** (682 objects) - each record describes a loan granted for a given account,
- relation **credit card** (892 objects) - each record describes a credit card issued to an account,
- relation **demographic data** (77 objects) - each record describes demographic characteristics of a district.

Each account has both static characteristics (e.g. date of creation, address of the branch) given in relation "account" and dynamic characteristics (e.g. payments debited or credited, balances) given in relations "permanent order" and "transaction". Relation "client" describes characteristics of persons who can manipulate with the accounts. One client can have more accounts, more clients can manipulate with single account; clients and accounts are related together in relation "disposition". Relations "loan" and "credit card" describe some services which the bank offers to its clients; more credit cards can be issued to an account, at most one loan can be granted for an account. Relation "demographic data" gives some publicly available information about the districts (e.g. the unemployment rate); additional information about the clients can be deduced from this.

<img src= "https://github.com/luistelmocosta/ecac-feup/blob/master/img/relations1.png"/>
<img src= "https://github.com/luistelmocosta/ecac-feup/blob/master/img/Relations2.png"/>
<img src= "https://github.com/luistelmocosta/ecac-feup/blob/master/img/Relations3.png"/>

# Steps so far 


## Step 1 10/11/2017

* In **R**, develop a function that shows how many values are missing or **N/A** from every sheet. 
* Develop a function that calculates the client age based on the integer in the column birth_number. The initial date format was YYMMDD so we needed to parse it. We did a strsplit of the first two digits and added 1900 to match the YYYY pattern. With that, we created a new column "age" and deleted the old one (birth_number).
Using the same approach we did the same for the other dimensions

## Step 2 11/11/2017
### RapidMiner:
- **district correlation** - to see if there is any correlation between attributes. We could conclude that *districts* with more *inhabitants* and *ratio_urban* have an higher *average_salary*.
- **loan correlation** - Loans amount is highly related with its *duration*. Higher the *amount*, longer *duration*. (as expected)


Did some improvements on data with R:
- Merged client with **districts**
- Merged with **disposition** (pipe between account and client)
- Merged with **account** 
- Merged with a new table *meansTemp* that calculates the mean of the amount and balance of each account.
- Merged with **Loan**

### Data-clean:
- converted columns *unemploymant.rate..95* and *no..of.commited.crimes..95* to numeric
- changed the name of the column *code*, relation **District** to *district_id* to be easier to join with client.
- NAs districts values changed to the median of all the other attributes values'.

