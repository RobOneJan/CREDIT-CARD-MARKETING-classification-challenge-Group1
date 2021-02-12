# CREDIT-CARD-MARKETING-classification-challenge-Group1
Increasing the offer acceptance rate for credit cards within our marketing campaign. In the future, not every customer will receive offers.
A general description of the project:

In the project "Marketing campaign for Bank Customers", the aim is to analyse customer data and find out which customers are most likely to accept an offer for a credit card. The marketing campaign is carried out by mail and various data are available on the customers and their financial and family situation.

The data set consists of information on 18,000 current bank customers in the study. These are the definitions of data points provided:

Customer Number: A sequential number assigned to the customers (this column is hidden and excluded – this unique identifier will not be used directly).
Offer Accepted: Did the customer accept (Yes) or reject (No) the offer. Reward: The type of reward program offered for the card.
Mailer Type: Letter or postcard.
Income Level: Low, Medium, or High.
Bank Accounts Open: How many non-credit-card accounts are held by the customer.
Overdraft Protection: Does the customer have overdraft protection on their checking account(s) (Yes or No).
Credit Rating: Low, Medium, or High.
Credit Cards Held: The number of credit cards held at the bank.
Homes Owned: The number of homes owned by the customer.
Household Size: The number of individuals in the family.
Own Your Home: Does the customer own their home? (Yes or No).
Average Balance: Average account balance (across all accounts over time). Q1, Q2, Q3, and Q4
Balance: The average balance for each quarter in the last year

Project status :
The project was completed on the basis of the existing data and recommendations for action could be derived. 
However, a closer examination with the help of a further data set could extend the model.

In the process we could figure out that there are features which are more important for predicting than others.
These are :

- Income Level
- Nr credit cards held
- Mailing Type postcard
- Average balance
- credit rating
- houshold size 

In the end we only worked with these columns and dropped the other features in order to not overfit our Modell.

We identified the customer which is most likely to accept an credit card offer as:
1-Medium average balance
2-Low credit rating and income level
3-Offer addressed by postcards


Technical requirements :
The project was written mainly in Python 3.7 in the development environment "Jupiter Notebook".
Further analysis was done with the help of MySQL Workbench and SQL.
For the visualisation Tableau was used to visualise the work results.

Libraries which were used in python:
-numpy
-pandas
-sklearn
-seaborn


How to start:
To study the project you should first open the Jupiter Notebook, here you will find the main part of the project in the form of a Python script. To see the results it is recommended to open the PowerPoint presentation.



Known problems 
- The data is very unbalanced. This makes a valid evaluation difficult. The kappa of the models achieved in our model does not match the result we wanted. We attribute these problems primarily to the unbalanced dataset . However, there is also the possibility that the data does not allow correct modelling due to missing direct correlations. It could be a purely human psychological aspect that is difficult to predict.



What can be done to help?
We would be very grateful for any suggestions for improvement and further possibilities to generate more knowledge from the data and are always ready to help. 
