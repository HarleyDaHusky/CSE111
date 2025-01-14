.headers on

drop trigger if exists t5;

create trigger t5
after delete on part
for each ROW
BEGIN  
    delete from partsupp where ps_partkey = old.p_partkey;
    delete from lineitem where l_partkey = old.p_partkey;
end;

delete from part
where p_partkey in (
    select ps_partkey
    from partsupp
    where ps_suppkey in (
        select s_suppkey
        from supplier
        where s_nationkey = 14 or s_nationkey = 15)
);

select n_name as country, count(*) as parts_count
from supplier
join partsupp on s_suppkey = ps_suppkey
join nation on s_nationkey = n_nationkey
where n_regionkey = 0
group by n_name
order by count(distinct ps_partkey);