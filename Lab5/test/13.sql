.headers on
--For any two regions, ﬁnd the gross discounted revenue (l extendedprice*(1-l discount)) 
--derived from line items in which parts are shipped from a supplier in the ﬁrst region 
--to a customer in the second region in 1996 and 1997. List the supplier region, the customer region, 
--the year (l shipdate), and the revenue from shipments that took place in that year.
select r1.r_name as supp_region, r2.r_name as cust_region, substring(l.l_shipdate, 1, 4) as year, sum(l_extendedprice*(1-l.l_discount)) as revenue
FROM lineitem l 
join supplier s on s.s_suppkey = l.l_suppkey
join nation n1 on n1.n_nationkey = s.s_nationkey
join region r1 on r1.r_regionkey = n1.n_regionkey

join orders o on o.o_orderkey = l.l_orderkey
join customer c on c.c_custkey = o.o_custkey
join nation n2 on n2.n_nationkey = c.c_nationkey
join region r2 on r2.r_regionkey = n2.n_regionkey

where l.l_shipdate like '1996%' or l.l_shipdate like '1997%'

GROUP BY r1.r_name, r2.r_name, substring(l.l_shipdate, 1, 4)

order by r1.r_name, r2.r_name, year;