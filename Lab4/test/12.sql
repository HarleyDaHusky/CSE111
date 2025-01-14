.headers on
--What is the maximum account balance for the suppliers in every region? 
--Print only those regions for which the maximum balance is larger than 9000.
SELECT r.r_name as region, MAX(s.s_acctbal) as max_bal
FROM region r
JOIN nation n on n.n_regionkey = r.r_regionkey
JOIN supplier s on s.s_nationkey = n.n_nationkey

GROUP BY r.r_name

HAVING MAX(s.s_acctbal) > 9000;