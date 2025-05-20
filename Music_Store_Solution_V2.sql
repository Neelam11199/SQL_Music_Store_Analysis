
-- 1) Who is the senior most employee based on job title?
SELECT 
employee_id,
first_name,
last_name,
title,
levels
FROM EMPLOYEE
ORDER BY LEVELS DESC
LIMIT 1;

-- 2)Which countries have the most Invoices?
SELECT COUNT(*) AS INVOICE_COUNT,BILLING_COUNTRY
FROM INVOICE
GROUP BY BILLING_COUNTRY
ORDER BY INVOICE_COUNT DESC;

-- 3)What are top 3 values of total invoice?
SELECT INVOICE_ID,TOTAL
FROM INVOICE
ORDER BY TOTAL DESC;

-- 4)Which city has the best customers? We would like to throw a promotional Music Festival in the city we made the most money. Write a query that returns one city that has the highest sum of invoice totals. Return both the city name & sum of all invoice totals
SELECT
BILLING_CITY,
SUM(TOTAL) AS TOTALM
FROM INVOICE
GROUP BY BILLING_CITY
ORDER BY TOTALM DESC

--5)Who is the best customer? The customer who has spent the most money will be declared the best customer. Write a query that returns the person who has spent the most money
SELECT
C.CUSTOMER_ID,
CONCAT(C.FIRST_NAME,' ',C.LAST_NAME) AS FULL_NAME,
SUM(V.TOTAL) AS EXP
FROM CUSTOMER AS C
	JOIN INVOICE AS V
    ON C.CUSTOMER_ID = V.CUSTOMER_ID
GROUP BY C.CUSTOMER_ID,C.FIRST_NAME,C.LAST_NAME
ORDER BY EXP DESC
LIMIT 1;

-- Moderate
--1)Write query to return the email, first name, last name, & Genre of all Rock Music listeners. Return your list ordered alphabetically by email starting with A
SELECT DISTINCT
C.EMAIL,C.FIRST_NAME,C.LAST_NAME
FROM CUSTOMER AS C
	JOIN INVOICE AS V
	ON C.CUSTOMER_ID = V.CUSTOMER_ID
    JOIN INVOICE_LINE AS IL
    ON V.INVOICE_ID = IL.INVOICE_ID
WHERE IL.TRACK_ID IN(
			SELECT T.TRACK_ID 
            FROM TRACK AS T
            JOIN GENRE AS G
            ON G.GENRE_ID = T.GENRE_ID
            WHERE G.NAME = 'ROCK')
ORDER BY C.EMAIL;

-- 2)Let's invite the artists who have written the most rock music in our dataset. Write a query that returns the Artist name and total track count of the top 10 rock bands
SELECT
	A.ARTIST_ID,A.NAME,COUNT(T.NAME) AS Numner_of_song
FROM ARTIST AS A
	JOIN ALBUM2 AS B
    ON A.ARTIST_ID = B.ARTIST_ID
    JOIN TRACK AS T
    ON B.ALBUM_ID = T.ALBUM_ID
    JOIN GENRE AS G
    ON T.GENRE_ID = G.GENRE_ID
WHERE G.NAME = 'ROCK'
GROUP BY A.NAME,A.ARTIST_ID
ORDER BY Numner_of_song DESC
LIMIT 10;

-- 3)Return all the track names that have a song length longer than the average song length. Return the Name and Milliseconds for each track. Order by the song length with the longest songs listed first
SELECT 
	NAME,
    milliseconds
FROM TRACK
WHERE milliseconds >
 		(SELECT AVG(milliseconds) AS A
        FROM TRACK)
ORDER BY milliseconds DESC;

-- Find how much amount spent by each customer on artists? Write a query to return customer name, artist name and total spent
WITH best_selling_artist AS (             -- used Common table expression CTE
	SELECT 
    artist.artist_id,
    artist.name,
    SUM(invoice_line.unit_price*invoice_line.quantity) AS total_sales
	FROM invoice_line
    JOIN track 
    ON invoice_line.track_id = track.track_id
    JOIN album2
    ON Track.Album_id = Album2.Album_id
    JOIN Artist
    ON album2.artist_id = artist.artist_id
    group by 1,2
    Order by 3 DESC
    LIMIT 1
    )
    
    SELECT 
    C.CUSTOMER_ID, C.First_name,c.Last_name,BSA.name,SUM(IL.UNIT_PRICE*IL.QUANTITY) AS AMOUNT_SPEND
    FROM INVOICE I
    JOIN CUSTOMER C
    ON C.CUSTOMER_ID = I.CUSTOMER_ID
    JOIN INVOICE_LINE IL 
    ON IL.INVOICE_ID = I.INVOICE_ID
    JOIN TRACK T
    ON T.TRACK_ID = IL.TRACK_ID
    JOIN ALBUM2 A
    ON A.ALBUM_ID = T.ALBUM_ID
    JOIN best_selling_artist BSA
    ON BSA.ARTIST_ID = A.ARTIST_ID
    GROUP BY 1,2,3,4
    ORDER BY 5 DESC
    
    We want to find out the most popular music Genre for each country. We determine the most popular genre as the genre with the highest amount of purchases. Write a query that returns each country along with the top Genre. For countries where the maximum number of purchases is shared return all Genres
    WITH popular_genre AS 
(
    SELECT COUNT(invoice_line.quantity) AS purchases, customer.country, genre.name, genre.genre_id, 
	ROW_NUMBER() OVER(PARTITION BY customer.country ORDER BY COUNT(invoice_line.quantity) DESC) AS RowNo 
    FROM invoice_line 
	JOIN invoice ON invoice.invoice_id = invoice_line.invoice_id
	JOIN customer ON customer.customer_id = invoice.customer_id
	JOIN track ON track.track_id = invoice_line.track_id
	JOIN genre ON genre.genre_id = track.genre_id
	GROUP BY 2,3,4
	ORDER BY 2 ASC, 1 DESC
)
SELECT * FROM popular_genre WHERE RowNo <= 1
    
Write a query that determines the customer that has spent the most on music for each country. Write a query that returns the country along with the top customer and how much they spent. For countries where the top amount spent is shared, provide all customers who spent this amount
   WITH Customter_with_country AS (
		SELECT customer.customer_id,first_name,last_name,billing_country,SUM(total) AS total_spending,
	    ROW_NUMBER() OVER(PARTITION BY billing_country ORDER BY SUM(total) DESC) AS RowNo 
		FROM invoice
		JOIN customer ON customer.customer_id = invoice.customer_id
		GROUP BY 1,2,3,4
		ORDER BY 4 ASC,5 DESC)
SELECT * FROM Customter_with_country WHERE RowNo <= 1 
    
    
    
    
    
    





    