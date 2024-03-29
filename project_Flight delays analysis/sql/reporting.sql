/*
Definiuję schemę `reporting`
*/
DROP SCHEMA IF EXISTS reporting CASCADE;
CREATE SCHEMA reporting;


/*
Tworzę definicję widoku reporting.flight, która:
- będzie usuwać dane o lotach anulowanych `cancelled = 0`
- będzie zawierać kolumnę `is_delayed`, zgodnie z wcześniejszą definicją tj. `is_delayed = 1 if dep_delay_new > 0 else 0` (zaimplementowana w SQL)
*/
CREATE OR REPLACE VIEW reporting.flight as
SELECT 
	*
	, CASE 
		WHEN dep_delay_new > 15 THEN 1 
		ELSE 0
	END AS is_delayed
FROM public.flight 
WHERE cancelled = '0'
;

/*
Tworzę definicję widoku top_airports_by_departure
*/
CREATE OR REPLACE VIEW reporting.top_airports_by_departure AS
WITH cte_departure AS (
	SELECT
		origin_airport_id
		, f.year
		, COUNT(*) AS departures
		, AVG(is_delayed) AS reliability
	FROM reporting.flight AS f
	GROUP BY origin_airport_id, f.year
	ORDER BY departures DESC
	LIMIT 10
),
cte_arrival AS (
	SELECT
		dest_airport_id
		, COUNT(*) AS arrivals
	FROM reporting.flight
	GROUP BY dest_airport_id
)
SELECT
	al.display_airport_name AS origin_airport_name
	, d.departures
	, COALESCE(aa.arrivals, 0) AS arrivals
	, d.year
	, d.reliability
	, DENSE_RANK() OVER(ORDER BY reliability DESC) AS nb
FROM cte_departure AS d
LEFT JOIN cte_arrival AS aa ON d.origin_airport_id = aa.dest_airport_id
LEFT JOIN public.airport_list al ON d.origin_airport_id = al.origin_airport_id
ORDER BY d.reliability DESC
;



/*
Tworzę definicję widoku reporting.top_reliability_roads, która będzie zawierała następujące kolumny:
- `origin_airport_id`,
- `origin_airport_name`,
- `dest_airport_id`,
- `dest_airport_name`,
- `year`,
- `cnt` - jako liczba wykonananych lotów na danej trasie,
- `reliability` - jako odsetek opóźnień na danej trasie,
- `nb` - numerowane od 1, 2, 3 według kolumny `reliability`. W przypadku takich samych wartości powino zwrócić 1, 2, 2, 3... 
*/
CREATE OR REPLACE VIEW reporting.top_reliability_roads AS
WITH cte AS (
	SELECT 
		f.origin_airport_id
		, al.display_airport_name AS origin_airport_name
		, f.dest_airport_id
		, aal.display_airport_name AS dest_airport_name
		, f.year
		, COUNT(*) AS cnt
		, AVG(f.is_delayed) AS reliability
	FROM reporting.flight AS f
	LEFT JOIN public.airport_list AS al ON f.origin_airport_id = al.origin_airport_id
	LEFT JOIN public.airport_list AS aal ON f.dest_airport_id = aal.origin_airport_id
	GROUP BY f.origin_airport_id, origin_airport_name, f.dest_airport_id, dest_airport_name, f.year
)
SELECT
	*
	, DENSE_RANK() OVER(ORDER BY reliability DESC) AS nb
FROM cte
WHERE cnt > 10000;


/*
Tworzę definicję widoku reporting.year_to_year_comparision, która będzie zawierał następujące kolumny:
- `year`
- `month`,
- `flights_amount`
- `reliability`
*/
CREATE OR REPLACE VIEW reporting.year_to_year_comparision AS
SELECT
	year
	, month
	, COUNT(*) AS flights_amount
	, AVG(is_delayed) AS reliability
FROM reporting.flight
GROUP BY year, month;


/*
Tworzę definicję widoku reporting.day_to_day_comparision, który będzie zawierał następujące kolumny:
- `year`
- `day_of_week`
- `flights_amount`
*/
CREATE OR REPLACE VIEW reporting.day_to_day_comparision AS
SELECT
	year
	, day_of_week
	, COUNT(*) AS flights_amount
	, AVG(is_delayed) AS reliability
FROM reporting.flight
GROUP BY year, day_of_week;


/*
Tworzę definicję widoku reporting.day_by_day_reliability, ktory będzie zawierał następujące kolumny:
- `date` jako złożenie kolumn `year`, `month`, `day`, powinna być typu `date`
- `reliability` jako odsetek opóźnień danego dnia
*/
CREATE OR REPLACE VIEW reporting.day_by_day_reliability AS
SELECT
	TO_DATE(CONCAT(year, LPAD(month::TEXT, 2, '0'), LPAD(day_of_month::TEXT, 2, '0')), 'YYYYMMDD') AS date
	, AVG(is_delayed) AS reliability
FROM reporting.flight
GROUP BY date;