-- query to list the names of all people who starred in a movie in which Kevin Bacon also starred. 
SELECT peopleB.name FROM (SELECT movie_id AS A_movie_id FROM people peopleA JOIN stars starsA ON peopleA.id = starsA.person_id WHERE peopleA.name == 'Kevin Bacon' AND peopleA.birth == 1958)
JOIN stars starsB ON A_movie_id = starsB.movie_id JOIN people peopleB ON peopleB.id = starsB.person_id WHERE peopleB.name <> 'Kevin Bacon' OR peopleB.birth <> 1958 GROUP BY peopleB.name;
