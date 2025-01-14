.headers on

drop trigger if exists t1;

create trigger t1
after insert on orders
for each row
BEGIN
    update orders
    set o_orderdate = '2023-12-01'
    where o_orderkey = new.o_orderkey;
end;

insert into orders (o_orderkey, o_custkey, o_orderstatus, o_totalprice, o_orderdate, o_orderpriority, o_clerk, o_shippriority, o_comment)
select o_orderkey, o_custkey, o_orderstatus, o_totalprice, o_orderdate, o_orderpriority, o_clerk, o_shippriority, o_comment
from orders
where strftime('%Y-%m', o_orderdate) = '1995-12';

select count(*) as orders_cnt
from orders
where strftime('%Y', o_orderdate) = '2023';