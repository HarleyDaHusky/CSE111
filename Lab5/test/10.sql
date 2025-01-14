.headers on
-- how many customers not from america, europe 
select count(*) as cust_cnt
from customer c 
join nation n on n.n_nationkey = c.c_nationkey
join region r on r.r_regionkey = n.n_regionkey
where r.r_name not in ('AMERICA', 'EUROPE');