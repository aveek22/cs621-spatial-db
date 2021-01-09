CREATE OR REPLACE VIEW vw_mumbai_houses_airport_5km_west_facing
AS
SELECT * FROM vw_mumbai_houses_airport_5km
WHERE 1=1
AND "desc" ~ '^.*(W|w)est (F|f)acing.*$'