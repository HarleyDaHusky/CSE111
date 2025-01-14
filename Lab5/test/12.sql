.headers on
--Count the number of orders made in 1995 in which at least one line item was 
--received (l_receiptdate) by a customer later than 
--its commit date (l_commitdate). List the count of such orders for every priority.
select o.o_orderpriority as priority, count(distinct o.o_orderkey) as order_cnt
from lineitem l
join orders o on l.l_orderkey = o.o_orderkey
where l.l_receiptdate > l.l_commitdate and o.o_orderdate like '1995%'
group by o.o_orderpriority;