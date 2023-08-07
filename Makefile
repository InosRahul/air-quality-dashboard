build:
	meltano install

pipeline:
	meltano run tap-spreadsheets-anywhere target-parquet
	mkdir -p data/data_catalog/air_quality
	meltano invoke dbt-duckdb deps
	meltano invoke dbt-duckdb build

evidence-build:
	cd analyze && npm i -force
	cd analyze && mkdir -p data_catalog
	cp -r data/data_catalog/* analyze/data_catalog
	cp analyze/data_catalog/mdsbox.db analyze/

evidence-run:
	cd analyze && npm run dev -- --host 0.0.0.0

evidence-visuals:
	make evidence-build
	make evidence-run