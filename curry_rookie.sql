/****** Curry Milestone ******/

-- I started watching NBA sometimes around 2011 and watched highlights on Youtube as well. There were highlights of Monta Ellis, who was 
-- Curry's teammate, and Curry are in the vidoes as well. However, I never imagined that little boy can change the game of basketball with 
-- his deep shooting and shift the whole era of guards.

-- overview of Curry
SELECT *
  FROM [NBA Database].[dbo].[player_career_info]
WHERE player LIKE 'Stephen Curry'
-- He started playing since 2010 and this is his 14th seasons.

-- select the data of Monta Ellis and Stephen Curry when they were playing together
SELECT *
INTO curry_and_ellis
FROM [NBA Database].[dbo].[advanced]
WHERE (player = 'Stephen Curry' OR player = 'Monta Ellis') AND
	tm = 'GSW' AND
	season IN (SELECT season
		FROM [NBA Database].[dbo].[advanced]
		WHERE (player = 'Stephen Curry' OR player = 'Monta Ellis') AND tm = 'GSW'
		GROUP BY season
		HAVING COUNT(season)>1
	)
ORDER BY season, experience DESC

-- overview the temporary table
SELECT *
FROM curry_and_ellis
ORDER BY season, experience DESC

-- compare Ellis and Curry stats when they were playing together
SELECT *
FROM (
    SELECT season,
		g - LAG(g) OVER (PARTITION BY season ORDER BY season, experience DESC) AS games,
        ROUND((mp/g) - (LAG(mp) OVER (PARTITION BY season ORDER BY season, experience DESC) / LAG(g) OVER (PARTITION BY season ORDER BY season, experience DESC)),0) AS average_minutes_played,
        ROUND(per - LAG(per) OVER (PARTITION BY season ORDER BY season, experience DESC),2) AS player_efficiency_rating,
        FORMAT(ROUND(ts_percent - LAG(ts_percent) OVER (PARTITION BY season ORDER BY season, experience DESC),2),'P0') AS true_shooting_percentage,
        FORMAT(ROUND(x3p_ar - LAG(x3p_ar) OVER (PARTITION BY season ORDER BY season, experience DESC),2),'P0') AS '3_point_attempt_rate',
        FORMAT(ROUND(f_tr - LAG(f_tr) OVER (PARTITION BY season ORDER BY season, experience DESC),2),'P0') AS 'free_throw_attempt_rate',
        ROUND(orb_percent - LAG(orb_percent) OVER (PARTITION BY season ORDER BY season, experience DESC),2) AS offensive_rebound_percentage,
        ROUND(drb_percent - LAG(drb_percent) OVER (PARTITION BY season ORDER BY season, experience DESC),2) AS defensive_rebound_percentage,
        ROUND(trb_percent - LAG(trb_percent) OVER (PARTITION BY season ORDER BY season, experience DESC),2) AS total_rebound_percentage,
        ROUND(ast_percent - LAG(ast_percent) OVER (PARTITION BY season ORDER BY season, experience DESC),2) AS assist_percentage,
        ROUND(stl_percent - LAG(stl_percent) OVER (PARTITION BY season ORDER BY season, experience DESC),2) AS steal_percentage,
        ROUND(blk_percent - LAG(blk_percent) OVER (PARTITION BY season ORDER BY season, experience DESC),2) AS block_percentage,
        ROUND(tov_percent - LAG(tov_percent) OVER (PARTITION BY season ORDER BY season, experience DESC),2) AS turnover_percentage,
        ROUND(usg_percent - LAG(usg_percent) OVER (PARTITION BY season ORDER BY season, experience DESC),2) AS usage_percentage,
        ROUND(ows - LAG(ows) OVER (PARTITION BY season ORDER BY season, experience DESC),2) AS offensive_win_shares,
        ROUND(dws - LAG(dws) OVER (PARTITION BY season ORDER BY season, experience DESC),2) AS defensive_win_shares,
        ROUND(ws - LAG(ws) OVER (PARTITION BY season ORDER BY season, experience DESC),2) AS win_shares,
        FORMAT(ROUND(ws_48 - LAG(ws_48) OVER (PARTITION BY season ORDER BY season, experience DESC),2),'P0') AS win_shares_per_48_mins,
        ROUND(obpm - LAG(obpm) OVER (PARTITION BY season ORDER BY season, experience DESC),2) AS offensive_box_plus_or_minus,
        ROUND(dbpm - LAG(dbpm) OVER (PARTITION BY season ORDER BY season, experience DESC),2) AS defensive_box_plus_or_minus,
        ROUND(bpm - LAG(bpm) OVER (PARTITION BY season ORDER BY season, experience DESC),2) AS box_plus_or_minus
    FROM curry_and_ellis
) subquery
WHERE games IS NOT NULL

-- From the table, we can find that Curry played more games in 2010 but he played less minutes per game comparing to Monta Ellis in those 3
-- years. Curry had better overall performance on the floor: higher player efficiency rating (except his rookie year), true shooting 
-- percentage, total rebound percentage, assist percentage, win shares, box +/-, similar steal and block percentage.  However, he also had 
-- some shortcomings, for example, higher turnover percenatge and lower usage percentage.

-- It surprised me that Curry has played 80 games in his rookie year (82 games for regular season) with average 36 minutes on the floor.
-- Therefore, I want to know how many rookies played so many games and who they are.
SELECT *
FROM(
	SELECT season,
		player,
		pos,
		experience,
		tm,
		g,
	ROUND(mp/g,0) AS average_minutes_played
	FROM [NBA Database].[dbo].[advanced]
	WHERE experience = 1 AND g >= 80
) subquery
WHERE average_minutes_played >= 36
ORDER BY season

-- Starting from 1965, only 46 rookies including Curry played more than 80 games in their rookie year with average 36 minutes on the floor.