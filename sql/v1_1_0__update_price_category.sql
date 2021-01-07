ALTER TABLE house_price_raw
ADD COLUMN house_price_category VARCHAR(20); 

UPDATE house_price_raw
SET house_price_category = CASE WHEN price < 10000 THEN 'Below 10K'
                                WHEN price >= 10000 AND price < 20000 THEN '10K - 20K'
                                WHEN price >= 20000 AND price < 30000 THEN '20K - 30K'
                                WHEN price >= 30000 AND price < 40000 THEN '30K - 40K'
                                WHEN price >= 40000 THEN 'Above 50K'
                            END;