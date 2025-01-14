.headers on
--How many unique parts produced by every supplier in ARGENTINA are 
--ordered at every priority? 
--Print the supplier name, the order priority, and the number of parts.
select s.s_name as supplier, o.o_orderpriority as priority, count(distinct p.p_partkey)
FROM lineitem l
JOIN supplier s on s.s_suppkey = l.l_suppkey
JOIN part p on p.p_partkey = l.l_partkey
JOIN orders o on o.o_orderkey = l.l_orderkey
JOIN nation n on n.n_nationkey = s.s_nationkey
WHERE n.n_name = 'ARGENTINA'
GROUP BY s.s_name, o.o_orderpriority;
