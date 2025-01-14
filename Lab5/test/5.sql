.headers on
--Find the highest value line item(s) (l_extendedprice*(1-l_discount)) 
--shipped after Octboer 5, 1994. 
--Print the name of the part corresponding to these line item(s).
select p.p_name as part 
from lineitem l
join part p on p.p_partkey = l.l_partkey
where l.l_shipdate > '1994-10-05' and l.l_extendedprice * (1 - l.l_discount) = (
    select max(l2.l_extendedprice * (1 - l2.l_discount))
    from lineitem l2
    where l2.l_shipdate > '1994-10-05'
  );