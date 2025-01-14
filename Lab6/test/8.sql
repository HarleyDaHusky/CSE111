.headers on
--Find how many suppliers have less than 50 distinct orders from 
--customers in EGYPT and JORDAN together
select count(*) as supplier_cnt
from (
    select s.s_suppkey 
    from supplier s
    join lineitem l on l.l_suppkey = s.s_suppkey
    join orders o on o.o_orderkey = l.l_orderkey
    join customer c on c.c_custkey = o.o_custkey
    join nation n on n.n_nationkey = c.c_nationkey
    where n.n_name = 'EGYPT' or n.n_name = 'JORDAN'
    group by s.s_suppkey
    having count(distinct o.o_orderkey) < 50);
