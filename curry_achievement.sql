/* In this query, I would like to summarize Curry's career performance and compare it to that of other players. */

SELECT season,
player,
g,
gs,
mp,
fg,
fga,
fg_percent,
x3p,
x3pa,
x3p_percent,
x2p,
x2pa,
x2p_percent,
ft,
fta,
ft_percent,
orb,
drb,
trb,
ast,
stl,
blk,
tov,
pf,
pts
FROM [NBA Database].dbo.player_totals

SELECT player,
SUM(g) AS total_games_played,
SUM(pts) AS total_points,
DENSE_RANK () OVER (ORDER BY SUM(pts) DESC) AS point_leaders
FROM [NBA Database].[dbo].player_totals
GROUP BY player

SELECT *
FROM (
	SELECT player,
	SUM(g) AS total_games_played,
	SUM(pts) AS total_points,
	DENSE_RANK () OVER (ORDER BY SUM(pts) DESC) AS point_leaders
	FROM [NBA Database].[dbo].player_totals
	GROUP BY player
) pts_ranking
WHERE player = 'Stephen Curry'

SELECT *,
DENSE_RANK () OVER (ORDER BY avg_points_per_game DESC) AS avg_point_leaders
FROM (
	SELECT player,
	SUM(g) AS total_games_played,
	SUM(pts) AS total_points,
	ROUND(SUM(pts)/SUM(g),0) AS avg_points_per_game,
	DENSE_RANK () OVER (ORDER BY SUM(pts) DESC) AS point_leaders
	FROM [NBA Database].[dbo].player_totals
	GROUP BY player
) avg_pts_ranking
WHERE point_leaders BETWEEN 1 AND 10 OR player = 'Stephen Curry'

/* According to the table, LeBron James is currently the point leader in the league with 38,299 points and has a great chance of 
becoming the all-time point leader. On the other hand, Stephen Curry is ranked 50th with only 21,105 points. However, it's worth 
noting that Curry has played fewer games than the other players in the top 10. Therefore, when ranking average points per game, 
Curry ranks 3rd. */

SELECT *
FROM (
	SELECT player,
	SUM(g) AS total_games_played,
	SUM(fg) AS total_fg,
	SUM(fga) AS total_fga,
	ROUND(SUM(fg)/SUM(fga)*100,2) AS fg_percent,
	DENSE_RANK () OVER (ORDER BY SUM(fg) DESC) AS total_fg_rank,
	DENSE_RANK () OVER (ORDER BY SUM(fg)/SUM(fga) DESC) AS fg_percent_rank
	FROM [NBA Database].dbo.player_totals
	WHERE fga > 0
	GROUP BY player
) players_fg_pct
WHERE player = 'Stephen Curry' OR total_fg_rank BETWEEN 1 AND 10
ORDER BY total_fg_rank

/* According to the table, LeBron James is currently the leader in field goals made in the NBA with 14019, while Stephen Curry 
is ranked 80th with 7222. However, Curry may have made fewer field goals but still has more points overall, possibly due to 
his proficiency in making 3-point shots, which I plan to study further. As for their field goal percentages, it's worth noting 
that this statistic measures a player's efficiency in making shots, rather than just their total number of shots made. 
While I tried to look up their rankings in this category, it seems that neither player is particularly high. */

SELECT TOP 10 *
FROM (
	SELECT player,
	SUM(g) AS total_games_played,
	SUM(fg) AS total_fg,
	SUM(fga) AS total_fga,
	ROUND(SUM(fg)/SUM(fga)*100,2) AS fg_percent,
	DENSE_RANK () OVER (ORDER BY SUM(fg) DESC) AS total_fg_rank,
	DENSE_RANK () OVER (ORDER BY SUM(fg)/SUM(fga) DESC) AS fg_percent_rank
	FROM [NBA Database].dbo.player_totals
	WHERE fga > 0
	GROUP BY player
) players_fg_pct_2
ORDER BY fg_percent_rank

/* As shown, some of the players just made few field goals that there are chances of having 100% fg pecent */

/* I would like to study more about Curry's achievement in 3 pointers */
SELECT *,
total_3_pts - LAG(total_3_pts) OVER (ORDER BY total_3_pts DESC) AS "3_pts_difference"
FROM (
	SELECT player,
	SUM(g) AS total_games_played,
	SUM(x3p) AS total_3_pts,
	ROUND(SUM(x3p)/SUM(g),0) AS avg_3_pts_per_game,
	SUM(x3pa) AS total_3_pts_attempt,
	ROUND(SUM(x3p)/SUM(x3pa)*100,2) AS "3_pts_pct",
	DENSE_RANK () OVER (ORDER BY SUM(x3p) DESC) AS "3_pts_rank"
	FROM [NBA Database].dbo.player_totals
	WHERE x3pa > 0
	GROUP BY player
) players_3_pts
WHERE player = 'Stephen Curry' OR "3_pts_rank" BETWEEN 1 AND 10
ORDER BY "3_pts_rank"

/* According to the table, Curry is already the all-time leader in 3-pointers made with 3,290 and a total percentage of 42.76%. 
He leads the second-place player by 116 3-pointers, and even has more than 1,000 3-pointers than the 10th place player. Among 
the top 10 players besides Curry, only Lillard has played less than 1,000 games and Korver on the 4th has percentage higher 
than 40%. I believe Curry can further extend his record. */

/* I would like to study about Curry's achievement in 2 pointers as well */
SELECT *,
total_2_pts - LAG(total_2_pts) OVER (ORDER BY total_2_pts DESC) AS "2_pts_difference"
FROM (
	SELECT player,
	SUM(g) AS total_games_played,
	SUM(x2p) AS total_2_pts,
	ROUND(SUM(x2p)/SUM(g),0) AS avg_2_pts_per_game,
	SUM(x2pa) AS total_2_pts_attempt,
	ROUND(SUM(x2p)/SUM(x2pa)*100,2) AS "2_pts_pct",
	DENSE_RANK () OVER (ORDER BY SUM(x2p) DESC) AS "2_pts_rank"
	FROM [NBA Database].dbo.player_totals
	WHERE x2pa > 0
	GROUP BY player
) players_2_pts
WHERE player = 'Stephen Curry' OR "2_pts_rank" BETWEEN 1 AND 10
ORDER BY "2_pts_rank"

/* According to the table, Curry is ranked 353rd with only 3932 and a total percentage of 42.76%. For the top 10 players, 
they made more than 10000 2-pointers. */

/* I discovered that Curry has attempted and made similar numbers of 2 and 3 pointers. I want to know if there is any other 
players has similar play style. */

SELECT *,
DENSE_RANK () OVER (ORDER BY "3_2_pts_attempt_ratio" DESC) AS attempt_ratio_rank
FROM (
	SELECT player,
	SUM(g) AS total_games_played,
	SUM(x2p) AS total_2_pts,
	SUM(x3p) AS total_3_pts,
	ROUND(SUM(x3p)/SUM(x2p),2) AS "3_2_pts_ratio",
	SUM(x2pa) AS total_2_pts_attempt,
	SUM(x3pa) AS total_3_pts_attempt,
	ROUND(SUM(x3pa)/SUM(x2pa),2) AS "3_2_pts_attempt_ratio"
	FROM [NBA Database].dbo.player_totals
	WHERE x2p > 0 AND x3p > 0 AND x2pa > 0 AND x3pa > 0
	GROUP BY player
) players_pts_ratio
ORDER BY attempt_ratio_rank

/* As the data revealed, it was noticed that some players had an exaggerated 3-point field goal percentage, which could be misleading 
since they did not attempt or make many shots. In order to filter out these players and obtain more accurate insights, a new criterion 
was added to the query, requiring that only players who attempted and made more than 1000 3-point field goals were included in the analysis. 
This adjustment should provide a more reliable and informative view of the players' 3-point shooting abilities. */

SELECT *,
DENSE_RANK () OVER (ORDER BY "3_2_pts_attempt_ratio" DESC) AS attempt_ratio_rank
FROM (
	SELECT player,
	SUM(g) AS total_games_played,
	SUM(x2p) AS total_2_pts,
	SUM(x3p) AS total_3_pts,
	ROUND(SUM(x3p)/SUM(x2p),2) AS "3_2_pts_ratio",
	SUM(x2pa) AS total_2_pts_attempt,
	SUM(x3pa) AS total_3_pts_attempt,
	ROUND(SUM(x3pa)/SUM(x2pa),2) AS "3_2_pts_attempt_ratio"
	FROM [NBA Database].dbo.player_totals
	WHERE x2p > 0 AND x3p > 0 AND x2pa > 0 AND x3pa > 0
	GROUP BY player
	HAVING SUM(x3p) > 1000 AND SUM(x3pa) > 1000
) players_pts_ratio_2
ORDER BY attempt_ratio_rank

/* From the table, we can see that Curry has an attempt ratio of 1.02 and a points ratio of 0.84. Let's see if there are any other 
players with a similar performance. */

SELECT *,
DENSE_RANK () OVER (ORDER BY "3_2_pts_attempt_ratio" DESC) AS attempt_ratio_rank
FROM (
	SELECT player,
	SUM(g) AS total_games_played,
	SUM(x2p) AS total_2_pts,
	SUM(x3p) AS total_3_pts,
	ROUND(SUM(x3p)/SUM(x2p),2) AS "3_2_pts_ratio",
	SUM(x2pa) AS total_2_pts_attempt,
	SUM(x3pa) AS total_3_pts_attempt,
	ROUND(SUM(x3pa)/SUM(x2pa),2) AS "3_2_pts_attempt_ratio"
	FROM [NBA Database].dbo.player_totals
	WHERE x2p > 0 AND x3p > 0 AND x2pa > 0 AND x3pa > 0
	GROUP BY player
	HAVING SUM(x3p) > 1000 AND SUM(x3pa) > 1000
) players_pts_ratio_2
WHERE "3_2_pts_ratio" > 0.8 AND "3_2_pts_attempt_ratio" > 1
ORDER BY attempt_ratio_rank

/* Out of the 19 players who have a similar play style as Curry, only three of them have made more than 2000 3-pointers. 
Curry, on the other hand, has made more than 3000 3-pointers, which is a significant accomplishment. */