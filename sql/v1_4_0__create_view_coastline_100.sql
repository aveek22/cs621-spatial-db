CREATE OR REPLACE VIEW vw_mumbai_natural_coastline_buffer_100
AS
SELECT 
	ogc_fid,
	full_id,
	name,
	ST_BUFFER(wkb_geometry, 1000, 'side=left') as buffer_zone
FROM mumbai_natural_coastline;