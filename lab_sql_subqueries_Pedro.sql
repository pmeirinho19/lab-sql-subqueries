
--  1. How many copies of the film Hunchback Impossible exist in the inventory system? --

SELECT count(inventory_id) from inventory where film_id = (SELECT film_id from film where title = 'HUNCHBACK IMPOSSIBLE');

-- 2. List all films whose length is longer than the average of all the films. --

SELECT title from film where length > (SELECT avg(length) from film);

-- 3. Use subqueries to display all actors who appear in the film Alone Trip --

SELECT a.actor_id, c.first_name, c.last_name from film_actor as a join actor as c on a.actor_id = c.actor_id where film_id = (SELECT film_id from film where title = 'ALONE TRIP');

-- 4. Sales have been lagging among young families, and you wish to target all family movies for a promotion. Identify all movies categorized as family films. --

SELECT f.film_id, i.title from film_category as f join film as i on f.film_id = i.film_id where f.category_id = (SELECT category_id from category where name = 'Family');

-- 5. Get name and email from customers from Canada using subqueries. Do the same with joins. Note that to create a join, you will have to identify the correct tables with their primary keys and foreign keys, that will help you get the relevant information. --

-- a) using subqueries
SELECT first_name, last_name, email from customer where address_id IN (SELECT address_id from address 
where city_id IN (SELECT city_id from city where country_id = (SELECT country_id from country where country = 'Canada')));

/*draft:
SELECT * from customer; -- 4)--
SELECT * from country; -- 1) --
SELECT * from address;-- 3)--
SELECT * from city; -- 2)--

SELECT country_id from country where country = 'Canada';

SELECT city_id from city where country_id = (SELECT country_id from country where country = 'Canada');

SELECT address_id from address where city_id IN (SELECT city_id from city where country_id = (SELECT country_id from country where country = 'Canada'));*/


-- b) using joins --

SELECT u.first_name, u.last_name, u.email  from country as c join city as i on c.country_id = i.country_id right join address as a on i.city_id = a.city_id right join customer as u on 
a.address_id = u.address_id where c.country = 'Canada';

/*draft:
SELECT c.country_id, i.city_id from country as c join city as i on c.country_id = i.country_id where c.country = 'Canada';

SELECT c.country_id, i.city_id, i.city from country as c join city as i on c.country_id = i.country_id right join address as a on i.city_id = a.city_id right join customer as u on 
a.address_id = u.address_id where c.country = 'Canada';

SELECT c.country_id, i.city_id, i.city, c.country, u.first_name, u.last_name  from country as c join city as i on c.country_id = i.country_id right join address as a on i.city_id = a.city_id right join customer as u on 
a.address_id = u.address_id where c.country = 'Canada';
SELECT c.country_id, i.city_id, i.city, c.country, u.first_name, u.last_name  from country as c join city as i on c.country_id = i.country_id right join address as a on i.city_id = a.city_id right join customer as u on 
a.address_id = u.address_id where c.country = 'Canada';*/


/* -- 6. Which are films starred by the most prolific actor? Most prolific actor is defined as the actor that has acted in the most number of films. 
First you will have to find the most prolific actor and then use that actor_id to find the different films that he/she starred.*/

SELECT actor_id, count(film_id) as films_acted from film_actor group by actor_id order by films_acted desc limit 1; 

SELECT title, film_id from film where film_id IN (SELECT film_id from film_actor where actor_id = (SELECT actor_id from actor where actor_id = 107));

/* -- 7. Films rented by most profitable customer. You can use the customer table and payment table to find the most profitable customer 
ie the customer that has made the largest sum of payments*/

SELECT title from film where film_id IN (SELECT film_id from inventory where inventory_id IN (SELECT inventory_id from rental where customer_id = 526));

/* draft:
SELECT * from payment; -- 1 --
SELECT * from rental; -- 1 --
SELECT * from inventory;  -- 2 --
SELECT * from film; -- 3 --

SELECT inventory_id from rental where customer_id = 526;

SELECT film_id from inventory where inventory_id IN (SELECT inventory_id from rental where customer_id = 526);

SELECT title from film where film_id IN (SELECT film_id from inventory where inventory_id IN (SELECT inventory_id from rental where customer_id = 526));

SELECT customer_id, sum(amount)as total_paid from payment group by customer_id order by total_paid desc limit 1 ;*/

-- 8. Customers who spent more than the average payments. --

SELECT first_name, last_name from customer where customer_id IN 
(SELECT customer_id from payment group by customer_id having avg(amount)>(SELECT avg(amount) from payment) order by avg(amount) desc);

/* draft:
SELECT customer_id, avg(amount) from payment group by customer_id having avg(amount)>(SELECT avg(amount) from payment) order by avg(amount) desc;

SELECT customer_id from payment group by customer_id having avg(amount)>(SELECT avg(amount) from payment) order by avg(amount) desc;*/



