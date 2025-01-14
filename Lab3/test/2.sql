.headers on
SELECT MIN(c_acctbal) AS min_balance, 
MAX(c_acctbal) AS max_balance, 
SUM(c_acctbal) AS total_balance
FROM customer
WHERE c_mktsegment = 'FURNITURE';
