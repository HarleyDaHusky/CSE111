.headers on
--How many orders are posted by customers in every country in MIDDLE EAST?
SELECT DISTINCT n.n_name as country, count(n.n_name) as cnt
FROM region r
JOIN nation n on n.n_regionkey = r.r_regionkey
JOIN customer c on c.c_nationkey = n.n_nationkey
JOIN orders o on o.o_custkey = c.c_custkey
WHERE r.r_name = 'MIDDLE EAST'
GROUP BY n.n_name;