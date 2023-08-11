{{ config(materialized='table') }}

SELECT  
who_region,
iso3 as country_code,
country_name,
city,
year,
version,
IF(pm10_concentration = 'NA', NULL, CAST(pm10_concentration as INT)) as pm10_concentration,
IF(pm25_concentration = 'NA', NULL, CAST(pm25_concentration as INT)) as pm25_concentration,
IF(no2_concentration = 'NA', NULL, CAST(no2_concentration as INT)) as no2_concentration,
IF(pm10_tempcov = 'NA', NULL, CAST(pm10_tempcov as INT)) as pm10_tempcov,
IF(pm25_tempcov = 'NA', NULL, CAST(pm25_tempcov as INT)) as pm25_tempcov,
IF(no2_tempcov = 'NA', NULL, CAST(no2_tempcov as INT)) as no2_tempcov,
CASE WHEN
    population LIKE '%http%' or population LIKE '%NA%' THEN NULL
    ELSE CAST(population as signed)
    END as population,
CASE WHEN
    latitude LIKE '%http%' or latitude LIKE '%NA%' THEN NULL
    ELSE CAST(latitude as FLOAT)
    END as latitude,
CASE WHEN
    longitude LIKE '%http%' or longitude LIKE '%NA%' THEN NULL
    ELSE CAST(longitude as FLOAT)
    END AS longitude
FROM {{ source( 'who', 'air_quality' ) }}

