TRUNCATE TABLE albums RESTART IDENTITY;
INSERT INTO albums (title) VALUES ('Doolittle');
INSERT INTO albums (title) VALUES ('Surfer Rosa');
INSERT INTO albums (title) VALUES ('Waterloo');
INSERT INTO albums (title) VALUES ('Super Trouper');
INSERT INTO albums (title) VALUES ('Bossanova');
INSERT INTO albums (title) VALUES ('Lover');
INSERT INTO albums (title) VALUES ('Folklore');
INSERT INTO albums (title) VALUES ('I Put a Spell on You');
INSERT INTO albums (title) VALUES ('Baltimore');
INSERT INTO albums (title) VALUES ('Here Comes the Sun');
INSERT INTO albums (title) VALUES ('Fodder on My Wings');
INSERT INTO albums (title) VALUES ('Ring Ring');
TRUNCATE TABLE artists RESTART IDENTITY;
INSERT INTO artists (name, genre) VALUES ('Pixies', 'Rock');
INSERT INTO artists(name, genre) VALUES ('ABBA', 'Pop');
INSERT INTO artists (name, genre) VALUES ('Taylor Swift', 'Pop');
INSERT INTO artists (name, genre) VALUES ('Nina Simone' ,'Pop');
