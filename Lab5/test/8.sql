.headers on
--Based on the available quantity of items, who is the manufactuer p_mfgr
--of the most popular item (the more popular an item is, 
--the less available it is in ps_availqty) from Supplier#000000084?
select p.p_mfgr as manufacturer 
from part p 
join partsupp ps on ps.ps_partkey = p.p_partkey
join supplier s on s.s_suppkey = ps.ps_suppkey
where s.s_name like 'Supplier#000000084'
order by ps.ps_availqty ASC
LIMIT 1;