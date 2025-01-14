.headers ON
drop trigger if exists t3;
create trigger t3
after update of c_acctbal on customer
for each ROW
when (new.c_acctbal >= 0 and old.c_acctbal <0)
BEGIN
    update customer
    set c_comment = 'Positive balance'
    where c_Custkey = new.c_custkey;
end;

update customer
set c_acctbal = 100
where c_nationkey = 16;

select count(*) as customer_cnt
from customer, nation
where c_acctbal < 0 and c_nationkey = n_nationkey and n_regionkey = 0;