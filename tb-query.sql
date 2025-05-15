-- Make TB table
CREATE TABLE tuberculosis (
    CountryCode TEXT,
    Year INTEGER CHECK BETWEEN 2000 AND 2025,
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
    CountryCode TEXT PRIMARY KEY,
    CountryName TEXT,
    ContinentCode TEXT,
    ContinentName TEXT,
);

COPY country FROM 'data/country.csv';

SELECT * FROM country;

-- Make socioecon table
CREATE TABLE socioecon(
    CountryCode TEXT,
    Year INTEGER CHECK BETWEEN 2000 AND 2025,
    GDPCapita REAL,
    ForeignInvestment REAL,
    LifeExpectancy REAL,
    Population REAL,
    PRIMARY KEY(CountryCode, Year),
);

COPY socioecon FROM 'data/socioecon.csv';

SELECT * FROM socioecon;


-- Question: How is tuberculosis incidence correlated with GDP?

SELECT MAX(Incidence) AS Max_incidence, CountryCode, Year FROM tuberculosis
    JOIN socioecon USING (CountryCode, Year);
    GROUP BY (CountryCode, Year)
    ORDER BY Max_incidence DESC
    LIMIT 15;

CREATE TABLE tb_gdp AS
    SELECT tb.CountryCode, c.CountryName, tb.Year, tb.Incidence, s.GDPCapita
    FROM tuberculosis tb
    JOIN country c ON tb.CountryCode = c.CountryCode
    JOIN socioecon s ON tb.CountryCode = s.CountryCode AND tb.Year = s.Year
    WHERE tb.Incidence IS NOT NULL AND s.GDPCapita IS NOT NULL;

SELECT * FROM tb_gdp;


SELECT tb.CountryCode, c.CountryName, tb.Year, 
    MAX(tb.Incidence) AS Max_incidence, ANY_VALUE(s.GDPCapita) AS GDPCapita
    FROM tuberculosis tb
    JOIN country c ON tb.CountryCode = c.CountryCode
    JOIN socioecon s ON tb.CountryCode = s.CountryCode AND tb.Year = s.Year
    WHERE tb.Incidence IS NOT NULL AND s.GDPCapita IS NOT NULL 
        AND tb.Year = 2023
    GROUP BY tb.CountryCode, c.CountryName, tb.Year
    ORDER BY Max_incidence DESC
    LIMIT 10;

SELECT tb.CountryCode, c.CountryName, tb.Year, 
    ANY_VALUE(tb.Incidence) AS Incidence, MAX(s.GDPCapita) AS Max_GDPCapita
    FROM tuberculosis tb
    JOIN country c ON tb.CountryCode = c.CountryCode
    JOIN socioecon s ON tb.CountryCode = s.CountryCode AND tb.Year = s.Year
    WHERE tb.Incidence IS NOT NULL AND s.GDPCapita IS NOT NULL 
        AND tb.Year = 2023
    GROUP BY tb.CountryCode, c.CountryName, tb.Year
    ORDER BY Max_GDPCapita DESC
    LIMIT 10;

SELECT tb.CountryCode, c.CountryName, tb.Year, 
    MAX(tb.Incidence) AS Incidence, AVG(s.GDPCapita) AS GDPCapita
    FROM tuberculosis tb
    JOIN country c ON tb.CountryCode = c.CountryCode
    JOIN socioecon s ON tb.CountryCode = s.CountryCode AND tb.Year = s.Year
    WHERE tb.Incidence IS NOT NULL AND s.GDPCapita IS NOT NULL 
        AND tb.Year = 2023
    GROUP BY tb.CountryCode, c.CountryName, tb.Year
    ORDER BY GDPCapita DESC
    LIMIT 10;


SELECT * FROM a LEFT JOIN b ON a.common = b.common;

SELECT * FROM socioecon 
    WHERE CountryCode = 'MCO';

SELECT * FROM tuberculosis 
    WHERE CountryCode = 'MCO';

SELECT * FROM country 
    WHERE CountryCode = 'MCO';

SELECT * FROM tb_gdp
    WHERE CountryCode = 'MCO';

CREATE TABLE country_deduped AS
SELECT DISTINCT CountryCode, CountryName, ContinentCode, ContinentName
FROM country;

SELECT * FROM country_deduped
    WHERE CountryCode = 'MCO';

DROP TABLE country;
ALTER TABLE country_deduped RENAME TO country;