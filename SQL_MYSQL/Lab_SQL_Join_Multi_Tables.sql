## Lab | SQL Joins on multiple tables

#    Write a query to display for each store its store ID, city, and country.
select
	store_id,
    city,
    country
from
	sakila.store
inner join
	sakila.address using(address_id)
inner join
	sakila.city using(city_id)
inner join
	sakila.country using(country_id)
;

#    Write a query to display how much business, in dollars, each store brought in.
select
	store_id,
    sum(amount) as total_amount_$
from sakila.store
inner join
	sakila.inventory using(store_id)
inner join
	sakila.rental using(inventory_id)
inner join
	sakila.payment using(rental_id)
group by
	store_id
;

#    What is the average running time of films by category?
select
	name,
    avg(length)
from sakila.category
inner join
	sakila.film_category using(category_id)
inner join
	sakila.film using(film_id)
group by
	name
;
	

#    Which film categories are longest?

### avg length
select
	name,
    avg(length) as avg_l
from sakila.category
inner join
	sakila.film_category using(category_id)
inner join
	sakila.film using(film_id)
group by
	name
order by
	avg_l
    desc
;
### max length
select
	name,
    max(length) as max_l
from sakila.category
inner join
	sakila.film_category using(category_id)
inner join
	sakila.film using(film_id)
group by
	name
order by
	max_l
    desc
;


#    Display the most frequently rented movies in descending order.
select
	title,
    count(*) as n_rents
from 
 sakila.film
inner join
	sakila.inventory using(film_id)
inner join
	sakila.rental using(inventory_id)
group by
	film_id
order by
	n_rents
    desc
;

#    List the top five genres in gross revenue in descending order.
select
	name,
    sum(amount) as revenue
from sakila.category
inner join
	sakila.film_category using(category_id)
inner join
	sakila.inventory using(film_id)
inner join
	sakila.rental using(inventory_id)
inner join
	sakila.payment using(rental_id)
group by
	category_id
order by
	revenue
    desc
;

#    Is "Academy Dinosaur" available for rent from Store 1?
select
	title,
    inventory_id,
    store_id,
    rental_date,
    return_date
from sakila.film
inner join
	sakila.inventory using(film_id)
inner join
	sakila.rental using(inventory_id)
where
	title = "Academy Dinosaur" and
    store_id = 1
order by
	return_date
    asc
;
