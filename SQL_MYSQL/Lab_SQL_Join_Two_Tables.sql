## Lab | SQL Queries - Join Two Tables

#	 Which actor has appeared in the most films?
select 
	#a.actor_id, a.first_name, a.last_name, count(*) 
    actor_id, 
    first_name, 
    last_name, 
    count(*) 
		as 
			n_films 
from 
	sakila.actor
inner join
	sakila.film_actor
using(actor_id)
group by 
	actor_id
order by
	n_films
    desc
limit
3
;

#	 Most active customer (the customer that has rented the most number of films)
select 
	customer_id,
    first_name,
    last_name,
    count(*)
		as	n_rents
from 
	sakila.customer
inner join
	sakila.rental
using(customer_id)
group by
	customer_id
order by
	n_rents
    desc
limit 
	3
;

#    List number of films per category.
select 
	category_id,
    name,
    count(*)
		as n_films
from 
	sakila.film_category
inner join
	sakila.film
using(film_id)
inner join
	sakila.category
using(category_id)
group by
	category_id
order by
	n_films
    desc
limit
	3
    ;
    
#    Display the first and last names, as well as the address, of each staff member.
select
	first_name,
    last_name,
    address,
    city,
    postal_code
from 
	sakila.staff
inner join
	sakila.address
using(address_id)
inner join
	sakila.city
using(city_id)
;

#    Display the total amount rung up by each staff member in August of 2005.
select
	first_name,
    sum(amount) as total_amount
from sakila.staff
inner join
	sakila.payment
using(staff_id)
where payment_date like "2005-08-%"
group by
	staff_id
;

#    List each film and the number of actors who are listed for that film.
select
	title,
    count(*) as n_actors
from
	sakila.film
inner join
	sakila.film_actor
using(film_id)
group by
	film_id
;

# Using the tables payment and customer and the JOIN command, list the total paid by each customer. 
# List the customers alphabetically by last name. 
select
	customer_id,
    first_name,
    last_name,
#    count(rental) as n_rental,
	sum(amount) as total_paid
from
	sakila.customer
inner join
	sakila.payment
using(customer_id)
#inner join
#	sakila.payment
#using(customer_id)
group by
	customer_id
order by
	last_name
	asc
;

#Bonus: Which is the most rented film? The answer is Bucket Brotherhood 
# This query might require using more than one join statement. Give it a try.
select
	title,
    count(*) as times_rented
from 
	sakila.film
inner join
	sakila.inventory
using(film_id)
inner join
	sakila.rental
using(inventory_id)
group by
	film_id
order by
	times_rented
    desc
limit
	3
;
    