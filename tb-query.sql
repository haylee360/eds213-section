-- Make TB table
CREATE TABLE tuberculosis (
    CountryCode TEXT NOT NULL,
    Year INTEGER NOT NULL CHECK BETWEEN 2000 AND 2025,
    Incidence REAL,
    IncidenceLow REAL,
    IncidenceHigh REAL,
    IncidenceRange REAL,
    PRIMARY KEY(CountryCode, Year),
);

COPY tuberculosis FROM 'data/tuberculosis.csv';

SELECT * FROM tuberculosis;

-- Make country table
CREATE TABLE country(
    CountryCode TEXT NOT NULL PRIMARY KEY,
    CountryName TEXT,
    ContinentCode TEXT,
    ContinentName TEXT,
);

COPY country FROM 'data/country.csv';

SELECT * FROM country;

-- Make socioecon table
CREATE TABLE socioecon(
    CountryCode TEXT NOT NULL,
    Year INTEGER NOT NULL CHECK BETWEEN 2000 AND 2025,
    GDPCapita REAL,
    ForeignInvestment REAL,
    LifeExpectancy REAL,
    Population REAL,
    PRIMARY KEY(CountryCode, Year),
);

COPY socioecon FROM 'data/socioecon.csv';

SELECT * FROM socioecon;


-- Question: How is tuberculosis incidence correlated with GDP?
CREATE TABLE tb_gdp AS
    SELECT tb.CountryCode, c.CountryName, tb.Year, tb.Incidence, s.GDPCapita
    FROM tuberculosis tb
    JOIN country c ON tb.CountryCode = c.CountryCode
    JOIN socioecon s ON tb.CountryCode = s.CountryCode AND tb.Year = s.Year
    WHERE tb.Incidence IS NOT NULL AND s.GDPCapita IS NOT NULL;

SELECT * FROM tb_gdp;

-- Countries with the highest TB rates
SELECT tb.CountryCode, c.CountryName, tb.Year, tb.Incidence, s.GDPCapita
    FROM tuberculosis tb
    JOIN country c ON tb.CountryCode = c.CountryCode
    JOIN socioecon s ON tb.CountryCode = s.CountryCode AND tb.Year = s.Year
    WHERE tb.Incidence IS NOT NULL AND s.GDPCapita IS NOT NULL AND tb.Year = 2023
    ORDER BY Incidence DESC
    LIMIT 10;

-- Richest countries
SELECT tb.CountryCode, c.CountryName, tb.Year, tb.Incidence, s.GDPCapita
    FROM tuberculosis tb
    JOIN country c ON tb.CountryCode = c.CountryCode
    JOIN socioecon s ON tb.CountryCode = s.CountryCode AND tb.Year = s.Year
    WHERE tb.Incidence IS NOT NULL AND s.GDPCapita IS NOT NULL AND tb.Year = 2023
    ORDER BY GDPCapita DESC
    LIMIT 10;