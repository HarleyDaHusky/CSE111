.headers on
--Find the number of suppliers from each of JAPAN and CHINA
SELECT n.n_name as country, count(n.n_name) as cnt
FROM nation n 
JOIN supplier s on s.s_nationkey = n.n_nationkey
WHERE n.n_name = 'JAPAN' or n.n_name = 'CHINA'
GROUP BY n.n_name;