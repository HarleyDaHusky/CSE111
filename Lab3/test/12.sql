.headers on
--Find the total number of line items on orders with priority 3-MEDIUM 
--supplied by suppliers from ARGENTINA and BRAZIL. 
--Group these line items based on the year of the order from o orderdate. 
--Print the year and the count. Check the substr function in SQLite.
select SUBSTR(o.o_orderdate, 1, 4) as year, count(o.o_orderpriority) as item_cnt
FROM orders o
JOIN lineitem l on l.l_orderkey = o.o_orderkey
JOIN supplier s on s.s_suppkey = l.l_suppkey
JOIN nation n on n.n_nationkey = s.s_nationkey
WHERE (n.n_name = 'ARGENTINA' or n.n_name = 'BRAZIL') and o.o_orderpriority = '3-MEDIUM'
GROUP BY SUBSTR(o.o_orderdate, 1, 4);