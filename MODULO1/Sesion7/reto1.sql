CREATE DATABASE sesion7;
USE sesion7;
CREATE TABLE IF NOT EXISTS movies (
   id INT PRIMARY KEY, 
   title VARCHAR(80), 
   generos VARCHAR(80)
); 
CREATE TABLE IF NOT EXISTS ratings (
   userid INT, 
   movieid INT, 
   rating INT, 
   time_stamp BIGINT
);
