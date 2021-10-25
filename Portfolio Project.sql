SELECT *
FROM [Portfolio Project]..Coviddeaths
where continent is not null
order by 3,4


--SELECT *
--FROM [Portfolio Project]..Vaccinations
--order by 3,4


-- Select Data that we are going to be using
Select Location, date, total_cases, new_cases, total_deaths, population
FROM [Portfolio Project]..Coviddeaths
order by 1,2


-- Looking at Total Cases vs Total Deaths
Select Location, date, total_cases, total_deaths, (total_deaths/total_cases)*100 as DeathPercentage
FROM [Portfolio Project]..Coviddeaths
Where location like '%states%'
and continent is not null
order by 1,2


-- Looking at the Total Cases vs Population
Select Location, date, total_cases, Population, (total_cases/population)*100 as PercentPopulationInfected
FROM [Portfolio Project]..Coviddeaths
Where location like '%states%'
and continent is not null
order by 1,2


-- What countries have the highest infection rates compared to total population
Select Location, MAX(total_cases) as HighestInfectionCount, Population, MAX((total_cases/population))*100 as PercentPopulationInfected
FROM [Portfolio Project]..Coviddeaths
-- Where location like '%states%'
group by Location, population
order by PercentPopulationInfected desc


-- Countries with highest death count per population
Select Location, MAX(cast(Total_deaths as int)) as TotalDeathCount
FROM [Portfolio Project]..Coviddeaths
-- Where location like '%states%'
where continent is not null
group by Location
order by TotalDeathCount desc


-- let's break things down by continent
-- Showing continents with highest death count per population
Select continent, MAX(cast(Total_deaths as int)) as TotalDeathCount
FROM [Portfolio Project]..Coviddeaths
-- Where location like '%states%'
where continent is not null
group by continent
order by TotalDeathCount desc


-- Global Numbers
Select date, SUM(new_cases) as total_cases, SUM(CAST(new_deaths as int)) as total_deaths, SUM(CAST(new_deaths as int))/SUM(New_Cases)*100 as DeathPercentage
FROM [Portfolio Project]..Coviddeaths
where continent is not null
group by date
order by 1,2


-- Loooking at total population vs vaccinations
select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations,
SUM(convert(int, vac.new_vaccinations)) OVER (Partition by dea.location order by dea.location, dea.date) as RollingPeopleVaccinated, -- rollingcountpeoplevaccinated
from [Portfolio Project]..Coviddeaths dea
join [Portfolio Project]..Vaccinations vac
	on dea.location = vac.location
	and dea.date = vac.date
	where dea.continent is not null
	order by 2,3


-- USE CTE 
with PopvsVac (Continent, Location, Date, Population, new_vaccinations, RollingPeopleVaccinated)
as
(
select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations, SUM(convert(int, vac.new_vaccinations)) OVER (Partition by dea.location order by dea.location, dea.date) as RollingPeopleVaccinated
from [Portfolio Project]..Coviddeaths dea
join [Portfolio Project]..Vaccinations vac
	on dea.location = vac.location
	and dea.date = vac.date
where dea.continent is not null
-- order by 2,3
)
select *, (RollingPeopleVaccinated/Population)*100
from PopvsVac


-- TEMP TABLE
drop table if exists #PercentPopulationVaccinated
create table #PercentPopulationVaccinated (
Continent nvarchar(255),
Location nvarchar(255),
Date datetime,
Population numeric,
New_vaccinations numeric,
RollingPeopleVaccinated numeric
)

insert into #PercentPopulationVaccinated
select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations,
SUM(convert(int, vac.new_vaccinations)) OVER (Partition by dea.location order by dea.location, dea.date) as RollingPeopleVaccinated 
from [Portfolio Project]..Coviddeaths dea
join [Portfolio Project]..Vaccinations vac
	on dea.location = vac.location
	and dea.date = vac.date
where dea.continent is not null
-- order by 2,3

select *, (RollingPeopleVaccinated/Population)*100
from #PercentPopulationVaccinated


-- Creating View to Store Data for Later Visualizations
create view PercentPopulationVaccinated as
select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations,
SUM(convert(int, vac.new_vaccinations)) OVER (Partition by dea.location order by dea.location, dea.date) as RollingPeopleVaccinated 
from [Portfolio Project]..Coviddeaths dea
join [Portfolio Project]..Vaccinations vac
	on dea.location = vac.location
	and dea.date = vac.date
where dea.continent is not null
-- order by 2,3

select *
from PercentPopulationVaccinated
