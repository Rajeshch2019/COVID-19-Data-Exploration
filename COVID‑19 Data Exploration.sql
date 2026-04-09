--- 1. Basic Data Selection
SELECT LOCATION, DATE, total_cases, new_cases, total_deaths, population
from [Portfolio project] .[dbo].[CovidDeaths]
order  by 1,2 

-----2. Total Cases vs Total Deaths
SELECT 
    location,
    date,
    total_cases,
    total_deaths,
    (CAST(total_deaths AS FLOAT) / total_cases) * 100 AS death_percentage
FROM CovidDeaths
where location like '%state%'
ORDER BY location, date;

---3. Total Cases vs Population
SELECT 
    location,
    date,
    population,
    total_cases,
    (total_cases / population ) * 100 AS death_percentage
FROM CovidDeaths
where location like '%state%'
ORDER BY location, date;

--- 4. Countries with Highest Infection Rate 
SELECT 
    location,
    population,
    Max (total_cases) as "Highest infection count",
    max(total_cases / population ) * 100 AS "Percent popoulation infected"
FROM CovidDeaths
--where location like '%state%'
group by location, population
ORDER BY "Percent popoulation infected" desc

--- Showing countries highest death count per population 
SELECT 
    location,
   cast(max(total_deaths) AS FLOAT) as "total death count"
FROM CovidDeaths
where continent is not null
group by location
ORDER  BY  "total death count" desc

----  Death Count by Continent
SELECT 
    continent,
   cast(max(total_deaths) AS FLOAT) as "total death count"
FROM CovidDeaths
where continent is not null
group by continent
ORDER  BY  "total death count" desc

--- global numbers
SELECT 
       sum(cast(new_cases as float)) as Total_cases,
       sum(new_deaths) as Total_new_deaths,
       sum(new_deaths)/sum(cast(new_cases as float)) * 100 as Death_Percentage
       from CovidDeaths
       where continent is not null
       order by 1,2
   

---- Population vs Vaccinations 
select 
dea.continent,
dea. location,
dea.date,
dea.population,
dea.new_vaccinations,    
sum(dea.new_vaccinations) over (partition by dea.location order by  dea.location, dea.date) as "People vaccinated"
from  CovidDeaths  dea
join  Covidvaccinations  vac
on dea.location = vac. location 
and dea.date = vac. date
where dea.continent is not null and dea.continent = 'europe'
order by location, date

--- Using CTE for Vaccination Analysis

WITH population_vs_vaccination AS (
    SELECT 
        dea.continent,
        dea.location,
        dea.date,
        dea.population,
        dea.new_vaccinations
    FROM CovidDeaths dea
    JOIN CovidVaccinations vac
        ON dea.location = vac.location
        AND dea.date = vac.date
    WHERE dea.continent IS NOT NULL
)
SELECT
    continent,
    location,
    date,
    population,
    new_vaccinations,
    SUM(new_vaccinations) OVER (
        PARTITION BY location 
        ORDER BY date
    ) AS people_vaccinated,
    (sum(new_vaccinations)over (partition by location order by date)/population ) *100  as percent_vaccinated
FROM population_vs_vaccination
----WHERE continent = 'Europe'
ORDER BY location, date


--- Temp Table for Vaccination Percentage
CREATE TABLE #PercentPopulationVaccinated
(
    Continent NVARCHAR(255),
    Location NVARCHAR(255),
    Date DATETIME,
    Population NUMERIC,
    New_Vaccinations NUMERIC,
    People_Vaccinated NUMERIC
);

INSERT INTO #PercentPopulationVaccinated
SELECT
    dea.continent,
    dea.location,
    dea.date,
    dea.population,
    dea.new_vaccinations,   
    SUM(dea.new_vaccinations) OVER (
        PARTITION BY dea.location 
        ORDER BY dea.date
    ) AS people_vaccinated
FROM CovidDeaths dea
JOIN CovidVaccinations vac
    ON dea.location = vac.location 
    AND dea.date = vac.date;

SELECT *, (people_vaccinated / population) * 100.0  AS Vaccination_Ratio
FROM #PercentPopulationVaccinated

--- Creating a View for Visualization 
CREATE VIEW PercentPopulationVaccinated AS 
SELECT
    dea.continent,
    dea.location,
    dea.date,
    dea.population,
    dea.new_vaccinations,   
    SUM(dea.new_vaccinations) OVER (
        PARTITION BY dea.location 
        ORDER BY dea.date
    ) AS people_vaccinated
FROM CovidDeaths dea
JOIN CovidVaccinations vac
    ON dea.location = vac.location 
    AND dea.date = vac.date
    WHERE  dea.continent is null

select * from #PercentPopulationVaccinated