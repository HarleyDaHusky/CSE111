.headers on
--Find how many distinct customers have at least one order supplied 
--exclusively by suppliers from AFRICA. 
select count(distinct c.c_name) as customer_cnt
from orders o 
join customer c on c.c_custkey = o.o_custkey
join lineitem l on o.o_orderkey = l.l_orderkey
join supplier s on l.l_suppkey = s.s_suppkey
join nation n on n.n_nationkey = s.s_nationkey
join region r on r.r_regionkey = n.n_regionkey

WHERE r.r_name = 'AFRICA' and not exists (
    select 1
    from orders o3
    join lineitem l3 on o3.o_orderkey = l3.l_orderkey
    join supplier s3 on l3.l_suppkey = s3.s_suppkey
    join nation n3 on n3.n_nationkey = s3.s_nationkey
    join region r3 on r3.r_regionkey = n3.n_regionkey
    where o3.o_orderkey = o.o_orderkey 
    and r3.r_name <> 'AFRICA'
);