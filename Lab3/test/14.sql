.headers on
--Find the number of orders having status F. 
--Group these orders based on the region of the customer who posted the order. 
--Print the region name and the number of status F orders.
SELECT r_name as r_name, count(o_orderstatus) as order_cnt
FROM region r 
JOIN nation n on n.n_regionkey = r.r_regionkey
JOIN customer c on c.c_nationkey = n.n_nationkey
JOIN orders o on o.o_custkey = c.c_custkey
WHERE o.o_orderstatus = 'F'
GROUP BY r.r_name;