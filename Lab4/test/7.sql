.headers on
--How many orders do customers in every nation in ASIA have in every status? 
--Print the nation name, the order status, and the count.
SELECT n.n_name as country, o.o_orderstatus as status, count(o.o_orderstatus) as orders
FROM region r 
JOIN nation n on n.n_regionkey = r.r_regionkey
JOIN customer c on c.c_nationkey = n_nationkey
JOIN orders o on o.o_custkey = c.c_custkey
WHERE r.r_name = 'ASIA'
GROUP BY n.n_name, o.o_orderstatus;