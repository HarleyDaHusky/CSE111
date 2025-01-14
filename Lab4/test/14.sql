.headers on
--How many line items are supplied by suppliers 
--in EUROPE for orders made by customers in INDIA?
SELECT COUNT(*) as items
FROM lineitem l 
JOIN supplier s on s.s_suppkey = l.l_suppkey
JOIN nation n2 on n2.n_nationkey = s.s_nationkey
JOIN region r on r.r_regionkey = n2.n_regionkey

JOIN orders o on o.o_orderkey = l.l_orderkey
JOIN customer c on c.c_custkey = o.o_custkey

JOIN nation n1 on n1.n_nationkey = c.c_nationkey

WHERE n1.n_name = 'INDIA' and r.r_name = 'EUROPE';