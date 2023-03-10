-- SELECT EXERCISES 
-- Under the Basic Statements Instruction 

SHOW DATABASES;

-- Exercise 2
/*
Create a new file called select_exercises.sql. 
*/

USE albums_db;

-- Exercise 3
/*
Explore the structure of the albums table.
*/

DESCRIBE albums;
EXPLAIN albums;
-- Fields:
-- id, type: INT UNSIGNED, NO NULL, Primary Key, auto_increment
-- artist, type: varchar(240), NULL
-- name, varchar(240), NO NULL
-- release_date, type: int, NULL
-- sales, type: float, NULL
-- genre, type: varchar(240), NULL
-- Takeaway:  There are multiple genres that could be associated with each album.

SELECT * FROM albums;
SELECT COUNT(*) as total_id
FROM albums;

-- a. How many rows are in the albums table?
-- There are 31 rows in the albums tables.

-- How many unique artist names are in the albums table?
SELECT DISTINCT artist
FROM albums;

SELECT artist FROM albums; 

SELECT DISTINCT artist
FROM albums;
-- There are 23 unique artists

-- c. What is the primary key for the albums table?
-- id, type: INT UNSIGNED, NO NULL, Primary Key, auto_increment

-- d. What is the oldest release date for any album in the albums table? What is the most recent release date?

SELECT * FROM albums;
-- After running this, I ordered the release_date to oldest to most recent and found...
-- The oldest release date is 1967.
-- Ordered it by the most recent and found...
-- The most recent release date is 2011.
-- Could have used (min() function, ORDER BY, GUI sort*)

SELECT max(release_date) FROM albums;
SELECT min(release_date) FROM albums;
SELECT min(release_date), max(release_date) FROM albums;

/*
Exercise 4
-- Write queries to find the following information:
-- a. The name of all albums by Pink Floyd 
*/

SELECT * FROM albums WHERE artist = 'Pink Floyd';
-- All albums by Pink Floyd are 'The Dark Side of the Moon" and "The Wall"

-- b. The year Sgt. Pepper's Lonely Hearts Club Band was released
SELECT release_date FROM albums WHERE name LIKE '%Lonely Hearts Club Band%';
-- The year this album was released was 1967.
-- Could also do this...
SELECT release_date FROM albums WHERE name = "Sgt. Pepper's Lonely Hearts Club Band";
SELECT release_date FROM albums WHERE name = 'Sgt. Pepper\'s Lonely Hearts Club Band'; -- '\' is an escape key; telling SQL to ignore the next character

-- c. The genre for the album Nevermind
SELECT genre FROM albums WHERE name = 'Nevermind';
-- The genre is Grunge, Alternative rock.

-- d. Which albums were released in the 1990s
SELECT name FROM albums WHERE release_date between 1990 and 1999;
/* The albums which were released in the 1990s are:
Come On Over
Dangerous
Falling into You
Jagged Little Pill
Let's Talk About Love
Metallica
Nevermind
Supernatural
The Bodyguard
The Immaculate Collection
Titanic: Music from the Motion Picture
*/

-- e. Which albums had less than 20 million certified sales
SELECT name FROM albums WHERE sales < 20;
/* The albums that had sales less than 20 million are:
Grease: The Original Soundtrack from the Motion Picture
Bad
Sgt. Pepper's Lonely Hearts Club Band
Dirty Dancing
Let's Talk About Love
Dangerous
The Immaculate Collection
Abbey Road
Born in the U.S.A.
Brothers in Arms
Titanic: Music from the Motion Picture
Nevermind
The Wall
*/

-- f. All the albums with a genre of "Rock". Why do these query results not include albums with a genre of "Hard rock" or "Progressive rock"?
SELECT name FROM albums where genre = 'Rock';
/* The albums under the genre of Rock include:
Sgt. Pepper's Lonely Hearts Club Band
1
Abbey Road
Born in the U.S.A.
Supernatural
*/

/* This query does not include the genres "Hard rock" nor "Progressive rock" because I specified specifically to onlt return "Rock". If I wanted it return all albums with "rock" in the genre it would look like this...
*/

SELECT 
	name,
	genre
FROM albums WHERE genre LIKE '%rock%';

-- OR specifically just "Rock", "Progressive rock", and/or "Hard rock".

SELECT 
	name,
	genre
FROM albums WHERE genre = 'Rock'
	OR genre = 'Progressive rock'
	OR genre = 'Hard rock';

/* This returns:
Back in Black	Hard rock
The Dark Side of the Moon	Progressive rock
Sgt. Pepper's Lonely Hearts Club Band	Rock
1	Rock
Abbey Road	Rock
Born in the U.S.A.	Rock
The Wall	Progressive rock
Supernatural	Rock
Appetite for Destruction	Hard rock
*/

-- FIN

