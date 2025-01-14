.headers on
--Find how many suppliers from PERU supply more than 40 diﬀerent parts.
select count(*) as suppliers_cnt
from(
    select s.s_suppkey
    from supplier s
    join lineitem l on s.s_suppkey = l.l_suppkey
    join nation n on s.s_nationkey = n.n_nationkey
    where n.n_name =  'PERU'
    group by s.s_suppkey
    having count(l.l_partkey) > 40
);