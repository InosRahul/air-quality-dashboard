with aggregated_data as (
  select *
  from {{ ref('air_quality_aggregate') }}
)

select
  country_name,
  city,
  year,
  avg_pm10_concentration,
  avg_pm25_concentration,
  avg_no2_concentration,
  avg_pm10_tempcov,
  avg_pm25_tempcov,
  avg_no2_tempcov,
  population,
  latitude,
  longitude,
  case
    when avg_pm10_concentration > 50 then 'High'
    when avg_pm10_concentration > 20 then 'Moderate'
    else 'Low'
  end as pm10_category,
  case
    when avg_pm25_concentration > 25 then 'High'
    when avg_pm25_concentration > 10 then 'Moderate'
    else 'Low'
  end as pm25_category,
  case
    when avg_no2_concentration > 40 then 'High'
    when avg_no2_concentration > 20 then 'Moderate'
    else 'Low'
  end as no2_category
from aggregated_data
