/* Curry played well in his rookie year but was not a game changer yet. I wanted to discover his "evolution" from the data. */
SELECT TOP 3 *
FROM [NBA Database].[dbo].[player_totals]
WHERE player = 'Stephen Curry'

SELECT TOP 3 *
FROM [NBA Database].[dbo].[per_100_poss]
WHERE player = 'Stephen Curry'

SELECT TOP 3 *
FROM [NBA Database].[dbo].[player_shooting]
WHERE player = 'Stephen Curry'

SELECT TOP 3 *
FROM [NBA Database].[dbo].[player_per_game]
WHERE player = 'Stephen Curry'

SELECT TOP 3 *
FROM [NBA Database].[dbo].[player_play_by_play]
WHERE player = 'Stephen Curry'

-- Abrbeviation for following table
-- fg = field goals
-- fga = field goal attempts

SELECT season,
	experience,
	g AS game,
	gs AS game_started,
	ROUND(mp/g,0) AS average_minutes_played,
	pts AS points,
	ROUND(pts/g,0) AS average_points_per_game,
	fg,
	fga,
	fg_percent,
	x3p AS '3_point_fg',
	x3pa AS '3_point_fga',
	x3p_percent AS '3_point_fg_percent',
	x2p AS '2_point_fg',
	x2pa AS '2_point_fga',
	x2p_percent AS '2_point_fg_percent',
	ft AS free_throw,
	fta AS free_throw_attempt,
	ft_percent AS free_throw_percent,
	orb AS offensive_rebound,
	drb AS defensive_rebound,
	trb AS total_rebound,
	ast AS assist,
	stl AS steal,
	blk AS 'block',
	tov AS turnover,
	pf AS personal_foul
INTO curry_totals
FROM [NBA Database].[dbo].[player_totals]
WHERE player = 'Stephen Curry'
ORDER BY season

/*
From the table, Curry played less games in season 2012, 2018, 2019, 2020, 2021 and 2022 while usually there are 82 games in regular season. 
I then searched online for reasons he missed the games.
1. Stephen Curry injuries - NBA. Stephen Curry Injuries - NBA | FOX Sports. (n.d.).
Retrieved February 24, 2023, from https://www.foxsports.com/nba/stephen-curry-player-injuries
2. Salao, R. P. (2020, June 27). Timeline of Stephen Curry's injuries over his NBA career. ClutchPoints. 
Retrieved February 24, 2023, from https://clutchpoints.com/timeline-of-stephen-curry-injuries-over-his-nba-career

- In 2012, he played only 26 games due to multiple sprained ankles.
- In 2018, He dealt with a few ankle injuries again.
- In 2020, He broke his left wrist in the fourth game.
- In 2021, each team played 72 regular season games only.
- In 2022, he suffered a sprained ligament in his left foot.
*/

-- overview of table
SELECT *
FROM curry_totals
ORDER BY season

-- overview of Curry's career
SELECT ROUND(AVG(game),0) AS average_game_played,
SUM(game) AS total_game_played,
ROUND(AVG(game_started),0) AS average_game_started,
SUM(game_started) AS total_game_started,
ROUND(AVG(average_minutes_played),0) AS average_minutes_played,
SUM(average_minutes_played*game) AS total_minutes_played,
ROUND(AVG(average_points_per_game),0) AS average_points_per_game,
SUM(points) AS total_points
FROM curry_totals

SELECT season,
game,
average_points_per_game,
average_points_per_game - lag(average_points_per_game) OVER (ORDER BY season) AS points_improvement,
fg,
fg - lag(fg) OVER (ORDER BY season) AS fg_improvement,
fga,
fga - lag(fga) OVER (ORDER BY season) AS fga_change,
FORMAT(ROUND(fg_percent,2),'P0') AS fg_percent,
FORMAT(ROUND(fg_percent - lag(fg_percent) OVER (ORDER BY season),3),'P0') AS fg_percent_improvement
FROM curry_totals
WHERE season <> '2012' AND season <> '2020'
ORDER BY season

/*
According to the table, Curry scored 23 per game averagely in 2013, 4 more points comparing to 2011. It is because he had more attempts only. 
In fact, he had lower field goal percentage. However, in the next 2 years, his field goal percentage kept improving with similar attempts. I 
think the year of his evolution may be 2016, he had average 30 points per game with 50% field goal percentage. For the following years, his 
performance fell back a little bit. In 2021, he reproduced his evolution with average 32 points per game with 48% field goal 
percentage. He fell back again in 2022. In current season, it seems that he is trying to reproduce his evolution again.
*/

-- overview of Curry's shooting
SELECT season,
	avg_dist_fga AS average_distance_of_fga,
	FORMAT(percent_fga_from_x2p_range,'P0') AS '2_point_fga_percent',
	FORMAT(percent_fga_from_x0_3_range,'P0') AS 'fga_percent (0-3 ft. from basket)',
	FORMAT(percent_fga_from_x3_10_range,'P0') AS 'fga_percent (3-10 ft. from basket)',
	FORMAT(percent_fga_from_x10_16_range,'P0') AS 'fga_percent (10-16 ft. from basket)',
	FORMAT(percent_fga_from_x16_3p_range,'P0') AS 'fga_percent (>16 ft. from basket)',
	FORMAT(percent_fga_from_x3p_range,'P0') AS '3_point_fga_percent',
	FORMAT(fg_percent_from_x2p_range,'P0') AS '2_point_fg_percent',
	FORMAT(fg_percent_from_x0_3_range,'P0') AS 'fg_percent (0-3 ft. from basket)',
	FORMAT(fg_percent_from_x3_10_range,'P0') AS 'fg_percent (3-10 ft. from basket)',
	FORMAT(fg_percent_from_x10_16_range,'P0') AS 'fg_percent (10-16 ft. from basket)',
	FORMAT(fg_percent_from_x16_3p_range,'P0') AS 'fg_percent (>16 ft. from basket)',
	FORMAT(fg_percent_from_x3p_range,'P0') AS '3_point_fg_percent',
	FORMAT(percent_assisted_x2p_fg,'P0') AS 'assisted_2_point_fg_percent',
	FORMAT(percent_assisted_x3p_fg,'P0') AS 'assisted_3_point_fg_percent',
	num_of_dunks,
	FORMAT(percent_corner_3s_of_3pa,'P0') AS corner_3_point_fga_percent,
	FORMAT(corner_3_point_percent,'P0') AS corner_3_point_fg_percent,
	num_heaves_attempted,
	num_heaves_made
FROM [NBA Database].[dbo].[player_shooting]
WHERE player = 'Stephen Curry'
	AND season <> '2012' AND season <> '2020'

-- average shooting distance trend 
SELECT AVG(avg_dist_fga) AS average_distance_of_fga
FROM [NBA Database].[dbo].[player_shooting]
WHERE player = 'Stephen Curry'
	AND season <> '2010' AND season <> '2011' AND season <> '2012' AND season <> '2020'

-- 2_&_3_point_fga_percent trend
SELECT season,
    FORMAT(percent_fga_from_x2p_range,'P0') AS '2_point_fga_percent',
    FORMAT(ROUND(percent_fga_from_x2p_range - LAG(percent_fga_from_x2p_range) OVER (ORDER BY season),3),'P0') AS '2_point_fga_percent_chg',
	FORMAT(percent_fga_from_x3p_range,'P0') AS '3_point_fga_percent',
    FORMAT(ROUND(percent_fga_from_x3p_range - LAG(percent_fga_from_x3p_range) OVER (ORDER BY season),3),'P0') AS '3_point_fga_percent_chg'
FROM [NBA Database].[dbo].[player_shooting]
WHERE player = 'Stephen Curry'
    AND season <> '2012' AND season <> '2020'
ORDER BY season

-- overview of fga in different 2 point shooting distance
SELECT FORMAT(MAX(percent_fga_from_x0_3_range),'P0') AS 'max_fga_percent (0-3 ft. from basket)',
FORMAT(MIN(percent_fga_from_x0_3_range),'P0') AS 'min_fga_percent (0-3 ft. from basket)',
FORMAT(MAX(percent_fga_from_x0_3_range)-MIN(percent_fga_from_x0_3_range),'P0') AS 'range_fga_percent (0-3 ft. from basket)',
FORMAT(AVG(percent_fga_from_x0_3_range),'P0') AS 'average_fga_percent (0-3 ft. from basket)',
FORMAT(STDEV(percent_fga_from_x0_3_range),'P0') AS 'stdev_fga_percent (0-3 ft. from basket)'
FROM [NBA Database].[dbo].[player_shooting]
WHERE player = 'Stephen Curry'
    AND season <> '2012' AND season <> '2020'

SELECT FORMAT(MAX(percent_fga_from_x3_10_range),'P0') AS 'max_fga_percent (3-10 ft. from basket)',
FORMAT(MIN(percent_fga_from_x3_10_range),'P0') AS 'min_fga_percent (3-10 ft. from basket)',
FORMAT(MAX(percent_fga_from_x3_10_range)-MIN(percent_fga_from_x3_10_range),'P0') AS 'range_fga_percent (3-10 ft. from basket)',
FORMAT(AVG(percent_fga_from_x3_10_range),'P0') AS 'average_fga_percent (3-10 ft. from basket)',
FORMAT(STDEV(percent_fga_from_x3_10_range),'P0') AS 'stdev_fga_percent (3-10 ft. from basket)'
FROM [NBA Database].[dbo].[player_shooting]
WHERE player = 'Stephen Curry'
    AND season <> '2012' AND season <> '2020'

SELECT FORMAT(MAX(percent_fga_from_x10_16_range),'P0') AS 'max_fga_percent (10-16 ft. from basket)',
FORMAT(MIN(percent_fga_from_x10_16_range),'P0') AS 'min_fga_percent (10-16 ft. from basket)',
FORMAT(MAX(percent_fga_from_x10_16_range)-MIN(percent_fga_from_x10_16_range),'P0') AS 'range_fga_percent (10-16 ft. from basket)',
FORMAT(AVG(percent_fga_from_x10_16_range),'P0') AS 'average_fga_percent (10-16 ft. from basket)',
FORMAT(STDEV(percent_fga_from_x10_16_range),'P0') AS 'stdev_fga_percent (10-16 ft. from basket)'
FROM [NBA Database].[dbo].[player_shooting]
WHERE player = 'Stephen Curry'
    AND season <> '2012' AND season <> '2020'

SELECT FORMAT(MAX(percent_fga_from_x16_3p_range),'P0') AS 'max_fga_percent (>16 ft. from basket)',
FORMAT(MIN(percent_fga_from_x16_3p_range),'P0') AS 'min_fga_percent (>16 ft. from basket)',
FORMAT(MAX(percent_fga_from_x16_3p_range)-MIN(percent_fga_from_x16_3p_range),'P0') AS 'range_fga_percent (>16 ft. from basket)',
FORMAT(AVG(percent_fga_from_x16_3p_range),'P0') AS 'average_fga_percent (>16 ft. from basket)',
FORMAT(STDEV(percent_fga_from_x16_3p_range),'P0') AS 'stdev_fga_percent (>16 ft. from basket)'
FROM [NBA Database].[dbo].[player_shooting]
WHERE player = 'Stephen Curry'
    AND season <> '2012' AND season <> '2020'

SELECT season,
	FORMAT(percent_fga_from_x2p_range,'P0') AS '2_point_fga_percent',
	FORMAT(percent_fga_from_x0_3_range,'P0') AS 'fga_percent (0-3 ft. from basket)',
	FORMAT(percent_fga_from_x3_10_range,'P0') AS 'fga_percent (3-10 ft. from basket)',
	FORMAT(percent_fga_from_x10_16_range,'P0') AS 'fga_percent (10-16 ft. from basket)',
	FORMAT(percent_fga_from_x16_3p_range,'P0') AS 'fga_percent (>16 ft. from basket)',
	FORMAT(percent_fga_from_x3p_range,'P0') AS '3_point_fga_percent'
FROM [NBA Database].[dbo].[player_shooting]
WHERE player = 'Stephen Curry'
	AND season <> '2012' AND season <> '2020'
ORDER BY season

/* By observation of the tables:
1. His average shooting distance is around 16 ft. from the basket in the first two years and increases to 18.6 ft. for his entire career.
2. His 2-point field goal attempt has a downward trend from 68% in 2011 to only 39% in 2022. In contrast, his 3-point field goal attempt has a upward trend from 33% in 2011 to 61% in 2022
3. For 2 points, he has the highest shooting percentage for both 0-3 ft. from the basket and 16ft. to 3-point, and the lowest shooting percentage is 10-16 ft. from the basket.
4. He has greatly reduced shooting percentage of 0-3 ft. from the basket and especially for 16ft. to 3-point. (from 29% in 2010 to 8% in 2023).
*/

-- overview of fg_percent of different point shooting distance
SELECT FORMAT(AVG(fg_percent_from_x2p_range),'P0') AS 'avg_2_point_fg_percent',
	FORMAT(AVG(fg_percent_from_x0_3_range),'P0') AS 'avg_fg_percent (0-3 ft. from basket)',
	FORMAT(AVG(fg_percent_from_x3_10_range),'P0') AS 'avg_fg_percent (3-10 ft. from basket)',
	FORMAT(AVG(fg_percent_from_x10_16_range),'P0') AS 'avg_fg_percent (10-16 ft. from basket)',
	FORMAT(AVG(fg_percent_from_x16_3p_range),'P0') AS 'avg_fg_percent (>16 ft. from basket)',
	FORMAT(AVG(fg_percent_from_x3p_range),'P0') AS 'avg_3_point_fg_percent'
FROM [NBA Database].[dbo].[player_shooting]
WHERE player = 'Stephen Curry'
	AND season <> '2012' AND season <> '2020'

SELECT season,
	FORMAT(fg_percent_from_x2p_range,'P0') AS '2_point_fg_percent',
	FORMAT(fg_percent_from_x2p_range-LAG(fg_percent_from_x2p_range) OVER (ORDER BY season),'P0') AS '2_point_fg_percent_chg',
	FORMAT(fg_percent_from_x0_3_range,'P0') AS 'fg_percent (0-3 ft. from basket)',
	FORMAT(fg_percent_from_x0_3_range-LAG(fg_percent_from_x0_3_range) OVER (ORDER BY season),'P0') AS 'fg_percent_chg (0-3 ft. from basket)',
	FORMAT(fg_percent_from_x3_10_range,'P0') AS 'fg_percent (3-10 ft. from basket)',
	FORMAT(fg_percent_from_x3_10_range-LAG(fg_percent_from_x3_10_range) OVER (ORDER BY season),'P0') AS 'fg_percent_chg (3-10 ft. from basket)',
	FORMAT(fg_percent_from_x10_16_range,'P0') AS 'fg_percent (10-16 ft. from basket)',
	FORMAT(fg_percent_from_x10_16_range-LAG(fg_percent_from_x10_16_range) OVER (ORDER BY season),'P0') AS 'fg_percent_chg (10-16 ft. from basket)',
	FORMAT(fg_percent_from_x16_3p_range,'P0') AS 'fg_percent (>16 ft. from basket)',
	FORMAT(fg_percent_from_x16_3p_range-LAG(fg_percent_from_x16_3p_range) OVER (ORDER BY season),'P0') AS 'fg_percent_chg (>16 ft. from basket)',
	FORMAT(fg_percent_from_x3p_range,'P0') AS '3_point_fg_percent',
	FORMAT(fg_percent_from_x3p_range-LAG(fg_percent_from_x3p_range) OVER (ORDER BY season),'P0') AS '3_point_fg_percent_chg'
FROM [NBA Database].[dbo].[player_shooting]
WHERE player = 'Stephen Curry'
	AND season <> '2012' AND season <> '2020'

SELECT season,
	FORMAT(percent_assisted_x2p_fg,'P0') AS 'assisted_2_point_fg_percent',
	FORMAT(percent_assisted_x3p_fg,'P0') AS 'assisted_3_point_fg_percent',
	num_of_dunks,
	FORMAT(percent_corner_3s_of_3pa,'P0') AS corner_3_point_fga_percent,
	FORMAT(corner_3_point_percent,'P0') AS corner_3_point_fg_percent,
	num_heaves_attempted,
	num_heaves_made
FROM [NBA Database].[dbo].[player_shooting]
WHERE player = 'Stephen Curry'
	AND season <> '2012' AND season <> '2020'
ORDER BY season

SELECT FORMAT(AVG(percent_assisted_x2p_fg),'P0') AS 'avg_assisted_2_point_fg_percent',
	FORMAT(AVG(percent_assisted_x3p_fg),'P0') AS 'avg_assisted_3_point_fg_percent',
	SUM(num_of_dunks) AS total_of_dunks,
	FORMAT(AVG(percent_corner_3s_of_3pa),'P0') AS avg_corner_3_point_fga_percent,
	FORMAT(AVG(corner_3_point_percent),'P0') AS avg_corner_3_point_fg_percent,
	SUM(num_heaves_attempted) AS total_of_heaves_attempted,
	SUM(num_heaves_made) AS total_of_heaves_made
FROM [NBA Database].[dbo].[player_shooting]
WHERE player = 'Stephen Curry'
	AND season <> '2012' AND season <> '2020'

/* By observation of the tables:
1. He has a 65% of the field goal percentage 0-3 ft. away from the basket. In other positions, he has ~45% of field goal percentage.
2. Except for 2010, he has 2 point field goal percentage above 50% and even 60% in 2018.
3. Except for 2013, he has a higher than 60% field goal percentage 0-3 ft. away from the basket and even above 70% in 2016 and 2023.
4. Except for 2010 and 2013, he has a higher than 40% field goal percentage 3-10 ft. away from the basket and even above 50% since 2021.
5. Except for 2010 and 2011, he has a higher than 40% field goal percentage 10-16 ft. away from the basket and even above 50% for some of the years.
6. Except for 2015, he has higher than 40% field goal percentage more than 16 ft. away from the basket and even above 60% in 2018.
7. Except for 2022, he always has 3 point field goal percentage higher than 40%.
8. From 2010-2014, his average assisted 2-point field goal percentage is around 25%, which increased to around 40% since 2017.
9. For 2010 & 2011, his average assisted 3-point field goal percentage is 77% which decreased to around 60% afterward.
10. Unlike some of the shooters, he only shoots 13% of 3-point at the corner. In fact, he has 48% of field goal at that position.

In conclusion, he had lower field goal attempts and percentage in 2010 and 2011. In 2013, he had more attempts, especially in 3 points, but lower 
field goal percentage. Starting from 2014, his field goal percentage is improved and even make more 3 point attempts. With high 3 point attempts 
and field goal percentage, he certainly has defined this era of basketball with the way he has left his imprint on the game. */