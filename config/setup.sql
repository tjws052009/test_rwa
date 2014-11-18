CREATE DATABASE IF NOT EXISTS rwa;

USE rwa;

CREATE TABLE IF NOT EXISTS users (
  id int,
  name varchar(64),
  email varchar(255),
  created datetime,
  modified datetime
);
