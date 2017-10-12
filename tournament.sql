-- Table definitions for the tournament project.
--
-- Put your SQL 'create table' statements in this file; also 'create view'
-- statements if you choose to use it.
--
-- You can write comments in this file by starting them with two dashes, like
-- these lines here.

-- drop database

DROP DATABASE IF EXISTS tournament;

-- create database

CREATE DATABASE tournament;

-- connect database

\c tournament;

-- create table

CREATE TABLE players(
	id SERIAL PRIMARY KEY,
	name TEXT
);

CREATE TABLE matches(
  id SERIAL PRIMARY KEY,
	winner INTEGER REFERENCES players (id),
	loser INTEGER REFERENCES players (id)
);

-- create view

CREATE VIEW player_standings AS 
SELECT players.id, players.name,
(SELECT count(*) FROM matches WHERE matches.winner = players.id) AS num_wins,
(SELECT count(*) FROM matches WHERE players.id in (winner, loser)) AS num_matches
FROM players
GROUP BY players.id
ORDER BY num_wins DESC;

