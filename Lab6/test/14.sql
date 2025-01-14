.headers on
--Compute, for every country, the value of economic exchange, i.e., the diﬀerence 
--between the number of items from suppliers in that country sold to customers 
--in other countries and the number of items bought by local customers from foreign 
--suppliers in 1997 (l shipdate).
select n1.n_name as country, (case
                                when n1.n_nationkey == s.s_nationkey then l.l_quantity
                                else - l.l_quantity
                                end)
                                as econmic_exchange
from lineitem l
join orders o on o.o_orderkey = l.l_orderkey
join customer c on c.c_custkey = o.o_custkey
join nation n1 on n1.n_nationkey = c.c_nationkey

join supplier s on s.s_suppkey = l.l_suppkey
join nation n2 on n2.n_nationkey = s.s_nationkey
where l.l_shipdate like '1997%' 
group by n1.n_name;
