/****** Script for overview of tables  ******/
SELECT TOP 5 *
  FROM [NBA Database].[dbo].[advanced]
WHERE player LIKE 'Stephen Curry'

SELECT TOP 5 *
  FROM [NBA Database].[dbo].[all_star_selections]
WHERE player LIKE 'Stephen Curry'

SELECT TOP 5 *
  FROM [NBA Database].[dbo].[end_of_season_teams]
WHERE player LIKE 'Stephen Curry'

SELECT TOP 5 *
  FROM [NBA Database].[dbo].[end_of_season_teams_voting]
WHERE player LIKE 'Stephen Curry'

SELECT TOP 5 *
  FROM [NBA Database].[dbo].[opponent_stats_per_100_poss]
WHERE abbreviation = 'GSW'

SELECT TOP 5 *
  FROM [NBA Database].[dbo].[opponent_stats_per_game]
WHERE abbreviation = 'GSW'

SELECT TOP 5 *
  FROM [NBA Database].[dbo].[opponent_totals]
WHERE abbreviation = 'GSW'

SELECT TOP 5 *
  FROM [NBA Database].[dbo].[per_100_poss]
WHERE player LIKE 'Stephen Curry'

SELECT TOP 5 *
  FROM [NBA Database].[dbo].[per_36_minutes]
WHERE player LIKE 'Stephen Curry'

SELECT *
  FROM [NBA Database].[dbo].[player_award_shares]
WHERE player LIKE 'Stephen Curry'

SELECT *
  FROM [NBA Database].[dbo].[player_career_info]
WHERE player LIKE 'Stephen Curry'

SELECT *
  FROM [NBA Database].[dbo].[player_per_game]
WHERE player LIKE 'Stephen Curry'

SELECT *
  FROM [NBA Database].[dbo].[player_play_by_play]
WHERE player LIKE 'Stephen Curry'

SELECT *
  FROM [NBA Database].[dbo].[player_season_info]
WHERE player LIKE 'Stephen Curry'

SELECT TOP 5 *
  FROM [NBA Database].[dbo].[player_shooting]
WHERE player LIKE 'Stephen Curry'

SELECT TOP 5 *
  FROM [NBA Database].[dbo].[player_totals]
WHERE player LIKE 'Stephen Curry'

SELECT TOP 5 *
  FROM [NBA Database].[dbo].[team_abbrev]
WHERE abbreviation = 'GSW'

SELECT TOP 5 *
  FROM [NBA Database].[dbo].[team_stats_per_100_poss]
WHERE abbreviation = 'GSW'

SELECT TOP 5 *
  FROM [NBA Database].[dbo].[team_stats_per_game]
WHERE abbreviation = 'GSW'

SELECT TOP 5 *
  FROM [NBA Database].[dbo].[team_summaries]
WHERE abbreviation = 'GSW'

SELECT TOP 5 *
  FROM [NBA Database].[dbo].[team_totals]
WHERE abbreviation = 'GSW'