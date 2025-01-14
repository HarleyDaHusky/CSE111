.headers on
--The market share for a given nation within a given region is defined as the 
--fraction of the revenue from the line items ordered by customers in the given 
--region that are supplied by suppliers from the given nation. 
--The revenue of a line item is defined as l_extendedprice*(1-l_discount). 
--Determine the market share of Germany in ASIA in 1995 (l_shipdate)

--Germany's revenue / Total Asia Revenue

select distinct g.revenue/a.revenue as GERMANY_in_ASIA_in_1995
from (select sum(l_extendedprice*(1-l_discount)) as revenue
    from lineitem l1
    join orders o1 on l1.l_orderkey = o1.o_orderkey
    join customer c on c.c_custkey = o1.o_custkey
    join nation n1 on n1.n_nationkey = c.c_nationkey
    join supplier s on l1.l_suppkey = s.s_suppkey
    join nation n2 on n2.n_nationkey = s.s_nationkey
    join region r on n1.n_regionkey = r.r_regionkey
    where l1.l_shipdate like '1995%' and r.r_name = 'ASIA' and n2.n_name='GERMANY') /*as*/ g,
    
    (select sum(l_extendedprice*(1-l_discount)) as revenue
    from lineitem l2
    join supplier s on l2.l_suppkey = s.s_suppkey
    join nation n2 on n2.n_nationkey = s.s_nationkey
    join region r on r.r_regionkey = n2.n_regionkey
    where r.r_name = 'ASIA' and l2.l_shipdate like '1995%') /*as*/ a

