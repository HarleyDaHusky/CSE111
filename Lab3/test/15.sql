.headers on
--1,264,568.92
--Find the total account balance 
--of all the customers from AMERICA in the FURNITURE market segment.
SELECT SUM(c.c_acctbal) as tot_acct_bal
FROM customer c
JOIN nation n on n.n_nationkey = c.c_nationkey
JOIN region r on r.r_regionkey = n.n_regionkey
WHERE r.r_name = 'AMERICA' and c.c_mktsegment = 'FURNITURE';