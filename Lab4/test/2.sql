.headers on
--Find the number of orders posted by every customer from MOZAMBIQUE in 1997.
select DISTINCT c.c_name as customer, count(c.c_name) as cnt
FROM orders o 
JOIN customer c on c.c_custkey = o.o_custkey
JOIN nation n on n.n_nationkey = c.c_nationkey
WHERE o_orderdate like '1997%' and n.n_name = 'MOZAMBIQUE'
GROUP BY c.c_name;
