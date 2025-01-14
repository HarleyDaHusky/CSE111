.headers on
--For parts whose type contains NICKEL, return the name of the supplier from AFRICA 
--that can supply them at maximum cost (ps supplycost), for every part size.  
--Print the supplier name together with the part size and the maximum cost.
select s.s_name as supplier, p.p_size as part_size, max(ps.ps_supplycost) as max_cost
from part p 
join partsupp ps on ps.ps_partkey = p.p_partkey
join supplier s on s.s_suppkey = ps.ps_suppkey
join nation n on n.n_nationkey = s.s_nationkey
join region r on r.r_regionkey = n.n_regionkey

where p.p_type like '%NICKEL%' and r.r_name = 'AFRICA' 

group by p.p_size;