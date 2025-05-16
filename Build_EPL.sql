SELECT
    m.[Date]
    ,m.HomeTeam
    ,m.AwayTeam
    ,m.FTHG
    ,m.FTAG
    ,FTR
FROM
    FootballMatch m;

-- which dates have more than 1 match, ordered by most matches

SELECT
    m.[Date]
    ,COUNT(*) AS MatchCount          
FROM
    FootballMatch m
GROUP BY    
    m.[Date]
HAVING COUNT(*) > 1
ORDER BY MatchCount DESC, m.[Date];


--------------------------------------------------------

SELECT
    m.[Date]
    ,m.HomeTeam
    ,m.AwayTeam
    ,m.FTHG
    ,m.FTAG
    ,FTR
FROM
    FootballMatch m;

--calculate points for each team
SELECT
    m.[Date]
    ,m.HomeTeam
    ,m.AwayTeam
    ,m.FTHG
    ,m.FTAG
    ,FTR      
           
    ,CASE
        WHEN FTR = 'H' THEN 3
        WHEN FTR = 'A' THEN 0
        WHEN FTR = 'D' THEN 1
    END AS HomePoints   
    ,CASE
        WHEN FTR = 'H' THEN 0
        WHEN FTR = 'A' THEN 3
        WHEN FTR = 'D' THEN 1
    END AS AwayPoints    

    ,SUM(HomePoints + AwayPoints) AS Points 
 
      FROM
    FootballMatch m



------------------------

SELECT
    m.[Date]
    ,m.HomeTeam
    ,m.AwayTeam
    ,m.FTHG
    ,m.FTAG
    ,FTR
FROM
    FootballMatch m;




    
    --results from home team perspective --------------------------------------------Select * from #EPLresults--------------------------------

drop table if exists #EPLresults -- drop the table if it exists
SELECT --this is the home team perspective. ftr is full time result
m.HomeTeam as Team
 ,m.FTHG As Goalsfor
 ,m.FTAG As Goalsagainst
 ,m.ftr
,CASE when m.FTHG > m.FTAG then 'W' when M.FTHG = M.FTAG then 'D' else 'L' end as Result
into #EPLresults -- #is flag for temp table
    From footballMatch m
UNION ALL --this allows for dupicates e.g. 5 matches with the same score
SELECT -- this is the away team perspective. ftr is full time result
m.AwayTeam as Team
 ,m.FTAG As Goalsfor
 ,m.FTHG As Goalsagainst
 ,m.ftr
,CASE when m.FTAG > m.FTHG then 'W' when M.FTAG = M.FTHG then 'D' else 'L' end as Result
    From footballMatch m

Select 
r.Team
,Count (*) as Played
,SUM (r.Goalsfor) as Goalsfor
,SUM (r.Goalsagainst) as Goalsagainst
,SUM (r.Goalsfor) - SUM(r.Goalsagainst) as GD
    , sum(CASE WHEN r.Result = 'W' THEN 1 ELSE 0 END) aS Won
    , sum(CASE WHEN r.Result = 'D' THEN 1 ELSE 0 END) aS Drawn
    , sum(CASE WHEN r.Result = 'L' THEN 1 ELSE 0 END) aS Lost
    , sum(CASE WHEN r.Result = 'W' THEN 3 ELSE 0 END) + sum(CASE WHEN r.Result = 'D' THEN 1 ELSE 0 END) as Points
From #EPLresults r
Group by r.Team 
Order by Points DESC, GD
