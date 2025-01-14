.headers on
--For every order priority, count the number of line items ordered in 1998 and 
--received (l receiptdate) earlier than the commit date (l commitdate).
select o.o_orderpriority as priority, count(o.o_orderkey) as item_cnt
from lineitem l 
join orders o on o.o_orderkey = l.l_orderkey
where o.o_orderdate like '1998%' and l_receiptdate < l_commitdate
group by o.o_orderpriority;