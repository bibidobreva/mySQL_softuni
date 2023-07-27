CREATE DATABASE moviesExam;

CREATE TABLE countries(
id INT PRIMARY KEY AUTO_INCREMENT,
name VARCHAR(30) NOT NULL UNIQUE,
continent VARCHAR(30) NOT NULL,
currency VARCHAR(5) NOT NULL
);


CREATE TABLE genres(
id INT PRIMARY KEY AUTO_INCREMENT,
name VARCHAR(50) NOT NULL UNIQUE
);


CREATE TABLE actors(
id INT PRIMARY KEY AUTO_INCREMENT,
first_name VARCHAR(50) NOT NULL,
last_name VARCHAR(50) not NULL,
birthdate DATE not null,
height INT,
awards int,
country_id INT NOT null,
CONSTRAINT fk_actors_country_id
FOREIGN KEY (country_id)
REFERENCES countries(id)
);



CREATE TABLE movies_additional_info(
id int PRIMARY KEY AUTO_INCREMENT,
rating DECIMAL(10,2) not null,
runtime int not null,
picture_url VARCHAR(80) not null,
budget decimal(10,2),
release_date date not null,
has_subtitles BOOLEAN,
description TEXT
);



CREATE table movies(
id int PRIMARY KEY AUTO_INCREMENT,
title VARCHAR(70) NOT NULL UNIQUE,
country_id INT not null,
movie_info_id int not null UNIQUE,
CONSTRAINT fk_country_movie
FOREIGN KEY (country_id)
REFERENCES countries(id),
CONSTRAINT fk_movies_movie_info
FOREIGN KEY (movie_info_id)
REFERENCES movies_additional_info(id)
);



CREATE table movies_actors(
movie_id INT ,
actor_id INT ,
CONSTRAINT fk_movie_id_movies
FOREIGN KEY (movie_id)
REFERENCES movies(id),
CONSTRAINT fk_actors_id_actors
FOREIGN KEY (actor_id) 
REFERENCES actors(id)
);



create table genres_movies(
genre_id int ,
movie_id int,
CONSTRAINT fk_genre_id_genres
FOREIGN KEY (genre_id)
REFERENCES genres(id),
CONSTRAINT fk_movie_genre_movies
FOREIGN KEY (movie_id)
REFERENCES movies(id)
);








INSERT INTO actors(first_name, last_name, birthdate, height, awards, country_id)
SELECT reverse(first_name), reverse(last_name), DATE(birthdate) -2, height+10, country_id, 3
FROM actors
WHERE id<=10;



UPDATE movies_additional_info
SET runtime = runtime -10
WHERE id BETWEEN 15 and 25;





DELETE countries
FROM countries
LEFT JOIN movies on countries.id = movies.country_id
WHERE country_id IS NULL;





SELECT id, name, continent, currency 
FROM countries
ORDER BY currency DESC, id;





SELECT movies.id, title, runtime, budget, release_date
FROM movies
JOIN movies_additional_info ON movies_additional_info.id = movies.movie_info_id
WHERE year(release_date) BETWEEN 1996 and 1999
ORDER BY runtime , id
LIMIT 20;



SELECT concat(first_name, ' ', last_name) as 'full_name', 
concat(reverse(last_name), CHAR_LENGTH(last_name),'@cast.com') as 'email',
(2022-year(birthdate)) as 'age',
height
FROM actors
LEFT JOIN movies_actors ON actors.id = movies_actors.actor_id
WHERE movie_id IS NULL
ORDER BY height;



SELECT name, count(movies.id) as `movies_count`
FROM countries
JOIN movies on countries.id = movies.country_id
GROUP BY country_id
HAVING `movies_count` >=7
ORDER BY name desc;


SELECT title,
	(CASE
		WHEN rating<=4 THEN 'poor'
        WHEN rating >4 and rating <=7 THEN 'good'
        ELSE 'excellent'
      END) as 'rating',
      (CASE 
		WHEN has_subtitles is TRUE THEN 'english'
        ELSE '-'
       END) as 'subtitles',
       budget
FROM movies
JOIN movies_additional_info on movies.movie_info_id = movies_additional_info.id       
order by budget DESC;






DELIMITER $$

CREATE FUNCTION udf_actor_history_movies_count(full_name VARCHAR(50)) 
RETURNS INT
DETERMINISTIC
BEGIN
RETURN(
     SELECT count(genres_movies.movie_id)
     FROM genres_movies
     JOIN genres ON genres.id = genres_movies.genre_id
     JOIN movies_actors ON movies_actors.movie_id = genres_movies.movie_id
     JOIN actors ON movies_actors.actor_id = actors.id
     WHERE genres.name = 'history' and concat_ws(' ',first_name, last_name) = full_name);
     END$$
     




CREATE PROCEDURE udp_award_movie (movie_title VARCHAR(50))
BEGIN
   UPDATE actors
	JOIN movies_actors on actors.id = movies_actors.actor_id
   JOIN movies on movies.id = movies_actors.movie_id
   SET awards = awards+1
   WHERE title = movie_title;
   END$$
