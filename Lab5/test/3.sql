.headers on
--How many customers from every region have placed at least one order 
--and have more than the average account balance?
select r.r_name as region, count(distinct c.c_name) as cust_cnt
from customer c 
join orders o on o.o_custkey = c.c_custkey
join nation n on n.n_nationkey = c.c_nationkey
join region r on r.r_regionkey = n.n_regionkey

where c.c_acctbal > (select avg(c2.c_acctbal) from customer c2)

group by r.r_name;
