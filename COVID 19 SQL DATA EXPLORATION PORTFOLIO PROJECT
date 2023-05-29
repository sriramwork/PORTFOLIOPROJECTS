--DEATH RATE

SELECT location, date, total_cases, total_cases, (total_deaths/CAST(total_cases AS INT))*100 AS DEATHRATE
FROM COVIDDEATHS
WHERE continent IS NOT NULL
ORDER BY DEATHRATE DESC

--DEATH RATE BY DATE

SELECT date, total_cases, total_cases, (total_deaths/CAST(total_cases AS INT))*100 AS DEATHRATE
FROM COVIDDEATHS
WHERE continent IS NOT NULL
ORDER BY DEATHRATE DESC

--PERCENT POPULATION INFECTED

SELECT location, date, total_cases, population, (total_deaths/population)*100 AS PERCENTPOPULATIONINFECTED
FROM COVIDDEATHS
WHERE continent IS NOT NULL
ORDER BY 1,2

--PERCENT POPULATION INFECTED WITH MAX TOTAL CASES IN A LOCATION

SELECT location, population, MAX(total_cases) AS HIGHESTINFECTIONCOUNT, MAX((TOTAL_CASES/POPULATION))*100 AS PERCENTPOPULATIONINFECTED
FROM COVIDDEATHS
WHERE continent IS NOT NULL
GROUP BY location, population
ORDER BY PERCENTPOPULATIONINFECTED DESC

-- TOTAL DEATH COUNT

SELECT location, MAX(CAST(TOTAL_DEATHS AS INT)) AS TOTALDEATHCOUNT
FROM COVIDDEATHS
WHERE continent IS NOT NULL
GROUP BY location
ORDER BY TOTALDEATHCOUNT DESC

--TOTAL DEATH COUNT INCLUDING MAX NUMBER OF DEATHS IN A CONTINENT

SELECT continent, MAX(CAST(TOTAL_DEATHS AS INT)) AS TOTALDEATHCOUNT
FROM COVIDDEATHS
WHERE continent IS NOT NULL
GROUP BY continent
ORDER BY TOTALDEATHCOUNT DESC

--TOTAL DEATH COUNT INCLUDING MAX TOTAL DEATHS BY LOCATION

SELECT location, MAX(CAST(TOTAL_DEATHS AS INT)) AS TOTALDEATHCOUNT
FROM COVIDDEATHS
WHERE continent IS NOT NULL
GROUP BY location
ORDER BY TOTALDEATHCOUNT DESC

--PERCENTAGE OF NEW DEATHS WRT NEW CASES

select date, sum(new_cases), sum(new_deaths) as totalnewdeaths, (sum(new_deaths)/sum(new_cases))*100 as deathpercentage
from COVIDDEATHS
where continent is not null
group by date
order by 1,2

--DEATH PERCENTAGE OF NEW DEATHS

select sum(new_cases) as totalnewcases, sum(new_deaths) as totalnewdeaths, (sum(new_deaths)/sum(new_cases))*100 as deathpercentage
from COVIDDEATHS
where continent is not null
--group by date
order by 1,2

--JOINING DATA (DEATH AND VACCINE INFORMATION)

SELECT *
FROM COVIDDEATHS DEATHS
JOIN COVIDVACCINATIONS VACCINES
ON DEATHS.location = VACCINES.location
AND DEATHS.date = VACCINES.date

WITH POPVSVACC (CONTINENT, LOCATION, DATE, NEW_VACCINATIONS, ROLLINGPEOPLEVACCINATED)
AS 
(
SELECT deaths.location, deaths.date, deaths.population, vaccines.new_vaccinations, sum(convert(int,vaccines.new_vaccinations)) over(partition by deaths.location order by deaths.location, deaths.date) as rollingpeoplevaccinated
FROM COVIDDEATHS DEATHS
JOIN COVIDVACCINATIONS VACCINES
ON DEATHS.location = VACCINES.location
AND DEATHS.date = VACCINES.date
WHERE DEATHS.continent IS NOT NULL
--ORDER BY 2,3
)
SELECT *
FROM POPVSVACC

--CREATING A VIEW

CREATE VIEW PERCENTPOPULATIONVACCINATED AS
SELECT deaths.location, deaths.date, deaths.population, vaccines.new_vaccinations, sum(convert(int,vaccines.new_vaccinations)) over(partition by deaths.location order by deaths.location, deaths.date) as rollingpeoplevaccinated
FROM COVIDDEATHS DEATHS
JOIN COVIDVACCINATIONS VACCINES
ON DEATHS.location = VACCINES.location
AND DEATHS.date = VACCINES.date
WHERE DEATHS.continent IS NOT NULL
--ORDER BY 2,3




