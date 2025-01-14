.headers on
--Find the number of suppliers that provided a discount of 10% for one of their line items.  
--For every such supplier, print its name and the number of such discounted line items.
SELECT s.s_name as s_name, count(l.l_orderkey) as discounted_items
FROM supplier s 
JOIN lineitem l on l.l_suppkey = s.s_suppkey
WHERE l.l_discount = 0.1
GROUP BY s.s_name;
