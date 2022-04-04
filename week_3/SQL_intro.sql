-- Review the tables in the database.
use sakila;

-- Explore tables by selecting all columns from each table 
show tables from sakila;
select * from actor;

-- Select one column from a table. Get film titles.
select title from film;

-- Select one column from a table and alias it. Get unique list of film languages under the alias language
select distinct(name) as language from language;

-- 5.1 Find out how many stores does the company have

select count(store_id) from store;

-- Find out how many employees staff does the company have?

select count(staff_id) from staff;

-- Return a list of employee first names only?
select first_name from staff;
