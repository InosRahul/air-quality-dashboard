import streamlit as st
import duckdb


aqi_duck = duckdb.connect('mdsbox.db', read_only=True)

# Sidebar filters
selected_country = st.sidebar.selectbox("Select Country", aqi_duck.execute("SELECT DISTINCT country_name FROM air_quality").fetchdf()['country_name'])

# Filter cities based on selected country
query_cities = f"SELECT DISTINCT city FROM air_quality WHERE country_name = '{selected_country}'"
cities = aqi_duck.execute(query_cities).fetchdf()['city']
selected_city = st.sidebar.selectbox("Select City", cities)

# Filter data based on selected country and city
query = f"""
SELECT * FROM air_quality_final 
WHERE country_name = '{selected_country}' 
AND city = '{selected_city}'
ORDER BY year
"""
df = aqi_duck.execute(query).fetchdf()

# Display selected country and city
st.title(f"Air Quality Dashboard - {selected_city}, {selected_country}")

# Visualizations
st.subheader("Average PM10 Concentration Over Years")
st.line_chart(data=df, x='year', y='avg_pm10_concentration')

st.subheader("Average PM2.5 Concentration Over Years")
st.line_chart(data=df, x='year', y='avg_pm25_concentration')

st.subheader("Average NO2 Concentration Over Years")
st.line_chart(data=df, x='year', y='avg_no2_concentration')

st.subheader("Values Over Years")
st.dataframe(df[['year', 'country_name', 'city', 'pm10_category', 'pm25_category', 'no2_category']], 
             column_config={
                "year": "Year",
                "country_name": "Country",
                "city": "City",
                "pm10_category": "PM10 Type",
                "pm25_category": "PM25 Type",
                "no2_category": "NO2 Type",
            },
             hide_index=True, 
             use_container_width=True)

