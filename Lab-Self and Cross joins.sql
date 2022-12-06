use sakila;

-- Query 1: Get all pairs of actors that worked together.
select f1.actor_id, f1.film_id, f2.actor_id from film_actor as f1
join film_actor as f2
on f1.film_id = f2.film_id
and f1.actor_id < f2.actor_id;


-- Query 2: Get all pairs of customers that have rented the same film more than 3 times.

-- step 1: get all customers which have rented a the same movie more than 1 time
SELECT i.film_id, r.customer_id, COUNT(*) AS times_rented
  FROM rental as r
  JOIN inventory as i
    ON i.inventory_id = r.inventory_id
 GROUP BY i.film_id, r.customer_id
HAVING times_rented > 1
 ORDER BY times_rented DESC;

-- step 2: bring together in one query
SELECT *
  FROM (
		SELECT i.film_id, r.customer_id, COUNT(*) AS times_rented
		  FROM rental as r
		  JOIN inventory as i
			ON i.inventory_id = r.inventory_id
		 GROUP BY i.film_id, r.customer_id
		HAVING times_rented > 1
		 ORDER BY times_rented DESC
	  ) as q1
JOIN (
	    SELECT i.film_id, r.customer_id, COUNT(*) AS times_rented
		  FROM rental as r
		  JOIN inventory as i
			ON i.inventory_id = r.inventory_id
		 GROUP BY i.film_id, r.customer_id
		HAVING times_rented > 1
		 ORDER BY times_rented DESC
     ) as q2
  ON q2.film_id = q1.film_id
 AND q2.customer_id <> q1.customer_id; 
          
          
-- Query 3: Get all possible pairs of actors and films.
select * from (
  select distinct title from film
) sub1
cross join (
  select distinct actor_id from actor
) sub2;
