-- SQL Queries - Join Two Tables - Sakila database

-- 1.Which actor has appeared in the most films?
select actor_id, first_name, last_name, count(film_id) 
from sakila.actor 
inner join sakila.film_actor 
using(actor_id)
group by actor_id
order by count(film_id) desc
limit 1;

-- 2.Most active customer (the customer that has rented the most number of films)

select customer_id, first_name, last_name, count(rental_id) as freq
from sakila.customer as cst
inner join sakila.rental as rnt
using (customer_id)
group by customer_id 
order by freq desc
limit 1;

-- 3. List number of films per category.
select category_id, count(film_id)
from sakila.film_category
group by category_id

-- with name of category, we need to join 
select name, count(film_id) from sakila.category
left join sakila.film_category
using (category_id)
group by name

-- 4. Display the first and last names, as well as the address, of each staff member.
select address, first_name, last_name from sakila.staff
inner join sakila.address
using (address_id)

-- 5. Display the total amount rung up by each staff member in August of 2005.
select staff_id, first_name, last_name, count(amount) from sakila.staff
right join sakila.payment
using (staff_id)
where payment_date between "2005-08-01" and "2005-09-01"
group by staff_id;

-- 6. List each film and the number of actors who are listed for that film.
SELECT title, count(actor_id) from sakila.film
INNER JOIN sakila.film_actor
USING (film_id)
GROUP BY title

-- 7. Using the tables payment and customer and the JOIN command, list the total paid by each customer. List the customers alphabetically by last name
SELECT customer_id, first_name, last_name, count(amount) FROM sakila.customer
INNER JOIN sakila.payment
USING (customer_id)
GROUP BY customer_id
ORDER BY last_name ASC

--

-- Optional: Which is the most rented film? 

select film_id, count(rental_id),title 
from sakila.rental
inner join sakila.inventory
using (inventory_id)
inner join sakila.film
using (film_id)
group by film_id
order by count(rental_id) desc
limit 1
