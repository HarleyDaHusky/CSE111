.headers on
--For the line items order in Februrary 1996 (o.o_orderdate), find the largest 
--discount that is smaller than the average discount among all the orders.
select MAX(l.l_discount) as max_small_disc
from lineitem l
join orders o on l.l_orderkey = o.o_orderkey
where o.o_orderdate like '1996-02%' and l.l_discount < (
    select avg(l2.l_discount)
    from lineitem l2
    join orders o2 on l2.l_orderkey = o2.o_orderkey
    --where o2.o_orderdate like '1996-02%'
);