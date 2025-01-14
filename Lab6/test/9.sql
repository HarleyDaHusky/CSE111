.headers on
--Find how many suppliers supply the least expensive part (p retailprice).
select count(distinct ps.ps_suppkey) as supplier_cnt
from partsupp ps
join part p on ps.ps_partkey = p.p_partkey
where p.p_retailprice = (
    select min(p.p_retailprice)
    from part p
);