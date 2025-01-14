.headers on
--Find the minimum and maximum discount 
--for every part having MEDIUM or TIN in its type.
SELECT p.p_type as part_type, MIN(l.l_discount), MAX(l.l_discount)
from lineitem l 
JOIN part p on p.p_partkey = l.l_partkey
WHERE p_type like '%MEDIUM%' or p_type like '%TIN%'
GROUP BY p.p_type;