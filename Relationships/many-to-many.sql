CREATE DATABASE manyToMany;

CREATE TABLE reviewers (
    id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(20),
    last_name   VARCHAR(30)
);

CREATE TABLE series 
    (
    id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(30),
    released_year YEAR(4),
    genre VARCHAR(20)
);

CREATE TABLE reviews 
    (
    id INT AUTO_INCREMENT PRIMARY KEY,
    rating DECIMAL (2,1),
    series_id INT,
    reviewer_id INT, 
    FOREIGN KEY(series_id) 
        REFERENCES series(id),
    FOREIGN KEY(reviewer_id) 
        REFERENCES reviewers(id)
);

/* JUST SELECT THE TITLE AND ITS ASSOCIATED RATINGS 

SELECT * FROM series
JOIN reviews
    ON series.id = reviews.series_id;

SELECT title, rating FROM series
JOIN reviews
    ON series.id = reviews.series_id;

*/


/* SELECT THE TITLE AND ITS ASSOCIATED AVERAGE RATING 

SELECT 
    title, 
    AVG(rating) AS avg_rating 
FROM series
JOIN reviews
    ON series.id = reviews.series_id
GROUP BY series.id
ORDER BY avg_rating DESC;

*/

/* SELECT THE FIRST NAME AND LAST NAME AND ITS ASSOCIATED RATINGS

SELECT 
    first_name,
    last_name,
    rating
FROM reviewers
JOIN reviews
    ON reviewers.id = reviews.reviewer_id;

*/

/* SELECT THE TITLES OF THE UNREVIEWED SERIES 

SELECT 
    title AS unreviewed_series
FROM series
JOIN reviews
    ON series.id NOT IN(SELECT series_id FROM reviews)
GROUP BY series.id;

SELECT 
    title AS unreviewed_series
FROM series
LEFT JOIN reviews
    ON series.id  = reviews.series_id
WHERE rating IS NULL;

*/

/* SELECT THE GENRE AND AVERAGE AND GROUPING THEM BY RATING

SELECT 
    genre,
    AVG(rating) AS avg_rating
FROM reviews
JOIN series
    ON series.id = reviews.series_id
GROUP BY genre;

SELECT 
    genre, 
    ROUND(
        AVG(rating),
        2
    ) AS avg_rating 
FROM series
JOIN reviews
    ON series.id = reviews.series_id
GROUP BY genre
ORDER BY avg_rating DESC;

*/

/* first, last, count of reviews, min, max avg, status

This code didn't work:
SELECT 
    first_name, 
    last_name, 
    COUNT(*) FROM reviews WHERE reviewers.id = reviews.reviewer_id,
    MIN(rating) FROM reviews WHERE reviewers.id = reviews.reviewer_id,
    MAX(rating) FROM reviews WHERE reviewers.id = reviews.reviewer_id
FROM reviewers
LEFT JOIN reviews
    ON reviewers.id = reviews.reviewer_id
GROUP BY reviewers.id;

This shows all reviewers and their ratings"
SELECT 
    first_name,
    last_name,
    rating
FROM reviewers
LEFT JOIN reviews
    ON reviewers.id = reviews.reviewer_id;

Continuing on:
SELECT 
    first_name,
    last_name,
    COUNT(rating) AS COUNT,
    IFNULL(MIN(rating),0) AS MINIMUM, 
    IFNULL(MAX(rating),0) AS MAXIMUM,
    ROUND(IFNULL(AVG(rating),0),2) AS AVERAGE,
    IF(COUNT(rating) > 0, "Active", "Inactive")
FROM reviewers
LEFT JOIN reviews
    ON reviewers.id = reviews.reviewer_id
GROUP BY reviewers.id;

--Different CASE Statement
SELECT 
    first_name,
    last_name,
    COUNT(rating) AS COUNT,
    IFNULL(MIN(rating),0) AS MINIMUM, 
    IFNULL(MAX(rating),0) AS MAXIMUM,
    ROUND(IFNULL(AVG(rating),0),2) AS AVERAGE,
    CASE
        WHEN COUNT(rating) >= 10 THEN "Power User"
        WHEN COUNT(rating) > 0 THEN "Active"
        ELSE "Inactive"
    END AS STATUS
FROM reviewers 
LEFT JOIN reviews
    ON reviewers.id = reviews.reviewer_id
GROUP BY reviewers.id;

*/


/*GETTING INFO FROM ALL THREE TABLES 

SELECT 
    title,
    rating,
    CONCAT(first_name, " ", last_name) AS fullname
FROM reviewers
JOIN reviews
    ON reviewers.id = reviews.reviewer_id
JOIN series
    ON series.id = reviews.series_id
ORDER BY title;

*/