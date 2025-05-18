
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



    