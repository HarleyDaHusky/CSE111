.headers on
--What is the total supply cost (ps_supplycost) for parts less expensive than $1500
--(p_retailprice) shipped in 1996 (l_shipdate) by suppliers who did not supply any 
--line item with an extended price less than 1800 in 1998
select SUM(ps.ps_supplycost) as total_supply_cost
from partsupp ps
join part p on ps.ps_partkey = p.p_partkey
join lineitem l on p.p_partkey = l.l_partkey
join supplier s on s.s_suppkey = ps.ps_suppkey
where p.p_retailprice < 1500 and l.l_shipdate like '1996%' and s.s_suppkey not in (
  select l2.l_suppkey 
  from lineitem l2
  where l2.l_extendedprice < 1800 and l2.l_shipdate like '1998%'
);
