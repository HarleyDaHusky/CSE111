.headers on
SELECT COUNT(*) as item_cnt
FROM lineitem
WHERE l_shipdate < l_commitdate;
