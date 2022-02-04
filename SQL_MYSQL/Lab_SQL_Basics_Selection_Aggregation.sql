use bank;

# Get the id values of the first 5 clients from district_id with a value equals to 1.
select 
	client_id, district_id
from 
	bank.client 
where 
	district_id = 1
limit 
	5;

# In the client table, get an id value of the last client where the district_id equals to 72.
# 13576

select 
	max(client_id)
from 
	bank.client
where
	district_id = 72;
    
## Get the 3 lowest amounts in the loan table.
select
	amount
as 
	loan_amount
from
	bank.loan
order by
	loan_amount asc
limit
	3;
    
## What are the possible values for status, ordered alphabetically in ascending order in the loan table?
select distinct 
    status
as
	possible_values_status
from 
	bank.loan
order by
	possible_values_status;

## What is the loan_id of the highest payment received in the loan table?
select
	loan_id, payments
from 
	bank.loan
order by
	payments 
    desc
limit
	1;
    
## sol 2:
select
	loan_id, max(payments)
from
	bank.loan
where
	payments = (Select max(payments) from bank.loan);

## sol 3
select 
	loan_id,max(payments) 
as 
	max_p 
from 
	bank.loan 
group by 
	loan_id 
order by 
	max_p 
desc limit 
	1;

    
## What is the loan amount of the lowest 5 account_ids in the loan table? Show the account_id and the corresponding amount
select
	account_id, amount
from 
	bank.loan
order by
	account_id 
    asc
limit
	5;

## What are the account_ids with the lowest loan amount that have a loan duration of 60 in the loan table?
select
	account_id, amount, duration
from 
	bank.loan
where
	duration = 60
order by
	amount 
    asc;
    
## What are the unique values of k_symbol in the order table?
## Note: There shouldn't be a table name order, since order is reserved from the ORDER BY clause. You have to use backticks to escape the order table name.
select distinct
	k_symbol
from 
	bank.order
where
	k_symbol <> ""
order by
	k_symbol;

## In the order table, what are the order_ids of the client with the account_id 34?
select
	order_id, account_id
from 
	bank.order
where
	account_id =34
;

## In the order table, which account_ids were responsible for orders between order_id 29540 and order_id 29560 (inclusive)?
select distinct
	account_id
from
	bank.order
where 
	order_id
		between
			29540 and
            29560
;

## In the order table, what are the individual amounts that were sent to (account_to) id 30067122?
select
	amount
from 
	bank.order
where
	account_to = 30067122
;


## Query 12 - In the trans table, show the trans_id, date, type and amount of the 10 first transactions from account_id 793 in chronological order, from newest to oldest.
select
	trans_id, date, type, amount
from 
	bank.trans
where
	account_id = 793
order by
	date
    desc
limit
	10
;

## Query 13 - In the client table, of all districts with a district_id lower than 10, how many clients are from each district_id? Show the results sorted by the district_id in ascending order.
select
	district_id, count(client_id)
from
	bank.client
where
	district_id < 10
group by
	district_id
order by
	district_id
    asc
;

## In the card table, how many cards exist for each type? Rank the result starting with the most frequent type.
select
	type, count(card_id)
from
	bank.card
group by
	type
order by
	count(card_id)
    desc
;

## Query 15 Using the loan table, print the top 10 account_ids based on the sum of all of their loan amounts.
select
	account_id, sum(amount)
from 
	bank.loan
group by
	account_id
order by
	sum(amount)
    desc
limit
	10
;

## Query 17 In the loan table, for each day in December 1997, count the number of loans issued for each unique loan duration, 
# ordered by date and duration, both in ascending order. You can ignore days without any loans in your output.
select distinct
	date, 
    duration,
    count(duration)
from 
	bank.loan
where
	date 
    between
		971200
        and 
        971231
group by
	date, duration
order by
	date and duration
;

## Query 18
select
	account_id, type, sum(amount) as total_amount
from
	bank.trans
where
	account_id = 396
group by
	account_id, type
;

## Query 19
select
	account_id, 
    type as transaction_type, 
    floor(sum(amount)) as total_amount
from
	bank.trans
where
	account_id = 396
group by
	account_id, type
;