/* I want to study the contribution of Stephen Curry to the team */

SELECT *
FROM [NBA Database].[dbo].team_abbrev
WHERE abbreviation = 'GSW'
	AND season >= 2010
ORDER BY season

-- After Curry joins GSW
SELECT COUNT(season) AS num_of_seasons,
	COUNT(CASE WHEN playoffs = '1' THEN 1 END) AS num_of_seasons_into_playoff
FROM [NBA Database].[dbo].team_abbrev
WHERE abbreviation = 'GSW'
	AND season >= 2010

-- Before Curry joins GSW
SELECT COUNT(season) AS num_of_seasons,
	COUNT(CASE WHEN playoffs = '1' THEN 1 END) AS num_of_seasons_into_playoff
FROM [NBA Database].[dbo].team_abbrev
WHERE abbreviation = 'GSW'
	AND season < 2010

/* From the tables, GSW only enters playoffs for less than 30% of seasons before Curry joins and increase to over 50% after that. */

-- Abrbeviation of the data set
-- Margin of victory(mov): mov = pts - opp pts
-- Strength of schedule(sos): A rating of strength of schedule. The rating is denominated in points above/below average, where zero is average.
-- Simple rating system: A rating that takes into account average point differential and strength of schedule.
-- Offensive rating: For players and teams it is points scored per 100 possessions
-- Defensive rating: For players and teams it is points allowed per 100 posessions
-- Net rating: offensive - defensive rating
-- Pace: Pace factor is an estimate of the number of possessions per 48 minutes by a team.
-- True shooting percentage(ts_percent): A measure of shooting efficiency that takes into account field goals, 3-point field goals, and free throws.
-- Effective Field Goal Percentage(e_fg_percent): This statistic adjusts for the fact that a 3-point field goal is worth one more point than a 2-point field goal.

-- organize GSW totals
SELECT season,
	playoffs,
	g AS games,
	fg,
	fga,
	fg_percent,
	x3p AS '3_point',
	x3pa AS '3_point_attempt',
	x3p_percent AS '3_point_percent',
	x2p AS '2_point',
	x2pa AS '2_point_attempt',
	x2p_percent AS '2_point_percent',
	ft AS free_throw,
	ft AS free_throw_attempt,
	ft_percent AS free_throw_percent,
	orb AS offensive_rebound,
	drb AS defensive_rebound,
	trb AS total_rebound,
	ast,
	stl,
	blk,
	tov,
	pf,
	pts
INTO gsw_totals
FROM [NBA Database].[dbo].team_totals
WHERE abbreviation = 'GSW'
 AND season BETWEEN '2010' AND '2023'
ORDER BY season

SELECT *
FROM gsw_totals
WHERE season BETWEEN '2010' AND '2023'
 AND season <> '2012' AND season <> '2020'
ORDER BY season

SELECT *
FROM curry_totals
WHERE season BETWEEN '2010' AND '2023'
 AND season <> '2012' AND season <> '2020'
ORDER BY season

-- Join tables to examine Curry's contribution
SELECT gsw.season,
	gsw.playoffs,
	gsw.games AS games,
	curry.game AS curry_played,
	gsw.fg AS team_fg,
	curry.fg AS curry_fg,
	ROUND(curry.fg/gsw.fg,2) AS field_goal_ratio,
	gsw.fga AS team_fga,
	curry.fga AS curry_fga,
	ROUND(curry.fga/gsw.fga,2) AS field_goal_attempt_ratio,
	gsw.fg_percent AS team_fg_percent,
	curry.fg_percent AS curry_fg_percent
INTO curry_contribution
FROM gsw_totals AS gsw
INNER JOIN curry_totals AS curry
ON gsw.season = curry.season
ORDER BY season

SELECT *
FROM curry_contribution
ORDER BY season

SELECT ROUND(AVG(team_fg/games),0) AS team_fg_per_game,
	ROUND(AVG(curry_fg/curry_played),0) AS curry_fg_per_game,
	ROUND(AVG(curry_fg/curry_played)/AVG(team_fg/games),2) AS fg_ratio,
	ROUND(AVG(team_fga/games),0) AS team_fga_per_game,
	ROUND(AVG(curry_fga/curry_played),0) AS curry_fga_per_game,
	ROUND(AVG(curry_fga/curry_played)/AVG(team_fga/games),2) AS fga_ratio,
	ROUND(AVG(team_fg_percent),2) AS avg_team_fg_percent,
	ROUND(AVG(curry_fg_percent),2) AS avg_curry_fg_percent
FROM curry_contribution

SELECT ROUND(AVG(team_fg_percent),2) AS avg_team_fg_percent,
	ROUND(AVG(curry_fg_percent),2) AS avg_curry_fg_percent
FROM curry_contribution
WHERE season <> '2012' OR season <> '2020'

SELECT ROUND(AVG(team_fg_percent),2) AS avg_fg_percent
FROM curry_contribution
WHERE season = '2012' OR season = '2020'

/* Based on the tables:
1. Curry attempts and makes 20% field goals of the team.
2. Both Curry and the team have field goal percentage around 47%.
3. For his first 2 years, GSW cannot entered the playoff.
4. When Curry injuried in 2012 and 2020 and missed most of the games, GSW didn't enter the playoff while team field goal percentage decreased slightly from 47% to 45%.
*/

-- Examine Curry's contribution in 3 point
SELECT gsw.season,
	gsw.playoffs,
	gsw.games AS games,
	curry.game AS curry_played,
	gsw.[3_point] AS team_3_point,
	curry.[3_point_fg] AS curry_3_point,
	ROUND(curry.[3_point_fg]/gsw.[3_point],2) AS '3_point_ratio',
	gsw.[3_point_attempt] AS team_3_point_fga,
	curry.[3_point_fga] AS curry_3_point_fga,
	ROUND(curry.[3_point_fga]/gsw.[3_point_attempt],2) AS '3_point_fga_ratio',
	gsw.[3_point_percent] AS team_3_point_percent,
	curry.[3_point_fg_percent] AS curry_3_point_percent
INTO curry_contribution_3_point
FROM gsw_totals AS gsw
INNER JOIN curry_totals AS curry
ON gsw.season = curry.season
ORDER BY season

SELECT ROUND(AVG(team_3_point),0) AS avg_team_3_point,
	ROUND(AVG(curry_3_point),0) AS avg_curry_3_point,
	ROUND(AVG([3_point_ratio]),2) AS avg_3_point_ratio,
	ROUND(AVG(team_3_point_fga),0) AS avg_team_3_point_attempt,
	ROUND(AVG(curry_3_point_fga),0) AS avg_curry_3_point_attempt,
	ROUND(AVG([3_point_fga_ratio]),2) AS avg_3_point_attempt_ratio,
	ROUND(AVG(team_3_point_percent),2) AS avg_team_3_point_percent,
	ROUND(AVG(curry_3_point_percent),2) AS avg_curry_3_point_percent
FROM curry_contribution_3_point
WHERE season <> '2012' AND season <> '2020'

SELECT ROUND(AVG(team_3_point),0) AS avg_team_3_point,
	ROUND(AVG(team_3_point_fga),0) AS avg_team_3_point_attempt,
	ROUND(AVG(team_3_point_percent),2) AS avg_team_3_point_percent
FROM curry_contribution_3_point
WHERE season = '2012' OR season = '2020'

/* From the tables, it proved the importance of Curry's 3 point to GSW.:
1. Curry shoots 27% and hits 30% 3-point of the whole team. He has an average 43% 3-point percentage which is higher than the team's (39%).
2. The average team 3-point percentage further dropped to 36% in 2012 and 2020 when Curry was injured.
*/

-- Examine Curry's contribution in 2 point
SELECT gsw.season,
	gsw.playoffs,
	gsw.games AS games,
	curry.game AS curry_played,
	gsw.[2_point] AS team_2_point,
	curry.[2_point_fg] AS curry_2_point,
	ROUND(curry.[2_point_fg]/gsw.[2_point],2) AS '2_point_ratio',
	gsw.[2_point_attempt] AS team_2_point_fga,
	curry.[2_point_fga] AS curry_2_point_fga,
	ROUND(curry.[2_point_fga]/gsw.[2_point_attempt],2) AS '2_point_fga_ratio',
	gsw.[2_point_percent] AS team_2_point_percent,
	curry.[2_point_fg_percent] AS curry_2_point_percent
INTO curry_contribution_2_point
FROM gsw_totals AS gsw
INNER JOIN curry_totals AS curry
ON gsw.season = curry.season

SELECT ROUND(AVG(team_2_point),0) AS avg_team_2_point,
	ROUND(AVG(curry_2_point),0) AS avg_curry_2_point,
	ROUND(AVG([2_point_ratio]),2) AS avg_2_point_ratio,
	ROUND(AVG(team_2_point_fga),0) AS avg_team_2_point_attempt,
	ROUND(AVG(curry_2_point_fga),0) AS avg_curry_2_point_attempt,
	ROUND(AVG([2_point_fga_ratio]),2) AS avg_2_point_attempt_ratio,
	ROUND(AVG(team_2_point_percent),2) AS avg_team_2_point_percent,
	ROUND(AVG(curry_2_point_percent),2) AS avg_curry_2_point_percent
FROM curry_contribution_2_point
WHERE season <> '2012' AND season <> '2020'

SELECT ROUND(AVG(team_2_point),0) AS avg_team_2_point,
	ROUND(AVG(team_2_point_fga),0) AS avg_team_2_point_attempt,
	ROUND(AVG(team_2_point_percent),2) AS avg_team_2_point_percent
FROM curry_contribution_2_point
WHERE season = '2012' OR season = '2020'

/* From the tables:
1. Curry shoots 14% and hits 14% 3-point of the whole team. He and the team have an average 53% 2-point percentage.
2. The average 2-point percentage of the team was dropped to 49% in 2012 and 2020 when Curry was injured.
Comparing the ratios and field goal percentage, it reveals the importance of Curry's 3 point to GSW. again.
*/

-- Examine Curry's contribution in free throw
SELECT gsw.season,
	gsw.playoffs,
	gsw.games AS games,
	curry.game AS curry_played,
	gsw.free_throw AS team_free_throw,
	curry.free_throw AS curry_free_throw,
	ROUND(curry.free_throw/gsw.free_throw,2) AS free_throw_ratio,
	gsw.free_throw_attempt AS team_free_throw_attempt,
	curry.free_throw_attempt AS curry_free_throw_attempt,
	ROUND(curry.free_throw_attempt/gsw.free_throw_attempt,2) AS free_throw_attempt_ratio,
	gsw.free_throw_percent AS team_free_throw_percent,
	curry.free_throw_percent AS curry_free_throw_percent
INTO curry_contribution_ft
FROM gsw_totals AS gsw
INNER JOIN curry_totals AS curry
ON gsw.season = curry.season
ORDER BY season

SELECT ROUND(AVG(team_free_throw),0) AS avg_team_free_throw,
	ROUND(AVG(curry_free_throw),0) AS avg_curry_free_throw,
	ROUND(AVG(free_throw_ratio),2) AS avg_free_throw_ratio,
	ROUND(AVG(team_free_throw_attempt),0) AS avg_team_free_throw_attempt,
	ROUND(AVG(curry_free_throw_attempt),0) AS avg_curry_free_throw_attempt,
	ROUND(AVG(free_throw_attempt_ratio),2) AS avg_free_throw_attempt_ratio,
	ROUND(AVG(team_free_throw_percent),2) AS avg_team_free_throw_percent,
	ROUND(AVG(curry_free_throw_percent),2) AS avg_curry_free_throw_percent
FROM curry_contribution_ft
WHERE season <> '2012' AND season <> '2020'

SELECT ROUND(AVG(team_free_throw),0) AS avg_team_free_throw,
	ROUND(AVG(team_free_throw_attempt),0) AS avg_team_free_throw_attempt,
	ROUND(AVG(team_free_throw_percent),2) AS avg_team_free_throw_percent
FROM curry_contribution_ft
WHERE season = '2012' OR season = '2020'

/* From the tables:
1. Curry shoots 21% and hits 23% free throws for the whole team. The team has an average 78% free throw percentage while Curry has 91%.
2. The average team free throw percentage was 79% in the year 2012 and 2020 when Curry was injured.
*/
