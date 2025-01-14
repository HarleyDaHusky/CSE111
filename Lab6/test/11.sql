.headers on
--Find the region where customers spend the largest amount of money 
--(l extendedprice) buying items from suppliers in the same region.
select r.r_name as country
from customer c
join nation n on c.c_nationkey = n.n_nationkey
join orders o on c.c_custkey = o.o_custkey

join lineitem l on o.o_orderkey = l.l_orderkey
join supplier s on s.s_suppkey = l.l_suppkey
join nation n2 on n2.n_nationkey = s.s_nationkey
join region r on r.r_regionkey = n2.n_regionkey and r.r_regionkey = n.n_regionkey

group by r.r_name

order by sum(l.l_extendedprice) desc
limit 1;



