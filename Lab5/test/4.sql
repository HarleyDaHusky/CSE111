.headers on
-- Count the number of distinct suppliers that supply part whose type contains 
--brushed and have size equal to any of 10, 20, 30 , or 40.
select count(DISTINCT s.s_suppkey) as supp_cnt
from part p
join partsupp ps on ps.ps_partkey = p.p_partkey
join supplier s on s.s_suppkey = ps.ps_suppkey

WHERE p.p_type like '%brushed%' and (p.p_size = 10 or p.p_size = 20 or p.p_size = 30 or p.p_size = 40);