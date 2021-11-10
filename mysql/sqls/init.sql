DROP DATABASE IF EXISTS myapp;

CREATE DATABASE myapp;
USE myapp;

CREATE TABLE app_info (
    id INTEGER AUTO_INCREMENT,
    bg_color TEXT,
    PRIMARY KEY (id)
);