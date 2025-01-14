.headers on
--Find the number of customers who had at most three orders in 
--November 1995 (o orderdate).
select count(*) as customer_cnt
from (
    select c.c_custkey
    from customer c
    join orders o on c.c_custkey = o.o_custkey
    where o.o_orderdate like '1995-11%'
    group by c.c_custkey
    having count(o.o_orderkey) <= 3
);