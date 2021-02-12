use CCCC;

drop table if exists creditcardmarketing;
drop table if exists credit_card_data;
CREATE TABLE `credit_card_data` (
  `customer_id` smallint(5) NOT NULL,
  `offer_accepted` enum('Yes','No'),
  `reward` enum('Air Miles', 'Cash Back', 'Points'),
  `mailer_type` enum('Letter', 'Postcard'),
  `income_level` enum('Medium', 'High', 'Low'),
  `n_bank_accounts_open` smallint(5) unsigned DEFAULT NULL,
  `overdraft_protection` enum('Yes','No'),
  `credit_rating` enum('Medium', 'High', 'Low'),
  `n_credit_cards_held` smallint(5) unsigned DEFAULT NULL,
  `n_homes_owned` smallint(5) unsigned DEFAULT NULL,
  `household_size` smallint(5) unsigned DEFAULT NULL,
  `own_your_home` enum('Yes','No'),
  `average_balance` numeric(10,2),
  `q1_balance` numeric(10,2),
  `q2_balance` numeric(10,2),
  `q3_balance` numeric(10,2),
  `q4_balance` numeric(10,2),
  PRIMARY KEY (`customer_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

SELECT*FROM CCCC.credit_card_data;

show variables like 'local_infile';
set global local_infile=1;
set global local_infile=true;

load data local infile'/Users/carolinvogt/Becoming_Data_Analyst/Week_05/CCCC/creditcardmarketing.csv' -- provide the complete path of the file
into table credit_card_data
fields terminated BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
(customer_id,offer_accepted,reward,mailer_type,income_level,n_bank_accounts_open,overdraft_protection,credit_rating,n_credit_cards_held,n_homes_owned,household_size,own_your_home,average_balance,q1_balance,q2_balance,q3_balance,q4_balance);

SELECT*FROM CCCC.credit_card_data
WHERE average_balance in (" ","",0);

SELECT*FROM CCCC.credit_card_data
WHERE customer_id = 1001;

SELECT*FROM CCCC.credit_card_data;

-- 5. --
alter table CCCC.credit_card_data
drop column q4_balance;
SELECT*FROM CCCC.credit_card_data
Limit 10;

-- 6. --
SELECT count(customer_id) as n_rows FROM CCCC.credit_card_data; #18000, but customer_id 1=0 (compared to csv)

-- 7. --
Select count(distinct offer_accepted) as n_offer_accepted,
			count(distinct reward) as n_reward,
			count(distinct mailer_type) as n_mailer_type,
            count(distinct n_credit_cards_held) as n_credit_cards_held,
            count(distinct household_size) as n_household_size
            from CCCC.credit_card_data;

Select distinct offer_accepted as n_offer_accepted
            from CCCC.credit_card_data
            order by n_offer_accepted asc;
            
Select distinct reward as n_reward
            from CCCC.credit_card_data
            order by n_reward asc;
            
Select distinct mailer_type as n_mailer_type
            from CCCC.credit_card_data
            order by n_mailer_type asc;

Select distinct n_credit_cards_held as n_credit_cards_held
            from CCCC.credit_card_data
            order by n_credit_cards_held asc;
            
Select distinct household_size as n_household_size
            from CCCC.credit_card_data
            order by n_household_size asc;

-- 8. --
Select customer_id, average_balance from CCCC.credit_card_data
order by average_balance desc
limit 10;

-- 9. --
Select avg(average_balance) as total_avg from CCCC.credit_card_data;

-- 10. --
Select income_level, avg(average_balance) as avg_balance_per_income from CCCC.credit_card_data
group by income_level;

Select n_bank_accounts_open, avg(average_balance) as avg_balance_per_income from CCCC.credit_card_data
group by n_bank_accounts_open;

Select n_bank_accounts_open, avg(average_balance) as avg_balance_per_accounts_open from CCCC.credit_card_data
group by n_bank_accounts_open;

Select credit_rating, round(avg(n_credit_cards_held),2) as avg_n_credit_cards_per_rating, count(customer_id) as n_customer from CCCC.credit_card_data
group by credit_rating;

Select n_bank_accounts_open, round(avg(n_credit_cards_held),2) as avg_n_credit_cards_per_bank_account, count(customer_id) as n_customer from CCCC.credit_card_data
group by n_bank_accounts_open;

#additional
Select credit_rating, n_bank_accounts_open, round(avg(n_credit_cards_held),2) as avg_n_credit_cards_per_bank_account, count(customer_id) as n_customer from CCCC.credit_card_data
group by credit_rating, n_bank_accounts_open;

-- 11. --
Select customer_id, credit_rating, n_credit_cards_held, n_homes_owned, household_size from CCCC.credit_card_data
where credit_rating in ("Medium","High") AND n_credit_cards_held in (1,2) AND n_homes_owned>0 AND household_size>2;
#7669 rows returned

-- 12. --
Select round(avg(average_balance),2) from CCCC.credit_card_data; #939.26
Select customer_id, average_balance from CCCC.credit_card_data
Where average_balance < (
Select avg(average_balance) from CCCC.credit_card_data);

-- 13. --

create view Customers__Balance_View1 as
Select customer_id, average_balance from CCCC.credit_card_data
Where average_balance < (
Select avg(average_balance) from CCCC.credit_card_data);

-- 14. --
Select count(customer_id) as n_customer, offer_accepted from CCCC.credit_card_data
group by offer_accepted;
# no:16977, yes:1023

-- 15. --
Select credit_rating, count(customer_id) as n_customer, avg(average_balance) as avg_balance_per_rating from CCCC.credit_card_data
group by credit_rating;

Select credit_rating, avg(average_balance) as avg_balance from CCCC.credit_card_data
group by credit_rating;

drop view if exists avg_balance_ViewHigh;
create view avg_balance_ViewHigh as
Select credit_rating, avg(average_balance) as avg_balance_high from CCCC.credit_card_data
where credit_rating = "High"
group by credit_rating;

drop view if exists avg_balance_ViewLow;
create view avg_balance_ViewLow as
Select credit_rating, avg(average_balance) as avg_balance_low from CCCC.credit_card_data
where credit_rating = "Low"
group by credit_rating;

select*from avg_balance_ViewLow;
select*from avg_balance_ViewHigh;

#with cte 
with high as (
	select round(avg(average_balance),2) as AvgHigh
	from credit_card_data
	where credit_rating = 'High'
),
low as (
	select round(avg(average_balance),2) as AvgLow
	from credit_card_data
	where credit_rating = 'Low'
)
select a.AvgHigh, (select AvgLow from low) as AvgLow, (a.AvgHigh - (select AvgLow from low)) as Difference
from high as a;

-- 16. --
 Select count(customer_id), mailer_type from CCCC.credit_card_data
 group by mailer_type;
 
 -- 17. --
 Select * from (
 Select *, rank() over(order by q1_balance asc) as rank_customer from CCCC.credit_card_data as sub1 
 where q1_balance >0) as sub1
 where rank_customer=11;
 
Select * from (
Select *, rank() over(order by q1_balance asc) as rank_customer from CCCC.credit_card_data as sub1 
 where q1_balance >0) as sub1
 where rank_customer=11
 Limit 1;
 
 Select *, rank() over(order by q1_balance asc) as rank_customer from CCCC.credit_card_data as sub1 
 where q1_balance >0; #0 was nans


