SELECT * FROM mumbai_house_price_raw;

--------------------------------------------------------------------------------------

ALTER TABLE mumbai_house_price_raw
ADD COLUMN house_price_category VARCHAR(20); 

UPDATE mumbai_house_price_raw
SET house_price_category = CASE WHEN price < 20000 THEN 'Below 20K'
                                WHEN price >= 20000 AND price < 40000 THEN '20K - 40K'
                                WHEN price >= 40000 THEN 'Above 50K'
                            END;
							
							
--------------------------------------------------------------------------------------

CREATE OR REPLACE VIEW vw_mumbai_houses_airport_5km
AS
SELECT *
FROM mumbai_house_price_raw
WHERE 1=1
AND ST_DISTANCE(
	ST_TRANSFORM(ST_GEOMFROMTEXT('POINT(72.874374 19.096713)',4326), 7755),
	ST_TRANSFORM((geometry),7755)
) <= 5000;

-------------------------------------------------------------------------------------

CREATE OR REPLACE VIEW vw_mumbai_natural_coastline_buffer_100
AS
SELECT 
	ogc_fid,
	full_id,
	name,
	ST_BUFFER(wkb_geometry, 1000, 'side=left') as buffer_zone
FROM mumbai_natural_coastline;

-------------------------------------------------------------------------------------

CREATE OR REPLACE VIEW vw_mumbai_houses_airport_5km_west_facing
AS
SELECT * FROM vw_mumbai_houses_airport_5km
WHERE 1=1
AND "desc" ~ '^.*(W|w)est (F|f)acing.*$'

