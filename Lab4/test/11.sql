.headers on
--How many distinct orders are between customers 
--with negative account balance and suppliers with positive account balance?
SELECT count(distinct o.o_orderkey) as order_cnt
FROM lineitem l
JOIN orders o on o.o_orderkey = l.l_orderkey
JOIN customer c on c.c_custkey = o.o_custkey

JOIN supplier s on s.s_suppkey = l.l_suppkey

WHERE c.c_acctbal < 0 and s.s_acctbal > 0;