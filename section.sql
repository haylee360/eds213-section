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
