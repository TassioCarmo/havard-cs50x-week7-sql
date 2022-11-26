-- query to list the names of all people who have directed a movie that received a rating of at least 9.0. 
SELECT name FROM movies JOIN ratings ON movies.id = ratings.movie_id JOIN directors ON movies.id = directors.movie_id JOIN people ON directors.person_id = people.id WHERE rating >= 9.0 GROUP BY name;
