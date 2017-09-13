# LA-Crime-Data-Analysis-using-R

### ABSTRACT
The Los Angeles Police Department (LAPD), officially known as the City of Los Angeles Police Department, is the law enforcement agency for the city of Los Angeles, California, United States. It has 4 major bureaus – Central, Valley, South and West Bureau and under these bureaus there are about 21 divisions all together. The analysis is based on the LAPD crime dataset from the years 2012 to 2015. The dataset focuses upon different categories of crimes committed at various location within LA city.

### DATASET 
#### The dataset url: 
•	https://data.lacity.org/A-Safe-City/LAPD-Crime-and-Collision-Raw-Data-for-2011/gaq4-bvj5
•	https://data.lacity.org/A-Safe-City/Crimes-2012-2015/s9rj-h3s6

For this project 2 LAPD crime datasets have been used. One dataset has records for the year 2011with about 236K records and the other dataset for 4 years from 2012 to 2015 with around 935K records. Both the dataset has 14 columns with each row containing a reported crime. It is one of the cleanest dataset that requires minimal effort in data cleaning. The column consist of the fields such as date.rptd- date on which crime was reported,  dr.no – the crime no, date and time occ -  date and time of occurrence, area no and area name, reporting district no , crime code, crime description, status, status description,  location , street 	and location1 – which is the latitude and longitude details.

The crime code is grouped into different crime categories ad further grouped into  includes all the Part I and Part II crimes. Part I Crimes are the eight "serious offenses" for which the FBI gathers national data including Homicide, Rape, Robbery, Aggravated Assaults, Burglary, Larceny, Vehicle Theft and Arson. Part II Crimes are "less serious" offenses and include: Simple Assaults, Forgery/Counterfeiting, Embezzlement/Fraud, Receiving Stolen Property, Weapon Violations, Prostitution, Sex Crimes, Crimes Against Family/Child, Narcotic Drug Laws, Liquor Laws, Drunkenness, Disturbing the Peace, Disorderly Conduct, Gambling, DUI and Moving Traffic Violations. For this analysis we have categorized the crime code as following based on the Crime Statistics Glossary available on LAPD online website: [Crime code Categorization](https://github.com/priyanka21sk/LA-Crime-Data-Analysis-using-Tableau/blob/master/Categorization%20of%20Crime%20code.pdf)

The status column gives us details on the crime status such as AA,AO,CC,IC,JO and JA. JO and JA are status updates for juvenile crime and it is this status in the dataset which helps us to distinguish between the crimes done by adults and juvenile. The location1 one has the latitude and longitude details of location of the crime. The reporting district no is a policing area defined by the Los Angeles Police Department.  In the LAPD's system it belongs to a specific Basic Car Area, which is a member of one of the Division and Bureau.

### DATA CLEANING

Data cleaning has been done using Rstudio. Please refer the [data cleaning documentation](https://github.com/priyanka21sk/LA-Crime-Data-Analysis-using-R/blob/master/Data_cleaning.pdf) and the data cleaning code [Rscript](https://github.com/priyanka21sk/LA-Crime-Data-Analysis-using-R/blob/master/Project_Rscript.R)

### DATA VISUALIZATION

The dataset has been analysed in such a manner that we get to know the total no of crimes committed in each year, under each bureau, the types of crimes committed and finally the status of these crimes that have been reported. These analysis helps us to understand how the LAPD have functioned over the years to create a safe environment for us. Please refer the [data visuzlization document](https://github.com/priyanka21sk/LA-Crime-Data-Analysis-using-R/blob/master/Visualizzation.pdf) and also the [Rscript](https://github.com/priyanka21sk/LA-Crime-Data-Analysis-using-R/blob/master/Project_Rscript.R)
