CREATE DATABASE connectfour;

USE connectfour;

CREATE TABLE saves
(
	save_id INT NOT NULL AUTO_INCREMENT,
	game_name NVARCHAR(100) NOT NULL,
	game_coded VARCHAR(1000) NOT NULL,
	PRIMARY KEY (save_id)
); 

CREATE UNIQUE INDEX saves_game_name_uniq ON saves(game_name);


