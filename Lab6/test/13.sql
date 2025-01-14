.headers on
--Find the nation(s) with the largest number of customers.
select n.n_name as country
from customer c
join nation n on c.c_nationkey = n.n_nationkey
group by n.n_name
having count(distinct c.c_custkey) = (select max(custCount)
                                        from (select count(distinct c2.c_custkey) as custCount
                                            from customer c2
                                            join nation n2 on c2.c_nationkey = n2.n_nationkey
                                            group by n2.n_name));