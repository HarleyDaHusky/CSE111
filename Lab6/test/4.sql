.headers on
--Find the nation(s) with the least developed industry, i.e., 
--selling items totaling the smallest amount of money (l extendedprice) in 
--1994 (l shipdate).
select n.n_name as country
from nation n
join supplier s on n.n_nationkey = s.s_nationkey
join lineitem l on s.s_suppkey = l.l_suppkey
where l.l_shipdate like '1994%'
group by n.n_name
having sum(l.l_extendedprice) = (
    select min(sales)
    from(
        select sum(l2.l_extendedprice) as sales
        from nation n2
        join supplier s2 on n2.n_nationkey = s2.s_nationkey
        join lineitem l2 on s2.s_suppkey = l2.l_suppkey
        where l2.l_shipdate like '1994%'
        group by n2.n_name    
    ) as sales_summary
);
