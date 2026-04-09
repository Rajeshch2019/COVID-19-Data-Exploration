
📊 COVID‑19 Data Exploration Using SQL
This project explores global COVID‑19 data using SQL Server.
It includes data cleaning, transformation, analysis, window functions, CTEs, temp tables, and views.

🛠️ Tools Used
SQL Server

T‑SQL

Joins & Aggregations

Window Functions

CTEs

Temp Tables

Views

📂 Dataset
Two tables were used:

CovidDeaths

CovidVaccinations

🔍 SQL Queries
1. Basic Data Selection
sql
SELECT LOCATION, DATE, total_cases, new_cases, total_deaths, population
FROM CovidDeaths
ORDER BY 1,2;
2. Total Cases vs Total Deaths
sql
SELECT 
    location,
    date,
    total_cases,
    total_deaths,
    (CAST(total_deaths AS FLOAT) / total_cases) * 100 AS death_percentage
FROM CovidDeaths
WHERE location LIKE '%state%'
ORDER BY location, date;
3. Total Cases vs Population
sql
SELECT 
    location,
    date,
    population,
    total_cases,
    (total_cases / population) * 100 AS infection_percentage
FROM CovidDeaths
WHERE location LIKE '%state%'
ORDER BY location, date;
4. Countries with Highest Infection Rate
sql
SELECT 
    location,
    population,
    MAX(total_cases) AS highest_infection_count,
    MAX(total_cases / population) * 100 AS percent_population_infected
FROM CovidDeaths
GROUP BY location, population
ORDER BY percent_population_infected DESC;
5. Countries with Highest Death Count
sql
SELECT 
    location,
    CAST(MAX(total_deaths) AS FLOAT) AS total_death_count
FROM CovidDeaths
WHERE continent IS NOT NULL
GROUP BY location
ORDER BY total_death_count DESC;
6. Death Count by Continent
sql
SELECT 
    continent,
    CAST(MAX(total_deaths) AS FLOAT) AS total_death_count
FROM CovidDeaths
WHERE continent IS NOT NULL
GROUP BY continent
ORDER BY total_death_count DESC;
7. Global Numbers
sql
SELECT 
    SUM(CAST(new_cases AS FLOAT)) AS total_cases,
    SUM(new_deaths) AS total_new_deaths,
    SUM(new_deaths) / SUM(CAST(new_cases AS FLOAT)) * 100 AS death_percentage
FROM CovidDeaths
WHERE continent IS NOT NULL;
8. Population vs Vaccinations
sql
SELECT 
    dea.continent,
    dea.location,
    dea.date,
    dea.population,
    vac.new_vaccinations,
    SUM(vac.new_vaccinations) OVER (
        PARTITION BY dea.location ORDER BY dea.date
    ) AS people_vaccinated
FROM CovidDeaths dea
JOIN CovidVaccinations vac
    ON dea.location = vac.location 
    AND dea.date = vac.date
WHERE dea.continent = 'Europe'
ORDER BY location, date;
9. CTE for Vaccination Analysis
sql
WITH population_vs_vaccination AS (
    SELECT 
        dea.continent,
        dea.location,
        dea.date,
        dea.population,
        vac.new_vaccinations
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
        PARTITION BY location ORDER BY date
    ) AS people_vaccinated,
    (SUM(new_vaccinations) OVER (
        PARTITION BY location ORDER BY date
    ) / population) * 100 AS percent_vaccinated
FROM population_vs_vaccination
ORDER BY location, date;
10. Temp Table for Vaccination Percentage
sql
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
    vac.new_vaccinations,
    SUM(vac.new_vaccinations) OVER (
        PARTITION BY dea.location ORDER BY dea.date
    ) AS people_vaccinated
FROM CovidDeaths dea
JOIN CovidVaccinations vac
    ON dea.location = vac.location 
    AND dea.date = vac.date;

SELECT *, 
       (people_vaccinated / population) * 100.0 AS vaccination_ratio
FROM #PercentPopulationVaccinated;
11. Creating a View
sql
CREATE VIEW PercentPopulationVaccinated AS 
SELECT
    dea.continent,
    dea.location,
    dea.date,
    dea.population,
    vac.new_vaccinations,
    SUM(vac.new_vaccinations) OVER (
        PARTITION BY dea.location ORDER BY dea.date
    ) AS people_vaccinated
FROM CovidDeaths dea
JOIN CovidVaccinations vac
    ON dea.location = vac.location 
    AND dea.date = vac.date
WHERE dea.continent IS NOT NULL;
📌 Insights
Infection rates vary widely across countries.

Some countries reached very high infection percentages.

Death rates differ significantly by region.

Vaccination rollout can be tracked using window functions.
