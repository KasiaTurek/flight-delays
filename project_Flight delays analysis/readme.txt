FLIGHT
	MONTH: 			Month
	DAY_OF_MONTH: 		Day of the month (1-31)
	DAY_OF_WEEK: 		Day of the week
	OP_UNIQUE_CARRIER: 	Carrier code, matches to OP_UNIQUE_CARRIER in other files
	TAIL_NUM: 		Unique tail number, matches to TAIL_NUM in other files
	OP_CARRIER_FL_NUM: 	Flight number
	ORIGIN_AIRPORT_ID: 	Airport ID, matches to ORIGIN_AIRPORT_ID in other files
	ORIGIN: 		Origin airport abbreviation
	ORIGIN_CITY_NAME: 	Origin city name
	DEST_AIRPORT_ID: 	Destination airport ID, matches Airport ID in other files
	DEST: 			Destination airport abbreviation
	DEST_CITY_NAME: 	Destination city name
	CRS_DEP_TIME: 		Planned departure time
	DEP_TIME: 		Actual departure time
	DEP_DELAY_NEW: 		Departure delay in minutes
	DEP_DEL15:		TARGET VARIABLE Binary if delayed over 15 min, 1 is yes
	DEP_TIME_BLK:		Departure time block
	CRS_ARR_TIME:		Planned arrival time
	ARR_TIME:		Actual arrival time
	ARR_DELAY_NEW:		Arrival delay in minutes
	ARR_TIME_BLK:		Arrival time block
	CANCELLED:		Flag if flight was cancelled
	CANCELLATION_CODE:	Cancellation Code
	CRS_ELAPSED_TIME:	Flight planned elapsed time
	ACTUAL_ELAPSED_TIME:	Flight actual elapsed time
	DISTANCE:		Flight Distance in miles
	DISTANCE_GROUP:		Flight distance group
	CARRIER_DELAY:		Flag for a carrier delay
	WEATHER_DELAY:		Flag for a weather delay
	NAS_DELAY:		Flag for a NAS delay
	SECURITY_DELAY:		Flag for a security delay
	LATE_AIRCRAFT_DELAY:	Flag for a late aircraft delay

AIRPORTS_LIST
	ORIGIN_AIRPORT_ID: 	Airport ID, matches to ORIGIN_AIRPORT_ID in other files
	DISPLAY_AIRPORT_NAME: 	Display Airport, matches to DISPLAY_AIRPORT_NAME in other files
	ORIGIN_CITY_NAME: 	City
	NAME: 			Matches to NAME in airport_weather

AIRPORT_WEATHER
	See GHCND_documentation.pdf for full list
	Important features:
	NAME: 			Location of reading
	PRCP: 			Inches of precipitation for day
	SNOW: 			Inches of snowfall for day
	SNWD: 			Inches of snow on ground for day
	TMAX: 			Max temperature for day
	AWND: 			Max wind speed for day

AIRCRAFT
	MANUFACTURE_YEAR: 	Manufacture year
	TAIL_NUM: 		Unique tail number, matches to TAIL_NUM in other files
	NUMBER_OF_SEATS: 	Number of seats on aircraft

