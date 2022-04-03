create database final_Project;

use final_Project;

#Q1 Create a table “Station” to store information about weather observation stations:

create table station(ID int primary key,City varchar(30),State varchar(30),Lat_N int,Long_W int);

#Q2 Insert the following records into the table:
insert into station values(13,"Phoenix","AZ",33,112),
(44,"Denver","CO", 40,105),
(66,"Caribou","ME",47,68);

#Q3 Execute a query to look at table STATION in undefined order
select * from station;

#Q4 Execute a query to select Northern stations (Northern latitude > 39.7)

select * from station
where lat_N >39.7;

#Q5 Create another table, ‘STATS’, to store normalized temperature and precipitation data:

create table Stats(ID int,Month int,Temp_F float,Rain_I float, constraint S_pk primary key(id,month));

insert into stats values(13,1,57.4,.31);
insert into stats values(13,7,91.7,5.51),
(44,1,27.3,.18),
(44,7,74.8,2.11),
(66,1,6.7,2.1),
(66,7,65.8,4.52);

#Q6 Populate the table STATS with some statistics for January and July:
select * from stats;


#Q7 Execute a query to display temperature stats (from STATS table) for each city (from Station table)

select Temp_F,City from stats,station
where station.id = stats.id;

select * from stats,station
where station.id = stats.id;

//#Q8 Execute a query to look at the table STATS, ordered by month and greatest rainfall, with columns rearranged. It should also show the corresponding cities

select Month,Rain_i, city from stats,station
where station.id = stats.id
order by month asc;

#Q9 Execute a query to look at temperatures for July from table STATS, lowest temperatures first,picking up city name and latitude.

select Month, Temp_f, city,Lat_N from stats,station
where station.id = stats.id and  month = 7
order by Temp_F asc;


# Q10 Execute a query to show MAX and MIN temperatures as well as average rainfall for each city.

select * from stats;

Select city,max(Temp_F),min(Temp_F) , avg(rain_i) from stats,station
where station.id = stats.id
group by city;

# Q11 Execute a query to display each city’s monthly temperature in Celcius and rainfall in Centimeter.

select city,month,
(temp_f -32)*5/9 as Tmp_to_Cls, Rain_i*2.45 as Inc_to_Cnt from stats,station
where station.id = stats.id ;

# Q12 Update all rows of table STATS to compensate for faulty rain gauges known to read 0.01 inches low.

update stats set Rain_I=Rain_I+0.01;

set sql_safe_updates=0;


#Q13 Update Denver's July temperature reading as 74.9

update stats set Temp_F=74.9
where ID=44 and month =7;
