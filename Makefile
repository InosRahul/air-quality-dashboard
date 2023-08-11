build:
	meltano install

pipeline:
	meltano run tap-spreadsheets-anywhere target-parquet
	mkdir -p data/data_catalog/air_quality
	meltano invoke dbt-duckdb deps
	meltano invoke dbt-duckdb build

streamlit-visuals:
	streamlit run app.py --server.headless true