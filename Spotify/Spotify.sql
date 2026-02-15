-- SQL project on spotify data from Kaggle --
-- Create Table	
DROP TABLE IF EXISTS spotify;
CREATE TABLE spotify (
    artist VARCHAR(255),
    track VARCHAR(255),
    album VARCHAR(255),
    album_type VARCHAR(50),
    danceability FLOAT,
    energy FLOAT,
    loudness FLOAT,
    speechiness FLOAT,
    acousticness FLOAT,
    instrumentalness FLOAT,
    liveness FLOAT,
    valence FLOAT,
    tempo FLOAT,
    duration_min FLOAT,
    title VARCHAR(255),
    channel VARCHAR(255),
    views FLOAT,
    likes BIGINT,
    comments BIGINT,
    licensed BOOLEAN,
    official_video BOOLEAN,
    stream BIGINT,
    energy_liveness FLOAT,
    most_played_on VARCHAR(50)
);

-- Exploratory data analysis
SELECT count(*) FROM spotify;
--
SELECT count( DISTINCT(artist) )FROM spotify;
--
SELECT duration_min FROM spotify
WHERE duration_min = 0;
--
DELETE FROM spotify
WHERE duration_min = 0;
SELECT duration_min FROM spotify
WHERE duration_min = 0;
--
SELECT * FROM spotify
WHERE views = 0;

-- Data analysis
-- Retrieve the names of all tracks that have more than 1 billion streams.
SELECT
	DISTINCT track
FROM spotify
WHERE stream > 1000000000;

-- List all albums along with their respective artists.
SELECT
	DISTINCT album,
	artist
FROM spotify
ORDER BY 1;

-- Get the total number of comments for tracks where licensed = TRUE.
SELECT
	track,
	sum(comments) as total_comments
FROM spotify
WHERE licensed = TRUE
GROUP BY track;

-- Find all tracks that belong to the album type single.
SELECT
	DISTINCT track,
	album_type
FROM spotify
WHERE album_type = 'single';

-- Count the total number of tracks by each artist.
SELECT 
	artist,
	count(track) as total_tracks
FROM spotify
GROUP BY artist
ORDER BY 2;

-- Calculate the average danceability of tracks in each album.
SELECT
	track,
	ROUND(AVG(danceability)::numeric, 2) AS AVG_danceability
FROM spotify
GROUP BY 1
ORDER BY 2;

-- Find the top 5 tracks with the highest energy values.
SELECT
	DISTINCT track,
	energy
FROM spotify
ORDER BY 2 DESC
LIMIT 5;

-- List all tracks along with their views and likes where official_video = TRUE.
SELECT
	track,
	SUM(views) AS total_views,
	SUM(likes) AS total_likes
FROM spotify
WHERE official_video = TRUE
GROUP BY 1
ORDER BY 2 DESC;

-- For each album, calculate the total views of all associated tracks.
SELECT
	album,
	track,
	SUM(views) AS total_views
FROM spotify
GROUP BY 1,2
ORDER BY 3 DESC;

-- Retrieve the track names that have been streamed on Spotify more than YouTube.
SELECT * FROM
(SELECT 
	track,
	SUM(stream) FILTER(WHERE most_played_on = 'Youtube') as stream_youtube,
	SUM(stream) FILTER(WHERE most_played_on = 'Spotify') as stream_spotify
FROM spotify
GROUP BY 1 ) AS t1
WHERE stream_spotify > stream_youtube
AND stream_youtube <> 0;


-- Find the top 3 most-viewed tracks for each artist using window functions.
SELECT * FROM 
(SELECT 
	artist,
	track,
	SUM(views) as total_view,
	DENSE_RANK() OVER(PARTITION BY artist ORDER BY SUM(views) DESC) as rank
FROM spotify
GROUP BY 1,2
ORDER BY 1,3 DESC) AS t
WHERE rank <=3;

-- Use a WITH clause to calculate the difference between the 
-- highest and lowest energy values for tracks in each album.
WITH CTE 
AS 
	(SELECT
	album,
	MAX(energy) as highest_energy,
	MIN(energy) as lowest_energy
FROM spotify
GROUP BY 1) 
SELECT 
	album,
	highest_energy - lowest_energy AS energy_diff
FROM CTE
ORDER BY 2 DESC;

-- Find tracks where the energy-to-liveness ratio is greater than 1.2.
SELECT track, 
		(Avg_Eng / Avg_Liv) AS EL_Ratio
FROM 
(SELECT
	track,
	AVG(energy) AS Avg_Eng,
	AVG(liveness) AS Avg_Liv
FROM spotify
GROUP BY 1) AS T
ORDER BY 2;

-- Calculate the cumulative sum of likes for tracks ordered by the number of views, using window functions.
SELECT 
	track,
	views,
	likes,
	SUM(likes) OVER(ORDER BY views DESC) as cumulative_likes
FROM spotify;

