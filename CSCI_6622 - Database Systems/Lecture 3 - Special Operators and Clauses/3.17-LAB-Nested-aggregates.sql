

/* 3.17 LAB - Nested aggregates 
Write a statement that selects the titles of films with the fewest rows in the inventory table.

This statement requires a subquery that computes the minimum of counts by film_id:
*/
+---------------------+
| Tables_in_zybooksdb |
+---------------------+
| film                |
| inventory           |
+---------------------+
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
+--------------+---------+----------+---------------------+
| inventory_id | film_id | store_id | last_update         |
+--------------+---------+----------+---------------------+
|            1 |       1 |        1 | 2006-02-15 05:09:17 |
|            2 |       1 |        1 | 2006-02-15 05:09:17 |
|            3 |       1 |        1 | 2006-02-15 05:09:17 |
|            4 |       1 |        1 | 2006-02-15 05:09:17 |
|            5 |       1 |        2 | 2006-02-15 05:09:17 |
|            6 |       1 |        2 | 2006-02-15 05:09:17 |
|            7 |       1 |        2 | 2006-02-15 05:09:17 |
|            8 |       1 |        2 | 2006-02-15 05:09:17 |
|            9 |       2 |        2 | 2006-02-15 05:09:17 |
|           10 |       2 |        2 | 2006-02-15 05:09:17 |
|           11 |       2 |        2 | 2006-02-15 05:09:17 |
|           12 |       3 |        2 | 2006-02-15 05:09:17 |
|           13 |       3 |        2 | 2006-02-15 05:09:17 |
|           14 |       3 |        2 | 2006-02-15 05:09:17 |
|           15 |       3 |        2 | 2006-02-15 05:09:17 |
|           16 |       4 |        1 | 2006-02-15 05:09:17 |
|           17 |       4 |        1 | 2006-02-15 05:09:17 |
|           18 |       4 |        1 | 2006-02-15 05:09:17 |
|           19 |       4 |        1 | 2006-02-15 05:09:17 |
|           20 |       4 |        2 | 2006-02-15 05:09:17 |
|           21 |       4 |        2 | 2006-02-15 05:09:17 |
|           22 |       4 |        2 | 2006-02-15 05:09:17 |
|           23 |       5 |        2 | 2006-02-15 05:09:17 |
|           24 |       5 |        2 | 2006-02-15 05:09:17 |
|           25 |       5 |        2 | 2006-02-15 05:09:17 |
|           26 |       6 |        1 | 2006-02-15 05:09:17 |
|           27 |       6 |        1 | 2006-02-15 05:09:17 |
|           28 |       6 |        1 | 2006-02-15 05:09:17 |
|           29 |       6 |        2 | 2006-02-15 05:09:17 |
|           30 |       6 |        2 | 2006-02-15 05:09:17 |
|           31 |       6 |        2 | 2006-02-15 05:09:17 |
|           32 |       7 |        1 | 2006-02-15 05:09:17 |
|           33 |       7 |        1 | 2006-02-15 05:09:17 |
|           34 |       7 |        2 | 2006-02-15 05:09:17 |
|           35 |       7 |        2 | 2006-02-15 05:09:17 |
|           36 |       7 |        2 | 2006-02-15 05:09:17 |
|           37 |       8 |        2 | 2006-02-15 05:09:17 |
|           38 |       8 |        2 | 2006-02-15 05:09:17 |
|           39 |       8 |        2 | 2006-02-15 05:09:17 |
|           40 |       8 |        2 | 2006-02-15 05:09:17 |
|           41 |       9 |        1 | 2006-02-15 05:09:17 |
|           42 |       9 |        1 | 2006-02-15 05:09:17 |
|           43 |       9 |        1 | 2006-02-15 05:09:17 |
|           44 |       9 |        2 | 2006-02-15 05:09:17 |
|           45 |       9 |        2 | 2006-02-15 05:09:17 |
|           46 |      10 |        1 | 2006-02-15 05:09:17 |
|           47 |      10 |        1 | 2006-02-15 05:09:17 |
|           48 |      10 |        1 | 2006-02-15 05:09:17 |
|           49 |      10 |        1 | 2006-02-15 05:09:17 |
|           50 |      10 |        2 | 2006-02-15 05:09:17 |
|           51 |      10 |        2 | 2006-02-15 05:09:17 |
|           52 |      10 |        2 | 2006-02-15 05:09:17 |
+--------------+---------+----------+---------------------+

-- subquery
( SELECT MIN(count_film_id) 
FROM ( SELECT COUNT(film_id) AS count_film_id
       FROM inventory
       GROUP BY film_id ) 
AS temp_table );
+--------------------+
| MIN(count_film_id) |
+--------------------+
|                  3 |
+--------------------+

 -- SELECTS and groups movies film_id by count
SELECT * 
FROM 
    (SELECT inventory.film_id, film.title, COUNT(*) as tally
    FROM inventory
    INNER JOIN film
    ON film.film_id = inventory.film_id
    GROUP BY film.film_id) as t1
WHERE t1.tally =

-- Use the following subquery: to get min occurrance (3)
   ( SELECT MIN(count_film_id) FROM 
      ( SELECT COUNT(film_id) AS count_film_id
        FROM inventory
        GROUP BY film_id ) 
     AS temp_table );

/* RESULTS */
+----------------+
| title          |
+----------------+
| ACE GOLDFINGER |
| AFRICAN EGG    |
+----------------+
