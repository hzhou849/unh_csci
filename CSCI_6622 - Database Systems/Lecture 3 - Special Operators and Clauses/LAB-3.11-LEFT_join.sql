/*
* 3.11 LAB - LEFT Join
* Write a statement that selects movie title, year, and description. Select all movies, including movies with no rating code.
*/

+---------------------+
| Tables_in_zybooksdb |
+---------------------+
| movie               |
| rating              |
+---------------------+
+-------+-----------------------------+
| Code  | Description                 |
+-------+-----------------------------+
| G     | General Audiences           |
| PG    | Parental Guidance Suggested |
| PG-13 | Parents Strongly Cautioned  |
| R     | Restricted                  |
+-------+-----------------------------+
+----+-----------------------------+-------------+------------+------+
| ID | Title                       | Genre       | RatingCode | Year |
+----+-----------------------------+-------------+------------+------+
|  1 | Becoming                    | Documentary | PG         | 2020 |
|  2 | Den of Thieves              | Action      | R          | 2019 |
|  3 | Arctic Dogs                 | Family      | PG         | 2019 |
|  4 | Dangerous Lies              | Action      | NULL       | 2020 |
|  5 | All Day and a Night         | Drama       | R          | 2020 |
|  6 | Extraction                  | Action      | R          | 2020 |
|  7 | Madagascar: Escape 2 Africa | Family      | PG         | 2008 |
|  8 | The Willoughbys             | Family      | PG         | 2020 |
|  9 | Despicable Me               | Family      | PG         | 2010 |
| 10 | Armed Response              | Action      | R          | 2017 |
+----+-----------------------------+-------------+------------+------+


SHOW TABLES;


SELECT Movie.Title, Movie.Year, Rating.Description
FROM Movie
LEFT JOIN Rating
ON Movie.RatingCode = Rating.Code;




-- RESULT: 
+-----------------------------+------+-----------------------------+
| Title                       | Year | Description                 |
+-----------------------------+------+-----------------------------+
| Becoming                    | 2020 | Parental Guidance Suggested |
| Den of Thieves              | 2019 | Restricted                  |
| Arctic Dogs                 | 2019 | Parental Guidance Suggested |
| Dangerous Lies              | 2020 | NULL                        |
| All Day and a Night         | 2020 | Restricted                  |
| Extraction                  | 2020 | Restricted                  |
| Madagascar: Escape 2 Africa | 2008 | Parental Guidance Suggested |
| The Willoughbys             | 2020 | Parental Guidance Suggested |
| Despicable Me               | 2010 | Parental Guidance Suggested |
| Armed Response              | 2017 | Restricted                  |
+-----------------------------+------+-----------------------------+
