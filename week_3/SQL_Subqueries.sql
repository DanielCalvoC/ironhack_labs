-- 1.How many copies of the film Hunchback Impossible exist in the inventory system?
-- with join
SELECT film_id, title, count(inventory_id) as number_of_copies FROM sakila.inventory
INNER JOIN sakila.film
using (film_id)
GROUP BY film_id 
having title = "Hunchback Impossible"

-- with subquery
SELECT * FROM (
SELECT film_id, title, count(inventory_id) as number_of_copies FROM sakila.inventory
INNER JOIN sakila.film
using (film_id)
GROUP BY film_id) AS sub1
where title = "Hunchback Impossible";


-- 2. List all films whose length is longer than the average of all the films.

-- subquery 
SELECT AVG(LENGTH) FROM sakila.film

SELECT title FROM sakila.film
where length > (SELECT AVG(LENGTH) FROM sakila.film)

-- 3. Use subqueries to display all actors who appear in the film Alone Trip.
SELECT first_name, last_name from sakila.actor
INNER JOIN sakila.film_actor
using (actor_id)
INNER JOIN sakila.film
using (film_id)
where title = "Alone Trip"

-- with subquery
select first_name, last_name from sakila.actor where actor_id in
	(select actor_id from sakila.film_actor where film_id in
		(select film_id from sakila.film where title = "Alone Trip"));

-- 4. Sales have been lagging among young families, and you wish to target all family movies for a promotion. Identify all movies categorized as family films.

SELECT title from sakila.category
INNER JOIN sakila.film_category
USING (category_id)
INNER JOIN sakila.film
USING (film_id)
where name = "family"

-- with subquery
select title from sakila.film where film_id in 
	(select film_id from sakila.film_category where category_id in 
			(select category_id from sakila.category where name = "Family"))
		

-- 5. Get name and email from customers from Canada using subqueries

SELECT first_name, last_name, email FROM sakila.customer WHERE address_id in
	(SELECT address_id FROM sakila.address WHERE city_id IN
		(SELECT city_id FROM sakila.city WHERE country_id IN
			(SELECT country_id FROM sakila.country WHERE country = "Canada")))

-- with joins            
SELECT first_name, last_name, email 
FROM sakila.customer 
INNER JOIN sakila.address using (address_id)
INNER JOIN sakila.city using (city_id)
INNER JOIN sakila.country using (country_id)
where country = "Canada"
            

-- 6. Which are films starred by the most prolific actor? 
-- 1st: most profilic actor
SELECT first_name, last_name, count(film_id) as number_films
FROM sakila.actor 
INNER JOIN sakila.film_actor using (actor_id)
INNER JOIN sakila.film using (film_id)
GROUP BY last_name, first_name
ORDER BY number_films desc
LIMIT 1

-- 2nd . Films from this actor
SELECT title FROM sakila.film
INNER JOIN sakila.film_actor USING (film_id)
INNER JOIN sakila.actor USING (actor_id)
where first_name = "SUSAN" and last_name = "DAVIS"


-- 7. Films rented by most profitable customer
-- 1st: find the costumer (KARL SEAL)
SELECT first_name, last_name, sum(amount) as total_amount
FROM sakila.customer 
INNER JOIN sakila.payment using (customer_id)
GROUP BY first_name, last_name
ORDER BY total_amount desc
LIMIT 1

-- 2nd. Films rented.

SELECT title FROM sakila.film
INNER JOIN sakila.inventory USING (film_id)
INNER JOIN sakila.rental USING (inventory_id)
INNER JOIN sakila.customer USING (customer_id)
where first_name = "KARL" and last_name = "SEAL"


-- 8. Customers who spent more than the average payments.
SELECT AVG(amount) FROM sakila.payment

SELECT  distinct last_name, first_name  FROM sakila.customer
INNER JOIN sakila.payment USING (customer_id)
WHERE amount > (SELECT AVG(amount) FROM sakila.payment)
