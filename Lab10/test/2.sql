.headers on

drop trigger if exists t2;

create trigger t2
after update of c_acctbal on customer
for each ROW
when (old.c_acctbal > 0 and new.c_acctbal <0)
begin
    update customer
    set c_comment = 'Negative balance!!!'
    where c_custkey = new.c_custkey;
end;

update customer
set c_acctbal = -100
where c_nationkey = (select n_nationkey from nation where n_name = 'AFRICA');

select count(*) as customer_cnt
from customer
where c_acctbal < 0 and c_nationkey = (select n_nationkey from nation where n_name = 'EGYPT');