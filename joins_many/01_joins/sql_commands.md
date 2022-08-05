psql -h 127.0.0.1 music_library

# Exercise 1
SELECT albums.id, albums.title
FROM artists JOIN albums
ON albums.artist_id = artists.id
WHERE artists.name = 'Taylor Swift';

# Exercise 2
SELECT albums.id, albums.title
FROM artists JOIN albums
ON albums.artist_id = artists.id
WHERE (artists.name, albums.release_year) = ('Pixies', '1988');

# Challenge
SELECT albums.id AS album_id, albums.title
FROM artists JOIN albums
ON albums.artist_id = artists.id
WHERE artists.name = 'Nina Simone'
AND albums.release_year > '1975';