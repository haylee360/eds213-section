# Tuberculosis Incidence Rates and Socioeconomic Indicators Across Countries
![](https://etimg.etb2bimg.com/photo/116440231.cms)

This repository houses a database and associated analysis for global tuberculosis incidence rates and socioeconomic indicators from 2000-2024.

## Description

The file `tbquery.sql` houses the code for importing data into a DuckDB database. The database itself can be accessed in `tbdatabase.db`. The code for working with the database data and creating a visualization can be found in `tbvisualization.ipynb`.

```
├── data
|   ├── country.csv
|   ├── socioecon.csv
|   └── tuberculosis.csv
├── README.md
├── tb-cleaning.ipynb
├── tb-query.sql
├── tb-visualization.qmd
└── tbdatabase.db
```

## Data Access
Data on tuberculosis incidence rates were accessed via [The World Health Organization](https://www.who.int/data/gho/data/indicators/indicator-details/GHO/incidence-of-tuberculosis-(per-100-000-population-per-year)). Data on socioeconomic indicators was accessed via [World Bank Open Data](https://databank.worldbank.org/reports.aspx?source=2&series=NY.GDP.MKTP.CD&country=).

The cleaned version of these data files can be found in the `data` folder in this repository.

## Contributors 
Author: [Haylee Oyler](github.com/haylee360)

## References and Acknowledgements
This project was completed under the guidance of [Dr. Julien Brun](https://github.com/brunj7), [Greg Janée](https://bren.ucsb.edu/people/greg-janee-1), and [Annie Adams](https://github.com/annieradams) as part of the course [EDS 213: Databases and Data Management](https://ucsb-library-research-data-services.github.io/bren-eds213/).

- Estimated incidence of tuberculosis (per 100 000 population). (n.d.). World Health Organization. Retrieved April 13, 2025, from https://www.who.int/data/gho/data/indicators/indicator-details/GHO/incidence-of-tuberculosis-(per-100-000-population-per-year)
- World Development Indicators | DataBank. (n.d.). World Bank Group. Retrieved April 13, 2025, from https://databank.worldbank.org/reports.aspx?source=2&series=NY.GDP.MKTP.CD&country=
