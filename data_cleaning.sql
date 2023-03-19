/****** Data Cleaning *******/

/**** Check if there are null values for Curry's and his team data ****/

SELECT *
  FROM [NBA Database].[dbo].[advanced]
WHERE player LIKE 'Stephen Curry' AND (seas_id IS NULL OR season IS NULL OR player_id IS NULL OR player IS NULL OR birth_year
	IS NULL OR pos IS NULL OR age IS NULL OR experience IS NULL OR lg IS NULL OR tm IS NULL OR g IS NULL OR mp IS NULL OR per
	IS NULL OR ts_percent IS NULL OR x3p_ar IS NULL OR f_tr IS NULL OR orb_percent IS NULL OR drb_percent IS NULL OR trb_percent
	IS NULL OR ast_percent IS NULL OR stl_percent IS NULL OR blk_percent IS NULL OR tov_percent IS NULL OR usg_percent IS NULL OR
	ows IS NULL OR dws IS NULL OR ws IS NULL OR ws_48 IS NULL OR obpm IS NULL OR dbpm IS NULL OR bpm IS NULL OR vorp IS NULL)

-- Although there are no null values shown with the query, I find that the birth year is 'NA'.
-- I search online and find that it is 1988. I update it with following query.

UPDATE [NBA Database].[dbo].[advanced]
SET birth_year = 1988
	WHERE player LIKE 'Stephen Curry' AND birth_year = 'NA'

SELECT *
  FROM [NBA Database].[dbo].[all_star_selections]
WHERE player LIKE 'Stephen Curry' AND (player IS NULL OR team IS NULL OR lg IS NULL OR season IS NULL OR replaced IS NULL)

SELECT *
  FROM [NBA Database].[dbo].[end_of_season_teams]
WHERE player LIKE 'Stephen Curry' AND (season IS NULL OR lg IS NULL OR 'type' IS NULL OR number_tm IS NULL OR player IS NULL OR
	position IS NULL OR seas_id IS NULL OR player_id IS NULL OR birth_year IS NULL OR tm IS NULL OR age  IS NULL)

SELECT *
  FROM [NBA Database].[dbo].[end_of_season_teams_voting]
WHERE player LIKE 'Stephen Curry' AND (season IS NULL OR lg IS NULL OR 'type' IS NULL OR number_tm IS NULL OR 
	position IS NULL OR player IS NULL OR age IS NULL OR tm IS NULL OR pts_won IS NULL OR pts_max IS NULL OR share IS NULL OR
	x1st_tm IS NULL OR x2nd_tm IS NULL OR x3rd_tm IS NULL OR seas_id IS NULL OR player_id IS NULL)

-- Null values are found in column 'x2nd_tm' and 'x3rd_tm' in season 2013 & 2014

SELECT *
  FROM [NBA Database].[dbo].[opponent_stats_per_100_poss]
WHERE abbreviation = 'GSW' AND (season IS NULL OR lg IS NULL OR team IS NULL OR abbreviation IS NULL OR playoffs IS NULL OR g
	 IS NULL OR mp IS NULL OR opp_fg_per_100_poss IS NULL OR opp_fga_per_100_poss IS NULL OR opp_fg_percent IS NULL OR 
	 opp_x3p_per_100_poss IS NULL OR opp_x3pa_per_100_poss IS NULL OR opp_x3p_percent IS NULL OR opp_x2p_per_100_poss IS NULL OR 
	 opp_x2pa_per_100_poss IS NULL OR opp_x2p_percent IS NULL OR opp_ft_per_100_poss IS NULL OR opp_fta_per_100_poss IS NULL OR 
	 opp_ft_percent IS NULL OR opp_orb_per_100_poss IS NULL OR opp_drb_per_100_poss IS NULL OR opp_trb_per_100_poss IS NULL OR 
	 opp_ast_per_100_poss IS NULL OR opp_stl_per_100_poss IS NULL OR opp_blk_per_100_poss IS NULL OR opp_tov_per_100_poss 
	 IS NULL OR opp_pf_per_100_poss IS NULL OR opp_pts_per_100_poss IS NULL)

-- Null values are found from season 1974 to 1979, which will not affect our analysis.

SELECT *
  FROM [NBA Database].[dbo].[opponent_stats_per_game]
WHERE abbreviation = 'GSW' AND (season IS NULL OR lg IS NULL OR team IS NULL OR abbreviation IS NULL OR playoffs IS NULL OR 
	g IS NULL OR mp_per_game IS NULL OR opp_fg_per_game IS NULL OR opp_fga_per_game IS NULL OR opp_fg_percent IS NULL OR 
	opp_x3p_per_game IS NULL OR opp_x3pa_per_game IS NULL OR opp_x3p_percent IS NULL OR opp_x2p_per_game IS NULL OR 
	opp_x2pa_per_game IS NULL OR opp_x2p_percent IS NULL OR opp_ft_per_game IS NULL OR opp_fta_per_game IS NULL OR 
	opp_ft_percent IS NULL OR opp_orb_per_game IS NULL OR opp_drb_per_game IS NULL OR opp_trb_per_game IS NULL OR 
	opp_ast_per_game IS NULL OR opp_stl_per_game IS NULL OR opp_blk_per_game IS NULL OR opp_tov_per_game IS NULL OR 
	opp_pf_per_game IS NULL OR opp_pts_per_game  IS NULL)

-- Null values are found from season 1972 to 1979, which will not affect our analysis.

SELECT *
  FROM [NBA Database].[dbo].[opponent_totals]
WHERE abbreviation = 'GSW' AND (season IS NULL OR lg IS NULL OR team IS NULL OR abbreviation IS NULL OR playoffs IS NULL OR 
	g IS NULL OR mp IS NULL OR opp_fg IS NULL OR opp_fga IS NULL OR opp_fg_percent IS NULL OR opp_x3p IS NULL OR opp_x3pa 
	IS NULL OR opp_x3p_percent IS NULL OR opp_x2p IS NULL OR opp_x2pa IS NULL OR opp_x2p_percent IS NULL OR opp_ft IS NULL OR 
	opp_fta IS NULL OR opp_ft_percent IS NULL OR opp_orb IS NULL OR opp_drb IS NULL OR opp_trb IS NULL OR opp_ast IS NULL OR 
	opp_stl IS NULL OR opp_blk IS NULL OR opp_tov IS NULL OR opp_pf IS NULL OR opp_pts IS NULL)

-- Null values are found from season 1972 to 1979, which will not affect our analysis.

SELECT *
  FROM [NBA Database].[dbo].[per_100_poss]
WHERE player LIKE 'Stephen Curry' AND (seas_id IS NULL OR season IS NULL OR player_id IS NULL OR player IS NULL OR birth_year 
	 IS NULL OR pos IS NULL OR age IS NULL OR experience IS NULL OR lg IS NULL OR tm IS NULL OR g IS NULL OR gs IS NULL OR mp 
	 IS NULL OR fg_per_100_poss IS NULL OR fga_per_100_poss IS NULL OR fg_percent IS NULL OR x3p_per_100_poss IS NULL OR 
	 x3pa_per_100_poss IS NULL OR x3p_percent IS NULL OR x2p_per_100_poss IS NULL OR x2pa_per_100_poss IS NULL OR 
	 x2p_percent IS NULL OR ft_per_100_poss IS NULL OR fta_per_100_poss IS NULL OR ft_percent IS NULL OR orb_per_100_poss 
	 IS NULL OR drb_per_100_poss IS NULL OR trb_per_100_poss IS NULL OR ast_per_100_poss IS NULL OR stl_per_100_poss IS NULL OR 
	 blk_per_100_poss IS NULL OR tov_per_100_poss IS NULL OR pf_per_100_poss IS NULL OR pts_per_100_poss IS NULL OR o_rtg 
	 IS NULL OR d_rtg IS NULL)

SELECT *
  FROM [NBA Database].[dbo].[per_36_minutes]
WHERE player LIKE 'Stephen Curry' AND (seas_id IS NULL OR season IS NULL OR player_id IS NULL OR player IS NULL OR birth_year 
	 IS NULL OR pos IS NULL OR age IS NULL OR experience IS NULL OR lg IS NULL OR tm IS NULL OR g IS NULL OR gs IS NULL OR mp 
	 IS NULL OR fg_per_36_min IS NULL OR fga_per_36_min IS NULL OR fg_percent IS NULL OR x3p_per_36_min IS NULL OR 
	 x3pa_per_36_min IS NULL OR x3p_percent IS NULL OR x2p_per_36_min IS NULL OR x2pa_per_36_min IS NULL OR 
	 x2p_percent IS NULL OR ft_per_36_min IS NULL OR fta_per_36_min IS NULL OR ft_percent IS NULL OR orb_per_36_min IS NULL OR 
	 drb_per_36_min IS NULL OR trb_per_36_min IS NULL OR ast_per_36_min IS NULL OR stl_per_36_min IS NULL OR blk_per_36_min	
	 IS NULL OR tov_per_36_min IS NULL OR pf_per_36_min IS NULL OR pts_per_36_min IS NULL)

SELECT *
  FROM [NBA Database].[dbo].[player_award_shares]
WHERE player LIKE 'Stephen Curry' AND (season IS NULL OR award IS NULL OR player IS NULL OR age IS NULL OR tm IS NULL OR 
	'first' IS NULL OR pts_won IS NULL OR pts_max IS NULL OR share IS NULL OR winner IS NULL OR seas_id IS NULL OR player_id IS NULL)

SELECT *
  FROM [NBA Database].[dbo].[player_career_info]
WHERE player LIKE 'Stephen Curry' AND (player_id IS NULL OR player IS NULL OR birth_year IS NULL OR hof IS NULL OR 
	num_seasons IS NULL OR first_seas IS NULL OR last_seas IS NULL)

SELECT *
  FROM [NBA Database].[dbo].[player_per_game]
WHERE player LIKE 'Stephen Curry' AND (seas_id IS NULL OR season IS NULL OR player_id IS NULL OR player IS NULL OR 
	birth_year IS NULL OR pos IS NULL OR age IS NULL OR experience IS NULL OR lg IS NULL OR tm IS NULL OR g IS NULL OR gs 
	IS NULL OR mp_per_game IS NULL OR fg_per_game IS NULL OR fga_per_game IS NULL OR fg_percent IS NULL OR x3p_per_game	
	IS NULL OR x3pa_per_game IS NULL OR x3p_percent IS NULL OR x2p_per_game IS NULL OR x2pa_per_game IS NULL OR x2p_percent	
	IS NULL OR e_fg_percent IS NULL OR ft_per_game IS NULL OR fta_per_game IS NULL OR ft_percent IS NULL OR orb_per_game 
	IS NULL OR drb_per_game IS NULL OR trb_per_game IS NULL OR ast_per_game IS NULL OR stl_per_game IS NULL OR blk_per_game	
	IS NULL OR tov_per_game IS NULL OR pf_per_game IS NULL OR pts_per_game IS NULL)

SELECT *
  FROM [NBA Database].[dbo].[player_play_by_play]
WHERE player LIKE 'Stephen Curry' AND (seas_id IS NULL OR season IS NULL OR player_id IS NULL OR player IS NULL OR birth_year 
	IS NULL OR pos IS NULL OR age IS NULL OR experience IS NULL OR lg IS NULL OR tm IS NULL OR g IS NULL OR mp IS NULL OR 
	pg_percent IS NULL OR sg_percent IS NULL OR sf_percent IS NULL OR pf_percent IS NULL OR c_percent IS NULL OR 
	on_court_plus_minus_per_100_poss IS NULL OR net_plus_minus_per_100_poss IS NULL OR bad_pass_turnover IS NULL OR 
	lost_ball_turnover IS NULL OR shooting_foul_committed IS NULL OR offensive_foul_committed IS NULL OR shooting_foul_drawn 
	IS NULL OR offensive_foul_drawn IS NULL OR points_generated_by_assists IS NULL OR and1 IS NULL OR fga_blocked IS NULL)

SELECT *
  FROM [NBA Database].[dbo].[player_season_info]
WHERE player LIKE 'Stephen Curry' AND (season IS NULL OR seas_id IS NULL OR player_id IS NULL OR player IS NULL OR birth_year 
	IS NULL OR pos IS NULL OR age IS NULL OR lg IS NULL OR tm IS NULL OR experience IS NULL)

SELECT *
  FROM [NBA Database].[dbo].[player_shooting]
WHERE player LIKE 'Stephen Curry' AND (seas_id IS NULL OR season IS NULL OR player_id IS NULL OR player IS NULL OR birth_year 
	IS NULL OR pos IS NULL OR age IS NULL OR experience IS NULL OR lg IS NULL OR tm IS NULL OR g IS NULL OR mp IS NULL OR 
	fg_percent IS NULL OR avg_dist_fga IS NULL OR percent_fga_from_x2p_range IS NULL OR percent_fga_from_x0_3_range IS NULL OR 
	percent_fga_from_x3_10_range IS NULL OR percent_fga_from_x10_16_range IS NULL OR percent_fga_from_x16_3p_range IS NULL OR 
	percent_fga_from_x3p_range IS NULL OR fg_percent_from_x2p_range IS NULL OR fg_percent_from_x0_3_range IS NULL OR 
	fg_percent_from_x3_10_range IS NULL OR fg_percent_from_x10_16_range IS NULL OR fg_percent_from_x16_3p_range IS NULL OR 
	fg_percent_from_x3p_range IS NULL OR percent_assisted_x2p_fg IS NULL OR percent_assisted_x3p_fg IS NULL OR 
	percent_dunks_of_fga IS NULL OR num_of_dunks IS NULL OR percent_corner_3s_of_3pa IS NULL OR corner_3_point_percent 
	IS NULL OR num_heaves_attempted IS NULL OR num_heaves_made IS NULL)

SELECT *
  FROM [NBA Database].[dbo].[player_totals]
WHERE player LIKE 'Stephen Curry' AND (seas_id IS NULL OR season IS NULL OR player_id IS NULL OR player IS NULL OR birth_year 
	IS NULL OR pos IS NULL OR age IS NULL OR experience IS NULL OR lg IS NULL OR tm IS NULL OR g IS NULL OR gs IS NULL OR mp 
	IS NULL OR fg IS NULL OR fga IS NULL OR fg_percent IS NULL OR x3p IS NULL OR x3pa IS NULL OR x3p_percent IS NULL OR x2p	
	IS NULL OR x2pa IS NULL OR x2p_percent IS NULL OR e_fg_percent IS NULL OR ft IS NULL OR fta IS NULL OR ft_percent IS NULL OR 
	orb IS NULL OR drb IS NULL OR trb IS NULL OR ast IS NULL OR stl IS NULL OR blk IS NULL OR tov IS NULL OR pf IS NULL OR pts  IS NULL)

SELECT *
  FROM [NBA Database].[dbo].[team_abbrev]
WHERE abbreviation = 'GSW' AND (season IS NULL OR lg IS NULL OR team IS NULL OR playoffs IS NULL OR abbreviation IS NULL)

SELECT *
  FROM [NBA Database].[dbo].[team_stats_per_100_poss]
WHERE abbreviation = 'GSW' AND (season IS NULL OR lg IS NULL OR team IS NULL OR abbreviation IS NULL OR playoffs IS NULL OR 
	g IS NULL OR mp IS NULL OR fg_per_100_poss IS NULL OR fga_per_100_poss IS NULL OR fg_percent IS NULL OR x3p_per_100_poss 
	IS NULL OR x3pa_per_100_poss IS NULL OR x3p_percent IS NULL OR x2p_per_100_poss IS NULL OR x2pa_per_100_poss IS NULL OR 
	x2p_percent IS NULL OR ft_per_100_poss IS NULL OR fta_per_100_poss IS NULL OR ft_percent IS NULL OR orb_per_100_poss 
	IS NULL OR drb_per_100_poss IS NULL OR trb_per_100_poss IS NULL OR ast_per_100_poss IS NULL OR stl_per_100_poss IS NULL OR 
	blk_per_100_poss IS NULL OR tov_per_100_poss IS NULL OR pf_per_100_poss IS NULL OR pts_per_100_poss IS NULL)

-- Null values are found from season 1974 to 1979, which will not affect our analysis.

SELECT *
  FROM [NBA Database].[dbo].[team_stats_per_game]
WHERE abbreviation = 'GSW' AND (season IS NULL OR lg IS NULL OR team IS NULL OR abbreviation IS NULL OR playoffs IS NULL OR g 
	IS NULL OR mp_per_game IS NULL OR fg_per_game IS NULL OR fga_per_game IS NULL OR fg_percent IS NULL OR x3p_per_game IS NULL OR 
	x3pa_per_game IS NULL OR x3p_percent IS NULL OR x2p_per_game IS NULL OR x2pa_per_game IS NULL OR x2p_percent IS NULL OR 
	ft_per_game IS NULL OR fta_per_game IS NULL OR ft_percent IS NULL OR orb_per_game IS NULL OR drb_per_game IS NULL OR 
	trb_per_game IS NULL OR ast_per_game IS NULL OR stl_per_game IS NULL OR blk_per_game IS NULL OR tov_per_game IS NULL OR 
	pf_per_game IS NULL OR pts_per_game IS NULL)

-- Null values are found from season 1972 to 1979, which will not affect our analysis.

SELECT *
  FROM [NBA Database].[dbo].[team_summaries]
WHERE abbreviation = 'GSW' AND (season IS NULL OR lg IS NULL OR team IS NULL OR abbreviation IS NULL OR playoffs IS NULL OR 
	age IS NULL OR w IS NULL OR l IS NULL OR pw IS NULL OR pl IS NULL OR mov IS NULL OR sos IS NULL OR srs IS NULL OR o_rtg 
	IS NULL OR d_rtg IS NULL OR n_rtg IS NULL OR pace IS NULL OR f_tr IS NULL OR x3p_ar IS NULL OR ts_percent IS NULL OR 
	e_fg_percent IS NULL OR tov_percent IS NULL OR orb_percent IS NULL OR ft_fga IS NULL OR opp_e_fg_percent IS NULL OR 
	opp_tov_percent IS NULL OR opp_drb_percent IS NULL OR opp_ft_fga IS NULL OR arena IS NULL OR attend IS NULL OR attend_g 
	IS NULL)

-- Null values are found from season 1972 to 2000, which will not affect our analysis.

SELECT *
  FROM [NBA Database].[dbo].[team_totals]
WHERE abbreviation = 'GSW' AND (season IS NULL OR lg IS NULL OR team IS NULL OR abbreviation IS NULL OR playoffs IS NULL OR g 
	IS NULL OR mp IS NULL OR fg IS NULL OR fga IS NULL OR fg_percent IS NULL OR x3p IS NULL OR x3pa IS NULL OR x3p_percent 
	IS NULL OR x2p IS NULL OR x2pa IS NULL OR x2p_percent IS NULL OR ft IS NULL OR fta IS NULL OR ft_percent IS NULL OR orb 
	IS NULL OR drb IS NULL OR trb IS NULL OR ast IS NULL OR stl IS NULL OR blk IS NULL OR tov IS NULL OR pf IS NULL OR pts 
	IS NULL)

-- Null values are found from season 1972 to 1979, which will not affect our analysis.

/**** Check if there are duplicates ****/

SELECT COUNT(*) AS duplicates, seas_id
  FROM [NBA Database].[dbo].[advanced]
WHERE player LIKE 'Stephen Curry'
GROUP BY seas_id
HAVING COUNT(*)>1

SELECT COUNT(*) AS duplicates, season
  FROM [NBA Database].[dbo].[all_star_selections]
WHERE player LIKE 'Stephen Curry'
GROUP BY season
HAVING COUNT(*)>1

SELECT COUNT(*) AS duplicates, season
  FROM [NBA Database].[dbo].[end_of_season_teams]
WHERE player LIKE 'Stephen Curry'
GROUP BY season
HAVING COUNT(*)>1

SELECT COUNT(*) AS duplicates, season
  FROM [NBA Database].[dbo].[end_of_season_teams_voting]
WHERE player LIKE 'Stephen Curry'
GROUP BY season
HAVING COUNT(*)>1

SELECT COUNT(*) AS duplicates, season
  FROM [NBA Database].[dbo].[opponent_stats_per_100_poss]
WHERE abbreviation = 'GSW'
GROUP BY season
HAVING COUNT(*)>1

SELECT COUNT(*) AS duplicates, season
  FROM [NBA Database].[dbo].[opponent_stats_per_game]
WHERE abbreviation = 'GSW'
GROUP BY season
HAVING COUNT(*)>1

SELECT COUNT(*) AS duplicates, season
  FROM [NBA Database].[dbo].[opponent_totals]
WHERE abbreviation = 'GSW'
GROUP BY season
HAVING COUNT(*)>1

SELECT COUNT(*) AS duplicates, seas_id
  FROM [NBA Database].[dbo].[per_100_poss]
WHERE player LIKE 'Stephen Curry'
GROUP BY seas_id
HAVING COUNT(*)>1

SELECT COUNT(*) AS duplicates, seas_id
  FROM [NBA Database].[dbo].[per_36_minutes]
WHERE player LIKE 'Stephen Curry'
GROUP BY seas_id
HAVING COUNT(*)>1

SELECT COUNT(*) AS duplicates, season
  FROM [NBA Database].[dbo].[player_award_shares]
WHERE player LIKE 'Stephen Curry'
GROUP BY season
HAVING COUNT(*)>1

-- We can find 2 duplicates in season 2013 and 2016. By reviewing the table, the data is correct that Curry is in the voting of
-- both nba mvp and mip

-- For [player_career_info] table, it just has 1 row of result.

SELECT COUNT(*) AS duplicates, seas_id
  FROM [NBA Database].[dbo].[player_per_game]
WHERE player LIKE 'Stephen Curry'
GROUP BY seas_id
HAVING COUNT(*)>1

SELECT COUNT(*) AS duplicates, seas_id
  FROM [NBA Database].[dbo].[player_play_by_play]
WHERE player LIKE 'Stephen Curry'
GROUP BY seas_id
HAVING COUNT(*)>1

SELECT COUNT(*) AS duplicates, season
  FROM [NBA Database].[dbo].[player_season_info]
WHERE player LIKE 'Stephen Curry'
GROUP BY season
HAVING COUNT(*)>1

SELECT COUNT(*) AS duplicates, seas_id
  FROM [NBA Database].[dbo].[player_shooting]
WHERE player LIKE 'Stephen Curry'
GROUP BY seas_id
HAVING COUNT(*)>1

SELECT COUNT(*) AS duplicates, seas_id
  FROM [NBA Database].[dbo].[player_totals]
WHERE player LIKE 'Stephen Curry'
GROUP BY seas_id
HAVING COUNT(*)>1

SELECT COUNT(*) AS duplicates, season
  FROM [NBA Database].[dbo].[team_abbrev]
WHERE abbreviation = 'GSW'
GROUP BY season
HAVING COUNT(*)>1

SELECT COUNT(*) AS duplicates, season
  FROM [NBA Database].[dbo].[team_stats_per_100_poss]
WHERE abbreviation = 'GSW'
GROUP BY season
HAVING COUNT(*)>1

SELECT COUNT(*) AS duplicates, season
  FROM [NBA Database].[dbo].[team_stats_per_game]
WHERE abbreviation = 'GSW'
GROUP BY season
HAVING COUNT(*)>1

SELECT COUNT(*) AS duplicates, season
  FROM [NBA Database].[dbo].[team_summaries]
WHERE abbreviation = 'GSW'
GROUP BY season
HAVING COUNT(*)>1

SELECT COUNT(*) AS duplicates, season
  FROM [NBA Database].[dbo].[team_totals]
WHERE abbreviation = 'GSW'
GROUP BY season
HAVING COUNT(*)>1