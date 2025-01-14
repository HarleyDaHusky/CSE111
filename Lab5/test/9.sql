.headers on
--How many suppliers in every region have more balance in their account 
--than the average account balance of their own region?
select r.r_name as region, count(distinct s.s_suppkey) as supp_cnt
from supplier s
join nation n on s.s_nationkey = n.n_nationkey
join region r on r.r_regionkey = n.n_regionkey

where s.s_acctbal > (select avg(s2.s_acctbal) 
    from supplier s2 
    join nation n2 on s2.s_nationkey = n2.n_nationkey
    join region r2 on r2.r_regionkey = n2.n_regionkey
    where r2.r_regionkey = r.r_regionkey)

group by r.r_name;