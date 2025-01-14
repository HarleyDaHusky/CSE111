.headers on
--How many diﬀerent order clerks did the suppliers in IRAQ work with?
SELECT count(DISTINCT o.o_clerk) as clerks
from lineitem l
JOIN supplier s on s.s_suppkey = l.l_suppkey
JOIN nation n on n.n_nationkey = s.s_nationkey
JOIN orders o on o.o_orderkey = l.l_orderkey
WHERE n.n_name = 'IRAQ';

