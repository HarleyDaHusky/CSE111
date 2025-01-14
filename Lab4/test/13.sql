.headers on
--List the minimum total price of an order between any two regions, i.e., 
--the suppliers are from one region 
--and the customers are from the other region.
SELECT r1.r_name as supp_region, r2.r_name as cust_region, min(o.o_totalprice) as min_price
FROM lineitem l 
join supplier s on s.s_suppkey = l.l_suppkey
join nation n1 on n1.n_nationkey = s.s_nationkey
join region r1 on r1.r_regionkey = n1.n_regionkey

join orders o on o.o_orderkey = l.l_orderkey
join customer c on c.c_custkey = o.o_custkey
join nation n2 on n2.n_nationkey = c.c_nationkey
join region r2 on r2.r_regionkey = n2.n_regionkey

GROUP BY r1.r_name, r2.r_name;

-- WHERE n1.n_name <> n2.n_name
-- Group by n1.n_name, n2.n_name;