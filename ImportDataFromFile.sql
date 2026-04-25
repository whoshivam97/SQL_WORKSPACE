COPY customer_table FROM 'C:\tmp\copy.csv' WITH (FORMAT csv, HEADER true);

COPY customer_table
FROM 'C:\\tmp\\copytext.txt'
WITH (FORMAT text, DELIMITER ',', HEADER true);

