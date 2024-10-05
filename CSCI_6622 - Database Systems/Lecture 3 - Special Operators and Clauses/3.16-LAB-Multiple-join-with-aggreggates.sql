+---------------------+
| Tables_in_zybooksdb |
+---------------------+
| actor               |
| film                |
| film_actor          |
+---------------------+
+----------+------------+-----------+---------------------+
| actor_id | first_name | last_name | last_update         |
+----------+------------+-----------+---------------------+
|        1 | PENELOPE   | GUINESS   | 2006-02-15 05:03:42 |
|        2 | NICK       | WAHLBERG  | 2006-02-15 05:03:42 |
|        4 | JENNIFER   | DAVIS     | 2006-02-15 05:03:42 |
|       10 | CHRISTIAN  | GABLE     | 2006-02-15 05:03:42 |
|       15 | CUBA       | OLIVIER   | 2006-02-15 05:03:42 |
|       19 | BOB        | FAWCETT   | 2006-02-15 05:03:42 |
|       20 | LUCILLE    | TRACY     | 2006-02-15 05:03:42 |
|       21 | KIRSTEN    | PALTROW   | 2006-02-15 05:03:42 |
|       22 | ELVIS      | MARX      | 2006-02-15 05:03:42 |
|       23 | SANDRA     | KILMER    | 2006-02-15 05:03:42 |
|       24 | CAMERON    | STREEP    | 2006-02-15 05:03:42 |
|       26 | RIP        | CRAWFORD  | 2006-02-15 05:03:42 |
|       29 | ALEC       | WAYNE     | 2006-02-15 05:03:42 |
|       30 | SANDRA     | PECK      | 2006-02-15 05:03:42 |
|       35 | JUDY       | DEAN      | 2006-02-15 05:03:42 |
|       36 | BURT       | DUKAKIS   | 2006-02-15 05:03:42 |
|       37 | VAL        | BOLGER    | 2006-02-15 05:03:42 |
+----------+------------+-----------+---------------------+
+---------+------------------+-----------------------------------------------------------------------------------------------------------------------+--------------+-------------+----------------------+-----------------+-------------+--------+------------------+--------+-------------------------+---------------------+
| film_id | title            | description                                                                                                           | release_year | language_id | original_language_id | rental_duration | rental_rate | length | replacement_cost | rating | special_features        | last_update         |
+---------+------------------+-----------------------------------------------------------------------------------------------------------------------+--------------+-------------+----------------------+-----------------+-------------+--------+------------------+--------+-------------------------+---------------------+
|       1 | ACADEMY DINOSAUR | A Epic Drama of a Feminist And a Mad Scientist who must Battle a Teacher in The Canadian Rockies                      |         2006 |           1 |                 NULL |               6 |        0.99 |     86 |            20.99 | PG     | Deleted Scenes          | 2006-06-15 05:03:00 |
|       2 | ACE GOLDFINGER   | A Astounding Epistle of a Database Administrator And a Explorer who must Find a Car in Ancient China                  |         2006 |           1 |                 NULL |               3 |        4.99 |     48 |            12.99 | G      | Trailers                | 2006-06-15 05:03:00 |
|       3 | ADAPTATION HOLES | A Astounding Reflection of a Lumberjack And a Car who must Sink a Lumberjack in A Baloon Factory                      |         2006 |           1 |                 NULL |               7 |        2.99 |     50 |            18.99 | NC-17  | Trailers                | 2006-06-15 05:03:00 |
|       4 | AFFAIR PREJUDICE | A Fanciful Documentary of a Frisbee And a Lumberjack who must Chase a Monkey in A Shark Tank                          |         2006 |           1 |                 NULL |               5 |        2.99 |    117 |            26.99 | G      | Commentaries            | 2006-06-15 05:03:00 |
|       5 | AFRICAN EGG      | A Fast-Paced Documentary of a Pastry Chef And a Dentist who must Pursue a Forensic Psychologist in The Gulf of Mexico |         2006 |           1 |                 NULL |               6 |        2.99 |    130 |            22.99 | G      | Deleted Scenes          | 2006-06-15 05:03:00 |
|       6 | AGENT TRUMAN     | A Intrepid Panorama of a Robot And a Boy who must Escape a Sumo Wrestler in Ancient China                             |         2006 |           1 |                 NULL |               3 |        2.99 |    169 |            17.99 | PG     | Deleted Scenes          | 2006-06-15 05:03:00 |
|       7 | AIRPLANE SIERRA  | A Touching Saga of a Hunter And a Butler who must Discover a Butler in A Jet Boat                                     |         2006 |           1 |                 NULL |               6 |        4.99 |     62 |            28.99 | PG-13  | Trailers,Deleted Scenes | 2006-06-15 05:03:00 |
|       8 | AIRPORT POLLOCK  | A Epic Tale of a Moose And a Girl who must Confront a Monkey in Ancient India                                         |         2006 |           1 |                 NULL |               6 |        4.99 |     54 |            15.99 | R      | Trailers                | 2006-06-15 05:03:00 |
|       9 | ALABAMA DEVIL    | A Thoughtful Panorama of a Database Administrator And a Mad Scientist who must Outgun a Mad Scientist in A Jet Boat   |         2006 |           1 |                 NULL |               3 |        2.99 |    114 |            21.99 | PG-13  | Trailers,Deleted Scenes | 2006-06-15 05:03:00 |
|      10 | ALADDIN CALENDAR | A Action-Packed Tale of a Man And a Lumberjack who must Reach a Feminist in Ancient China                             |         2006 |           1 |                 NULL |               6 |        4.99 |     63 |            24.99 | NC-17  | Trailers,Deleted Scenes | 2006-06-15 05:03:00 |
+---------+------------------+-----------------------------------------------------------------------------------------------------------------------+--------------+-------------+----------------------+-----------------+-------------+--------+------------------+--------+-------------------------+---------------------+
+----------+---------+---------------------+
| actor_id | film_id | last_update         |
+----------+---------+---------------------+
|        1 |       1 | 2006-02-15 05:03:42 |
|        2 |       3 | 2006-02-15 05:03:42 |
|       10 |       1 | 2006-02-15 05:03:42 |
|       10 |       9 | 2006-02-15 05:03:42 |
|       19 |       2 | 2006-02-15 05:03:42 |
|       19 |       3 | 2006-02-15 05:03:42 |
|       20 |       1 | 2006-02-15 05:03:42 |
|       21 |       6 | 2006-02-15 05:03:42 |
|       22 |       9 | 2006-02-15 05:03:42 |
|       23 |       6 | 2006-02-15 05:03:42 |
|       24 |       3 | 2006-02-15 05:03:42 |
|       26 |       9 | 2006-02-15 05:03:42 |
|       29 |      10 | 2006-02-15 05:03:42 |
|       30 |       1 | 2006-02-15 05:03:42 |
|       35 |      10 | 2006-02-15 05:03:42 |
|       37 |      10 | 2006-02-15 05:03:42 |
+----------+---------+---------------------+


/*
Write a statement that:

    -  Computes the average length of all films that each actor appears in.
    -   Rounds average length to the nearest minute and renames the result column average.
    -   Displays last name, first name, and average, in that order, for each actor.
    -   Sorts the result in descending order by average, then ascending order by last name.
The statement should exclude films with no actors and actors that do not appear in films.
*/

SELECT t1.last_name, t1.first_name, ROUND(AVG(t1.av1)) as average
FROM (
    SELECT actor.last_name, actor.first_name, film_actor.film_id, film.length as av1
    FROM actor
    INNER JOIN film_actor
    ON actor.actor_id = film_actor.actor_id
    INNER JOIN film
    ON film_actor.film_id = film.film_id
) as t1
GROUP BY t1.last_name, t1.first_name
ORDER BY average DESC, t1.last_name ASC
;

/* SOLUTION

+-----------+------------+---------+
| last_name | first_name | average |
+-----------+------------+---------+
| KILMER    | SANDRA     |     169 |
| PALTROW   | KIRSTEN    |     169 |
| CRAWFORD  | RIP        |     114 |
| MARX      | ELVIS      |     114 |
| GABLE     | CHRISTIAN  |     100 |
| GUINESS   | PENELOPE   |      86 |
| PECK      | SANDRA     |      86 |
| TRACY     | LUCILLE    |      86 |
| BOLGER    | VAL        |      63 |
| DEAN      | JUDY       |      63 |
| WAYNE     | ALEC       |      63 |
| STREEP    | CAMERON    |      50 |
| WAHLBERG  | NICK       |      50 |
| FAWCETT   | BOB        |      49 |
+-----------+------------+---------+
*/
