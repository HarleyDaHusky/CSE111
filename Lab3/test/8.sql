.headers on
SELECT DISTINCT n.n_name
FROM nation n
JOIN customer c ON c.c_nationkey = n.n_nationkey
JOIN orders o on o.o_custkey = c.c_custkey
WHERE o.o_orderdate LIKE '1994-12%';



