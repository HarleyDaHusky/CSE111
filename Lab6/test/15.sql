.headers on
--Compute the change in the economic exchange for every country between 
--1996 and 1998. There should be two columns in the output for every country: 
--1997 and 1998.  Hint: use CASE to select the values in the result.
select n1.n_name as country, sum(case
                                when l.l_shipdate like '1997%' and n1.n_nationkey != n2.n_nationkey then l.l_quantity
                                when l.l_shipdate like '1997%' and n1.n_nationkey = n2.n_nationkey then -l.l_quantity
                                else 0
                                end) as '1997',
                            sum(case
                                when l.l_shipdate like '1998%' and n1.n_nationkey != n2.n_nationkey then l.l_quantity
                                when l.l_shipdate like '1998%' and n1.n_nationkey = n2.n_nationkey then -l.l_quantity
                                else 0
                                end) as '1998'
from lineitem l
join orders o on o.o_orderkey = l.l_orderkey
join customer c on c.c_custkey = o.o_custkey
join nation n1 on n1.n_nationkey = c.c_nationkey

join supplier s on s.s_suppkey = l.l_suppkey
join nation n2 on n2.n_nationkey = s.s_nationkey
where l.l_shipdate like '1997%' or l.l_shipdate like '1998%'
group by n1.n_name;