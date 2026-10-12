rg4f+-360
ui
SELECT
    current_database() AS database_name,
    current_user AS database_user,
    has_database_privilege(
        current_user,
        current_database(),
        'CREATE'
    ) AS can_create_in_database;

SELECT current_database();

SELECT COUNT(*) AS total_films
FROM film;

SELECT
    c.name AS category_name,
    COUNT(*) AS total_films
FROM film_category fc
JOIN category c
    ON fc.category_id = c.category_id
GROUP BY c.name
ORDER BY total_films DESC;


--Which customers have paid the most in total rental payments?
SELECT
    c.customer_id,
    c.first_name,
    c.last_name,
    SUM(p.amount) AS total_paid
FROM customer c
JOIN payment p
    ON c.customer_id = p.customer_id
GROUP BY
    c.customer_id,
    c.first_name,
    c.last_name
ORDER BY total_paid DESC
LIMIT 10;


---Which dates had the most rental transactions?
SELECT
    DATE(rental_date) AS rental_day,
    COUNT(*) AS total_rentals
FROM rental
GROUP BY DATE(rental_date)
ORDER BY total_rentals DESC
LIMIT 10;


--Which films are rented most often? This helps the business identify popular titles?
SELECT
    f.film_id,
    f.title,
    COUNT(r.rental_id) AS times_rented
FROM film f
JOIN inventory i
    ON f.film_id = i.film_id
JOIN rental r
    ON i.inventory_id = r.inventory_id
GROUP BY
    f.film_id,
    f.title
ORDER BY times_rented DESC
LIMIT 10;

--Which film categories generate the most rental payment revenue?
SELECT
    c.name AS category_name,
    SUM(p.amount) AS total_revenue
FROM category c
JOIN film_category fc
    ON c.category_id = fc.category_id
JOIN inventory i
    ON fc.film_id = i.film_id
JOIN rental r
    ON i.inventory_id = r.inventory_id
JOIN payment p
    ON r.rental_id = p.rental_id
GROUP BY c.name
ORDER BY total_revenue DESC;