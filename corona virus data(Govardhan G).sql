use govardhan;
select * from corona;

# CHECK AND UPDATE NULL VALUES
SELECT 
    SUM(CASE WHEN province IS NULL THEN 1 ELSE 0 END) AS province_nulls,
    SUM(CASE WHEN region IS NULL THEN 1 ELSE 0 END) AS country_region_nulls,
    SUM(CASE WHEN latitude IS NULL THEN 1 ELSE 0 END) AS latitude_nulls,
    SUM(CASE WHEN longitude IS NULL THEN 1 ELSE 0 END) AS longitude_nulls,
    SUM(CASE WHEN Date IS NULL THEN 1 ELSE 0 END) AS date_nulls,
    SUM(CASE WHEN Confirmed IS NULL THEN 1 ELSE 0 END) AS confirmed_nulls,
    SUM(CASE WHEN Deaths IS NULL THEN 1 ELSE 0 END) AS deaths_nulls,
    SUM(CASE WHEN Recovered IS NULL THEN 1 ELSE 0 END) AS recovered_nulls
FROM corona;

UPDATE corona SET Confirmed = COALESCE(Confirmed, 0),Deaths = COALESCE(Deaths, 0),Recovered = COALESCE(Recovered, 0);
select * from corona;

#TO CHECK TOTAL NO OF ROWS
select count(province) from corona;


# check what is start date and end date
SELECT 
    min(Date) as start_date, 
    Max(Date) AS end_date
FROM corona;

# No of months present in dataset
SELECT COUNT(DISTINCT DATE_FORMAT(Date, '%Y-%m')) AS _present
FROM corona;

# Find monthly average for confirmed, deaths, recovered
SELECT DATE_FORMAT(date, '%M') AS month_name,
    AVG(confirmed) AS avg_confirmed,
    AVG(deaths) AS avg_deaths,
    AVG(recovered) AS avg_recovered
FROM corona group by month_name;

# Finding most frequent value for confirmed, deaths, recovered each month 
SELECT 
    month,
    MAX(confirmed) AS most_frequent_confirmed,
    MAX(deaths) AS most_frequent_deaths,
    MAX(recovered) AS most_frequent_recovered
FROM (
    SELECT 
        DATE_FORMAT(Date, '%Y-%m') AS month,
        Confirmed,
        Deaths,
        Recovered,
        COUNT(*) AS frequency
    FROM corona
    GROUP BY month, Confirmed, Deaths, Recovered
) AS subquery
GROUP BY month;

# Find minimum values of confirmed, deaths, recovered per year
SELECT 
    YEAR(date) AS year,
    MIN(Confirmed) AS min_confirmed,
    MIN(Deaths) AS min_deaths,
    MIN(Recovered) AS min_recovered
FROM corona
GROUP BY year;


# maximum values of confirmed, deaths, recovered per year
SELECT 
    YEAR(Date) AS year,
    MAX(Confirmed) AS max_confirmed,
    MAX(Deaths) AS max_deaths,
    MAX(Recovered) AS max_recovered
FROM corona
GROUP BY year;

# toatal numner of cases of confirmed death and recovered
SELECT 
    DATE_FORMAT(Date, '%Y-%m') AS month,
    SUM(Confirmed) AS total_confirmed,
    SUM(Deaths) AS total_deaths,
    SUM(Recovered) AS total_recovered
FROM corona
GROUP BY month;


#  how corona virus spread out with respect to death case per month
SELECT 
    SUM(Confirmed) AS total_confirmed,
    AVG(Confirmed) AS avg_confirmed,
    VARIANCE(Confirmed) AS var_confirmed,
    STDDEV(Confirmed) AS stddev_confirmed
FROM corona;

# how corona virus spread out with respect to confirmed cases
SELECT 
    DATE_FORMAT(Date, '%d-%m-%y') AS month,
    SUM(Deaths) AS total_deaths,
    AVG(Deaths) AS avg_deaths,
    VARIANCE(Deaths) AS var_deaths,
    STDDEV(Deaths) AS stddev_deaths
FROM corona
GROUP BY month;
select * from corona;


# how corona virus spread out with respect to recovered case

SELECT 
    SUM(Recovered) AS total_recovered,
    AVG(Recovered) AS avg_recovered,
    VARIANCE(Recovered) AS var_recovered,
    STDDEV(Recovered) AS stddev_recovered
FROM corona;

# Finding  Country having highest number of the death case
SELECT 
    region,
    SUM(Confirmed) AS total_confirmed
FROM corona
GROUP BY region
ORDER BY total_confirmed DESC
LIMIT 1;

# Find Country having lowest number of the death case
SELECT 
    region,
    SUM(Deaths) AS total_deaths
FROM corona
GROUP BY region
ORDER BY total_deaths ASC
LIMIT 1;


# Top 5 countries having highest recovered case
SELECT 
    region,
    SUM(Recovered) AS total_recovered
FROM corona
GROUP BY region
ORDER BY total_recovered DESC
LIMIT 5;

