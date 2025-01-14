.headers on
--Find the total price paid on orders by every customer from GERMANY in 1992. 
--Print the customer name and the total price.
select DISTINCT c.c_name as customer, SUM(o.o_totalprice) as total_price
FROM orders o 
JOIN customer c on c.c_custkey = o.o_custkey
JOIN nation n on n.n_nationkey = c.c_nationkey
WHERE o.o_orderdate like '1992%' and n.n_name = 'GERMANY'
GROUP BY c.c_name;
