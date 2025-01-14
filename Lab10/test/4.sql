.headers on

drop trigger if exists t4_add;
drop trigger if exists t4_del;

create trigger t4_add
after insert on lineitem
for each row
begin
    update orders
    set o_orderpriority = '2-HIGH'
    where o_orderkey = new.l_orderkey;
end;

create trigger t4_del
after delete on lineitem
for each ROW
BEGIN  
    update orders
    set o_orderpriority = '2-HIGH'
    where o_orderkey = old.l_orderkey;
end;
delete from lineitem
where l_orderkey in (select o_orderkey from orders where strftime('%Y-%m', o_orderdate) = '1995-12');

select count(*) as orders_cnt
from orders
where o_orderpriority = '2-HIGH' and ((strftime('%Y-%m', o_orderdate) like '1995-09') or (strftime('%Y-%m', o_orderdate) like '1995-10') or (strftime('%Y-%m', o_orderdate) like '1995-11') or (strftime('%Y-%m', o_orderdate) like '1995-12'));