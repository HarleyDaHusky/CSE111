.headers on
--How many line items ordered by Customer#000000227 
--were received every month? Print the number of ordered line items 
--corresponding to every (year, month) pair from l receiptdate.
SELECT SUBSTR(l.l_receiptdate, 1, 7) as year_month, count(l.l_receiptdate)
FROM lineitem l
JOIN orders o on o.o_orderkey = l.l_orderkey
JOIN customer c on c.c_custkey = o.o_custkey
WHERE c.c_name = 'Customer#000000227'
GROUP BY SUBSTR(l.l_receiptdate, 1, 7);
