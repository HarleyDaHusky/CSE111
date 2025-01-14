.headers on
--Find the nation(s) having customers that spend the largest amount of money 
--(o totalprice).
select n.n_name as country
from customer c
join nation n on c.c_nationkey = n.n_nationkey
join orders o on c.c_custkey = o.o_custkey
group by n.n_name
having sum(o.o_totalprice) = (select max(nationSpending)
                                from (select sum(o2.o_totalprice) as nationSpending
                                    from customer c2
                                    join nation n2 on c2.c_nationkey = n2.n_nationkey
                                    join orders o2 on o2.o_custkey = c2.c_custkey
                                    group by n2.n_name));