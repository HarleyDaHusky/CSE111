.headers on
--Find the supplier-customer pair(s) with the most expensive (o totalprice) 
--order(s) completed (i.e., value of o orderstatus is F). 
--Print the supplier name, the customer name, and the total price.
select s.s_name as supplier, c.c_name as customer, o.o_totalprice as price
from orders o
join customer c on c.c_custkey = o.o_custkey
join lineitem l on l.l_orderkey = o.o_orderkey
join supplier s on s.s_suppkey = l.l_suppkey
where o.o_orderstatus = 'F' and price = (
    select max(o2.o_totalprice)
    from orders o2
    where o2.o_orderstatus = 'F'
)
group by s.s_name, c.c_name, o.o_totalprice