# ecac-feup
FEUP: Knowledge Extraction and Machine Learning - EIC0096 - 2017/2018

## Steps so far 

### Data cleaning

#### Step 1 10/11/2017

* In **R**, develop a function that shows how many values are missing or **N/A** from every sheet. 
* Develop a function that calculates the client age based on the integer in the column birth_number. The initial date format was YYMMDD so we needed to parse it. We did a strsplit of the first two digits and added 1900 to match the YYYY pattern. With that, we created a new column "age" and deleted the old one (birth_number).
Using the same approach we did the same for the other dimensions

#### Step 2 11/11/2017
##### RapidMiner:
- district correlation - to see if there is any correlation between attributes. We could conclude that *districts with more inhabitants and ratio_urban have an higher average_salary.
- loan correlation - Loans amount is highly related with its duration. Higher the amount, longer duration. (as expected)


Did some improvements on data with R:
- Merged client with districts
- Merged with disposition (pipe between account and client)
- Merged Merged with account 
- Merged with a new table meansTemp that calculates the mean of the amount and balance of each account.
- Merged with Loan

##### Data-clean:
- converted columns *unemploymant.rate..95* and *no..of.commited.crimes..95* to numeric
- changed the name of the column **code**, relation *District* to **district_id** to be easier to join with client.
- NAs districts values changed to the median of all the other attributes values'.