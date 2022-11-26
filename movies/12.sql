-- query to list the titles of all movies in which both Johnny Depp and Helena Bonham Carter starred. 
SELECT title FROM (SELECT title, COUNT(title) AS n FROM movies JOIN stars ON movies.id = stars.movie_id JOIN people ON people.id = stars.person_id WHERE name == "Johnny Depp" OR name == "Helena Bonham Carter" GROUP BY title) WHERE n == 2;
