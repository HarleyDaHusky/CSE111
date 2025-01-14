.headers on
--Find the supplier with the largest account balance in every region. 
--Print the region name, the supplier name, and the account balance.
SELECT r.r_name as region, s.s_name as supplier, MAX(s.s_acctbal) as acct_bal
from supplier s 
JOIN nation n on n.n_nationkey = s.s_nationkey
JOIN region r on r.r_regionkey = n.n_regionkey

GROUP BY r.r_name;
