CREATE USER 'kelompokf04'@'%' IDENTIFIED BY 'passwordf04';
CREATE USER 'kelompokf04'@'localhost' IDENTIFIED BY 'passwordf04';
CREATE DATABASE dbkelompokf04;
GRANT ALL PRIVILEGES ON *.* TO 'kelompokf04'@'%';
GRANT ALL PRIVILEGES ON *.* TO 'kelompokf04'@'localhost';
FLUSH PRIVILEGES;