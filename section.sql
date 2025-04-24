-- Make TB table
CREATE TABLE tuberculosis (
    CountryCode TEXT,
    Year INTEGER,
    Incidence REAL,
    IncidenceLow REAL,
    IncidenceHigh REAL,
    IncidenceRange REAL,
);

COPY tuberculosis FROM 'data/tuberculosis.csv';

SELECT * FROM tuberculosis;

-- Make country table
CREATE TABLE country(
    CountryCode TEXT,
    CountryName TEXT,
    ContinentCode TEXT,
    ContinentName TEXT,
);

COPY country FROM 'data/country.csv';

SELECT * FROM country;

-- Make socioecon table
CREATE TABLE socioecon(
    CountryCode TEXT,
    Year INTEGER,
    GDPCapita REAL,
    ForeignInvestment REAL,
    LifeExpectancy REAL,
    Population REAL,
);

COPY socioecon FROM 'data/socioecon.csv';

SELECT * FROM socioecon;

-- Question: How is tuberculosis incidence correlated with GDP?

SELECT MAX(Incidence) AS Max_incidence, CountryCode, Year FROM tuberculosis
    JOIN socioecon USING (CountryCode, Year);
    GROUP BY (CountryCode, Year)
    ORDER BY Max_incidence DESC
    LIMIT 15;

-- Want to see the country the highest incidence for each year 
SELECT Incidence, CountryCode, Year FROM tuberculosis
    RIGHT JOIN socioecon USING (CountryCode, Year);

SELECT * FROM a LEFT JOIN b ON a.common = b.common;


