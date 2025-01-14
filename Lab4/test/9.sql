.headers on
--Find the number of distinct orders completed in 1994 by 
--the suppliers in every nation in AMERICA. 
--An order status of F stands for complete. 
--Print only those nations for which the number of orders is larger than 250.
SELECT n.n_name as country, count(DISTINCT o.o_orderkey) as cnt
FROM lineitem l

JOIN orders o on o.o_orderkey = l.l_orderkey

JOIN supplier s on s.s_suppkey = l.l_suppkey
JOIN nation n on n.n_nationkey = s.s_nationkey
JOIN region r on r.r_regionkey = n.n_regionkey --America
WHERE r.r_name = 'AMERICA' and o.o_orderdate like '1994%' and o.o_orderstatus = 'F'

GROUP BY n.n_name

HAVING COUNT(DISTINCT o.o_orderkey) > 250;

