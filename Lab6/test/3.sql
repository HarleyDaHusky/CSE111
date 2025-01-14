.headers on
--Find the distinct parts (p name) ordered by customers from ASIA that are 
--supplied by exactly 3 suppliers from AFRICA
select distinct p.p_name as part
from part p
join lineitem l on l.l_partkey = p.p_partkey
join orders o on o.o_orderkey = l.l_orderkey
join customer c on c.c_custkey = o.o_custkey
join nation n1 on n1.n_nationkey = c.c_nationkey
join region r1 on r1.r_regionkey = n1.n_regionkey

join partsupp ps on l.l_partkey = ps.ps_partkey and l.l_suppkey = ps.ps_suppkey
join supplier s on s.s_suppkey = ps.ps_suppkey
-- join supplier s on s.s_suppkey = l.l_suppkey
join nation n on n.n_nationkey = s.s_nationkey
join region r on r.r_regionkey = n.n_regionkey

where r1.r_name = 'ASIA' and r.r_name = 'AFRICA'
group by p.p_name
having (count(distinct s.s_suppkey)=3);
    -- from supplier s2
    -- join lineitem l2 on s2.s_suppkey = l2.l_suppkey
    -- join orders o2 ON o2.o_orderkey = l2.l_orderkey
    -- join nation n3 on n3.n_nationkey = s2.s_nationkey
    -- join region r3 on r3.r_regionkey = n3.n_regionkey
    -- where l2.l_orderkey = o.o_orderkey and r3.r_name = 'AFRICA'
--) = 3;