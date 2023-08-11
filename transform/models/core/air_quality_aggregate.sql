with raw_data as (
  select *
  from {{ ref('air_quality') }}
)

select
  country_name,
  city,
  year,
  avg(pm10_concentration) as avg_pm10_concentration,
  avg(pm25_concentration) as avg_pm25_concentration,
  avg(no2_concentration) as avg_no2_concentration,
  avg(pm10_tempcov) as avg_pm10_tempcov,
  avg(pm25_tempcov) as avg_pm25_tempcov,
  avg(no2_tempcov) as avg_no2_tempcov,
  max(population) as population,
  avg(latitude) as latitude,
  avg(longitude) as longitude
from raw_data
group by country_name, city, year

