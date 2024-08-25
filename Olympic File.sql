-- create a database 

create database upload;

-- use database 
use upload;
-- create table olympics
create table olympics1(
id int,
Name varchar(400),
Sex varchar(400),
Age int,
Height int,
Weight int,
Team varchar(400),
NOC varchar(400),
Games varchar(400),
Year int,
Season varchar(400),
City varchar(450),
Sport varchar(400),
Event varchar(350),
Medal varchar(400)
);
-- view table
select * from olympics;

SHOW VARIABLES LIKE "secure_file_priv";

load data infile 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/Athletes_Cleaned.csv'
into table olympics1
fields terminated by ","
enclosed by '"'
lines terminated by '\r\n'
ignore 1 rows;

select * from olympics1;
-- 1. Show how many medal counts present for entire data
select medal,count(medal) as medalcount  
from olympics1  where medal <> 'NoMedal'
group by medal 
order by medalcount;
-- 2. Show count of unique sports present in Olympics
select count(distinct(Sport)) from olympics1;

-- select Sport,count(Sport) from olympics group by Sport;

-- 3. Show how many different medals won by team India
select team,medal,count(medal) as medalcount,Team 
from olympics1 where medal <> 'NoMedal' and  team='India'
group by team,medal 
order by medalcount;

select * from olympics1;

-- 4. Show event wise medals won by India show from highest to lowest medals won in order
select event , count(medal) as medalcount ,team 
from olympics1 where medal != 'NoMedal' and team='india'
group by team,event
order by medalcount desc;

-- 5. Show event wise medals won by India in order of year
select team,year,event,medal,count(medal) as indiacount from olympics
where team='india' and medal <> 'NoMedal'
group by team,year,medal,event
order by year asc;

-- 6. show country who won maximum medals.
select team,count(medal) as medal_count from olympics1
where medal <> 'NoMedal'
group by team
order by medal_count desc;

select count(*) from olympics1;

-- 7.show top 10 countries who won gold
select team,count(medal) as goldcount from olympics1
where medal='gold'
group by team
order by goldcount desc limit 10;

--  8. show in which year did United states won most gold medal
select team,year,medal,count(medal) as usagold from olympics1
where team='united states' and medal='gold'
group by team,year
order by usagold desc limit 1;


-- 9. In which sports United States has most medals.
select team,sport,count(medal) as usamedals from olympics1
where team='united states'
group by team,sport
order by usamedals desc limit 1;
 


-- 10. Find top three players who won most medals along with their sports and country
select name,team,sport,count(medal) as top3 from olympics1
group by name,team,sport
order by top3 desc limit 3;


-- 11. Find player with most gold medals in cycling along with his country.
select name,team,sport,count(medal) as cycleace from olympics1
where medal='gold' and sport='cycling'
group by name,team,sport,medal
order by cycleace desc limit 1;


-- 12.Find player with most medals (Gold+Silver+Bronze) in Basketball also show his country.
select name,team,sport,count(medal) as basketballace from olympics1
where sport='basketball'
group by name,team,sport
order by basketballace desc limit 1;

select * from olympics1 where name='teresa edwards' ;
-- 13. Find out the count of different medals of the top basketball player Teresa Edwards
select name,medal,count(medal) as teresacount from olympics1
where name='teresa edwards' 
group by medal
order by teresacount;

-- 14. Find out medals won by male,female each year , Export this data and plot graph in excel
select sex,year,count(medal) as medalcount from olympics1
group by year,sex
order by year asc;
