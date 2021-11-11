DROP DATABASE IF EXISTS my_app;

CREATE DATABASE my_app;
USE my_app;

CREATE TABLE app_info (
    id INTEGER AUTO_INCREMENT,
    bg_color TEXT,
    PRIMARY KEY (id)
);