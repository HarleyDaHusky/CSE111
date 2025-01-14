.headers on
--Find the name of the suppliers from ASIA who have more than
--5,000 on account balance. Print the supplier name and their account balance.
SELECT s.s_name as s_name, s_acctbal as s_acctbal
FROM supplier s 
JOIN nation n on n.n_nationkey = s.s_nationkey 
JOIN region r on r.r_regionkey = n.n_regionkey
WHERE r.r_name = 'ASIA' and s_acctbal > 5000
GROUP BY (s.s_name)