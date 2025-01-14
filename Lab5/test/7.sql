.headers on
--Print the name of the parts supplied by suppliers from ARGENTINA
--that have total value in the top 10% total values across all the supplied parts.
--The total value is ps_supplycost*ps_availqty.
--Hint: Use the limit keyword with a SELECT subquery

select distinct p.p_name as part 
from part p
join partsupp ps on p.p_partkey = ps.ps_partkey
join supplier s on ps.ps_suppkey = s.s_suppkey
join nation n on n.n_nationkey = s.s_nationkey

where n.n_name = 'ARGENTINA' and (ps.ps_supplycost*ps.ps_availqty) in (
    select ps.ps_supplycost*ps.ps_availqty as total_cost
    from partsupp ps
    order by total_cost DESC
    limit (select count(*)/10 from partsupp)
);