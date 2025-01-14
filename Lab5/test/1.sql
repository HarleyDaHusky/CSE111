.headers on
--How many customers and suppliers are in every nation from ASIA?
SELECT n_name as country, count(distinct c.c_name) as cust_cnt, count(distinct s.s_name) as supp_cnt
from nation n 

join customer c on c.c_nationkey = n.n_nationkey
join supplier s on s.s_nationkey = n.n_nationkey

join region r on r.r_regionkey = n.n_regionkey

where r.r_name = 'ASIA'

Group by n_name;