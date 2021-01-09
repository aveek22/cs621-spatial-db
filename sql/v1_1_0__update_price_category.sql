ALTER TABLE mumbai_house_price_raw
ADD COLUMN house_price_category VARCHAR(20); 

UPDATE mumbai_house_price_raw
SET house_price_category = CASE WHEN price < 20000 THEN 'Below 20K'
                                WHEN price >= 20000 AND price < 40000 THEN '20K - 40K'
                                WHEN price >= 40000 THEN 'Above 50K'
                            END;