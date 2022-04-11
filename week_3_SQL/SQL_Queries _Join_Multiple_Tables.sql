-- Lab | SQL Joins on multiple tables

-- 1. Write a query to display for each store its store ID, city, and country.

SELECT store_id, city, country FROM sakila.store
INNER JOIN sakila.address
USING (address_id)
INNER JOIN sakila.city
USING (city_id)
INNER JOIN sakila.country
USING (country_id)


-- 2. Write a query to display how much business, in dollars, each store brought in.
SELECT count(amount), store_id FROM sakila.inventory
INNER JOIN sakila.rental
USING (inventory_id)
INNER JOIN sakila.payment
USING (rental_id)
GROUP BY store_id

-- 3. What is the average running time(length) of films by category?
SELECT name, avg(length) as length  FROM sakila.film
INNER JOIN sakila.film_category
USING (film_id)
INNER JOIN sakila.category
USING (category_id)
GROUP BY name


-- 4. Which film categories are longest(length)?
SELECT name, avg(length) as length  FROM sakila.film
INNER JOIN sakila.film_category
USING (film_id)
INNER JOIN sakila.category
USING (category_id)
GROUP BY name
ORDER BY length desc


-- 5. Display the most frequently(number of times) rented movies in descending order.
select film_id, title, count(rental_id) as rented_times
from sakila.rental
inner join sakila.inventory
using (inventory_id)
inner join sakila.film
using (film_id)
group by film_id
order by rented_times desc
limit 10


-- 6.List the top five genres in gross revenue in descending order
SELECT name, count(amount) AS gross_revenue FROM sakila.category
INNER JOIN sakila.film_category
USING (category_id)
INNER JOIN sakila.film
USING (film_id)
INNER JOIN sakila.inventory
USING (film_id)
INNER JOIN sakila.rental
USING (inventory_id)
INNER JOIN sakila.payment
USING (rental_id)
GROUP BY name
ORDER BY gross_revenue DESC
LIMIT 5


-- 7. Is "Academy Dinosaur" available for rent from Store 1?
SELECT film_id,title,store_id, inventory_id from sakila.inventory
inner join sakila.film
using (film_id)
where store_id = 1 and title = "Academy Dinosaur"

