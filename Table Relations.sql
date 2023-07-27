CREATE DATABASE mountains;

CREATE TABLE mountains(
id INT AUTO_INCREMENT NOT NULL,
`name` VARCHAR(100),
CONSTRAINT pk_mountains_id PRIMARY KEY(id)
);

CREATE TABLE peaks(
id INT AUTO_INCREMENT PRIMARY KEY,
name VARCHAR(100) NOT NULL,
mountain_id INT NOT NULL,
CONSTRAINT fk_peaks_mountains 
FOREIGN KEY(mountain_id) REFERENCES mountains(id)
);



SELECT 
     driver_id,
     vehicle_type,
     concat_ws(' ', first_name, last_name) as 'driver name'
     FROM vehicles 
     JOIN campers  ON driver_id = campers.id;
     
     
     
SELECT starting_point AS 'route_starting_point',
		end_point AS 'rounte_ending_point',
        leader_id,
        concat_ws(' ', first_name, last_name)
FROM routes
JOIN campers on routes.leader_id = campers.id;       



   CREATE TABLE mountains(
id INT AUTO_INCREMENT NOT NULL PRIMARY KEY,
`name` VARCHAR(100)
);

CREATE TABLE peaks(
id INT AUTO_INCREMENT PRIMARY KEY,
name VARCHAR(100) NOT NULL,
mountain_id INT NOT NULL,
CONSTRAINT fk_peaks_mountains 
FOREIGN KEY(mountain_id) REFERENCES mountains(id)
ON DELETE CASCADE
);
     