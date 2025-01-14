.headers on
--Find how many parts are supplied by exactly one supplier from UNITED STATES.
select count(*) as part_cnt
from (select ps.ps_partkey
    from partsupp ps
    join supplier s on ps.ps_suppkey = s.s_suppkey
    join nation n on n.n_nationkey = s.s_nationkey
    where n.n_name = 'UNITED STATES'
    group by ps.ps_partkey
    having count(distinct ps.ps_suppkey) = 1
    );