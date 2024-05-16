create database corona;

create table covid (
	Province varchar (50),
	Country_region varchar (50),
	Latitude float,
	Longitude float, 
	Date date,
	Confirmed int,
	Deaths int,
	Recovered int
);

copy covid from 'C:\Program Files\PostgreSQL\16\data\data_copy\covid.csv' csv header;

select * 
from covid
where province is null
or country_region is null
or latitude is null
or longitude is null
or date is null
or confirmed is null
or deaths is null
or recovered is null;

update covid
set 
	Province = coalesce(Province, 'Not Available'),
	Country_region = coalesce(Country_region, 'Not Available'),
	Latitude = coalesce(Latitude, 0.0),
	Longitude = coalesce(Longitude, 0.0),
	Date = coalesce(Date, '1970-01-01'::Date),
	Confirmed = coalesce(Confirmed, 0),
	Deaths = coalesce(Deaths, 0),
	Recovered = coalesce(Recovered, 0);
	
select count(*) as total_rows
from covid;

select min(date) as start_date, max(date) as end_date
from covid;

select extract(month from date) as month_number,
	   count(*) as month_count
from covid
group by month_number
order by month_number;

select
extract (year from date) as year,
extract (month from date) as month,
round(avg(confirmed), 2) as avg_confirmed,
round(avg(deaths), 2) as avg_deaths,
round(avg(recovered), 2) as avg_recovered
from covid
group by year, month
order by year, month;

select
extract (year from date) as year,
extract (month from date) as month,
max(confirmed) as most_confirmed,
max(deaths) as most_deaths,
max(recovered) as most_recovered
from covid
group by year, month
order by year, month;

select
extract (year from date) as year,
min (confirmed) as min_confirmed,
min (deaths) as min_deaths,
min (recovered) as min_recovered
from covid
group by year
order by year;

select
extract (year from date) as year,
max (confirmed) as max_confirmed,
max (deaths) as max_deaths,
max (recovered) as max_recovered
from covid
group by year
order by year;

select
extract (year from date) as year,
extract (month from date) as month,
sum(confirmed) as total_confirmed,
sum(deaths) as total_deaths,
sum(recovered) as total_recovered
from covid
group by year, month
order by year, month;

select
extract(year from date) as year,
extract(month from date) as month,
sum(confirmed) as total_confirmed,
round(avg(confirmed), 2) as avg_confirmed,
round(variance(confirmed), 2) as variance_confirmed,
round(STDDEV(confirmed), 2) as standard_dev_confirmed
from covid
group by year, month
order by year, month;

select
extract (year from date) as year,
extract (month from date) as month,
sum(deaths) as total_deaths,
round(avg(deaths), 2) as avg_deaths,
round(variance(deaths), 2) as variance_deaths,
round(STDDEV(deaths), 2) as standard_dev_deaths
from covid
group by year, month
order by year, month;

select
extract(year from date) as year,
extract(month from date) as month,
sum(recovered) as total_recovered,
round(avg(recovered), 2) as avg_recovered,
round(variance(recovered), 2) variance_recovered,
round(STDDEV(recovered), 2) as standard_dev_recovered
from covid
group by year, month
order by year, month;

select country_region,
sum(confirmed) as total_confirmed_cases
from covid
group by country_region
order by total_confirmed_cases desc
limit 1;

select country_region, confirmed
from covid
where confirmed =(select min(confirmed) from covid)
group by country_region, confirmed;

select country_region,
sum(recovered) as total_recovered_cases
from covid
group by country_region
order by total_recovered_cases desc
limit 5;