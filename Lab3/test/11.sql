.headers on
--Find how many 1-URGENT priority orders have been 
--posted by customers from ROMANIA between 1993 and 1997, combined.
SELECT count(o.o_orderpriority) as order_cnt
from orders o
JOIN customer c on c.c_custkey = o.o_custkey
JOIN nation n on n.n_nationkey = c.c_nationkey
WHERE o.o_orderpriority = '1-URGENT' and o.o_orderdate between '1993-01-01' and '1997-12-31' and n.n_name = 'ROMANIA';