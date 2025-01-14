.headers on
--How many parts in a %CAN% container does every supplier from RUSSIA oﬀer?  
--Print the name of the supplier and the number of parts.
SELECT DISTINCT s.s_name as supplier, count(s.s_name) as cnt
FROM supplier s 
JOIN nation n on n.n_nationkey = s.s_nationkey
JOIN partsupp ps on ps.ps_suppkey = s.s_suppkey
JOIN part p on p.p_partkey = ps.ps_partkey
WHERE n.n_name = 'RUSSIA' and p.p_container like '%CAN%'
GROUP BY s.s_name;