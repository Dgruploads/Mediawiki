# This script is to create user and database in mysql
# Create a user 
CREATE USER 'wiki'@'%' IDENTIFIED BY 'wiki';

# Create a database
CREATE DATABASE wiki;

# Set permission for the user
GRANT ALL PRIVILEGES ON wiki.* TO 'wiki'@'%';
FLUSH PRIVILEGES;

# Show all the databases;
SHOW DATABASES;

# Show the permissions for the user
SHOW GRANTS FOR 'wiki'@'%';

# Exit from the database
exit

