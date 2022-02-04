## Lab | SQL Subqueries


# 1   How many copies of the film Hunchback Impossible exist in the inventory system?
SELECT 
    title, COUNT(inventory_id)
FROM
    sakila.film
        INNER JOIN
    sakila.inventory USING (film_id)
GROUP BY film_id
HAVING title = 'Hunchback Impossible'
;

# how to get the film id of movie hunchback impossible
SELECT 
    film_id
FROM
    sakila.film
WHERE
    title = 'Hunchback Impossible';


# 2   List all films whose length is longer than the average of all the films.
SELECT 
    title, length
FROM
    sakila.film
WHERE
    length > (SELECT 
            AVG(length)
        FROM
            sakila.film)
;

# 3   Use subqueries to display all actors who appear in the film Alone Trip.
SELECT 
    CONCAT(first_name, ' ', last_name) AS Actor
FROM
    sakila.actor
        INNER JOIN
    sakila.film_actor USING (actor_id)
        INNER JOIN
    sakila.film USING (film_id)
WHERE
    title = 'Alone Trip';

SELECT 
    CONCAT(first_name, ' ', last_name) AS Actor
FROM
    sakila.actor
WHERE
    actor_id = any (SELECT 
            actor_id
        FROM
            sakila.film_actor
        WHERE
            film_id = (SELECT 
                    film_id
                FROM
                    sakila.film
                WHERE
                    title = 'Alone Trip'));

# 4   Sales have been lagging among young families, and you wish to target all family movies for a promotion. Identify all movies categorized as family films.
select
	title, name
from sakila.film
inner join
	sakila.film_category
using(film_id)
inner join
	sakila.category
using(category_id)
where name = "Family";

# 5   Get name and email from customers from Canada using subqueries. Do the same with joins. Note that to create a join, you will have to identify the correct tables with their primary keys and foreign keys, that will help you get the relevant information.
SELECT 
    CONCAT(first_name, ' ', last_name) AS Name, email
FROM
    sakila.customer
WHERE
    address_id = ANY (SELECT 
            address_id
        FROM
            sakila.address
        WHERE
            city_id IN (SELECT 
                    city_id
                FROM
                    sakila.city
                WHERE
                    country_id = ANY (SELECT 
                            country_id
                        FROM
                            sakila.country
                        WHERE
                            country = 'Canada')));
                            
SELECT 
    CONCAT(first_name, ' ', last_name) AS Name, email
FROM
    sakila.customer
        INNER JOIN
    sakila.address USING (address_id)
        INNER JOIN
    sakila.city USING (city_id)
        INNER JOIN
    sakila.country USING (country_id)
WHERE
    country = 'Canada';

# 6   Which are films starred by the most prolific actor? Most prolific actor is defined as the actor that has acted in the most number of films. 
#	 First you will have to find the most prolific actor and then use that actor_id to find the different films that he/she starred.
SELECT 
    title as Movies
FROM
    sakila.film
WHERE
    film_id = any (SELECT 
            film_id
        FROM
            sakila.film_actor
        WHERE
            actor_id = (SELECT 
                    actor_id
                FROM
                    sakila.film_actor
                GROUP BY actor_id
                ORDER BY COUNT(film_id) DESC
                LIMIT 1))
;

# 7   Films rented by most profitable customer. You can use the customer table and payment table to find the most profitable customer ie the customer that has made the largest sum of payments
SELECT 
    title AS Rented_Movies_by_max_CouchPotato
FROM
    sakila.film
WHERE
    film_id IN (SELECT 
            film_id
        FROM
            sakila.inventory
        WHERE
            inventory_id IN (SELECT 
                    inventory_id
                FROM
                    sakila.rental
                WHERE
                    customer_id = (SELECT 
                            customer_id
                        FROM
                            sakila.payment
                        GROUP BY customer_id
                        ORDER BY SUM(amount) Desc
                        LIMIT 1)));

# 8   Customers who spent more than the average payments.
SELECT 
    CONCAT(first_name, ' ', last_name) AS Customer
FROM
    sakila.customer
WHERE
    customer_id IN (SELECT 
            customer_id
        FROM
            sakila.payment
        GROUP BY customer_id
        HAVING AVG(amount) > (SELECT 
                AVG(amount)
            FROM
                sakila.payment))
;
SELECT 
    CONCAT(first_name, ' ', last_name) AS Customer, avg(amount)
FROM
    sakila.customer
Inner join
	sakila.payment
using(customer_ID)
        GROUP BY customer_id
        HAVING AVG(amount) > (SELECT 
                AVG(amount)
            FROM
                sakila.payment)
order by
avg(amount)