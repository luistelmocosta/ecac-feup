# ecac-feup
FEUP: Knowledge Extraction and Machine Learning - EIC0096 - 2017/2018

## Steps so far 

### Data cleaning

#### Step 1

* In R, develop a function that shows how many values are missing or N/A from every sheet. 
* Develop a function that calculates the client age based on the integer in the column birth_number. The initial date format was YYMMDD so we needed to parse it. We did a strsplit of the first two digits and added 1900 to match the YYYY pattern. With that, we created a new column "age" and deleted the old one (birth_number).
Using the same approach we did the same for the other dimensions

## TO DO 
* Remove the N/A (?) from the district sheet
* Find the best way to deal with missing data on transaction sheet

