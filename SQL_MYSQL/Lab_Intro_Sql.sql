use sakila;

# exampel for getting all colums of a table
select * from inventory;

# select column title from table film
select title from film;

#Select one column from a table and alias it. 
select title as title_alias from film;

# Get unique list of film languages under the alias language. 
select distinct(name) as language from language;
select distinct(language_id) as language from film;

# Note that we are not asking you to obtain the language per each film, 
# but this is a good time to think about how you might get that information in the future.

# 5.1 Find out how many stores does the company have?
select count(distinct(store_id)) as No_of_Stores from store;

# 5.2 Find out how many employees staff does the company have?
select count(distinct(staff_id)) as No_of_employees from staff;

# 5.3 Return a list of employee first names only?
select 
	first_name 
as 
	first_name_employees 
from 
	staff;

describe sakila.actor;