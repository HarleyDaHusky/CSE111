-- 1.sql
-- (no new indexes)

-- 2.sql
create index if not exists customer_idx_c_mktsegment on customer(c_mktsegment);

-- 3.sql
create index if not exists customer_idx_c_name on customer(c_name);

--4.sql
create index if not exists supplier_idx_s_acctbal on supplier(s_acctbal); 

--5.sql
create index if not exists lineitem_idx_l_reciptdate_l_returnflag on lineitem(l_receiptdate, l_returnflag);

--6.sql
create index if not exists supplier_idx_s_nationkey on supplier(s_nationkey);
create index if not exists nation_idx_n_name on nation(n_name);

--7.sql
create index if not exists orders_idx_o_custkey_o_orderdate on orders(o_custkey, o_orderdate);
create index if not exists customer_idx_c_nationkey_c_custkey on customer(c_nationkey, c_custkey);
create index if not exists nation_idx_n_regionkey_n_nationkey on nation(n_regionkey, n_nationkey);
create index if not exists region_idx_r_name on region(r_name);

--8.sql
create index if not exists nation_idx_n_nationkey_n_name on nation(n_nationkey, n_name);
create index if not exists customer_idx_c_custkey on customer(c_custkey);
create index if not exists orders_idx_o_orderdate on orders(o_orderdate);

--9.sql
create index if not exists lineitem_idx_l_orderkey on lineitem(l_orderkey);
create index if not exists orders_idx_o_custkey_o_orderkey on orders(o_custkey, o_orderkey);
create index if not exists customer_idx_c_name_c_custkey on customer(c_name, c_custkey);

--10.sql
create index if not exists supplier_idx_s_nationkey_s_acctbal on supplier(s_nationkey, s_acctbal);
create index if not exists region_idx_r_name_r_regionkey on region(r_name, r_regionkey);

--11.sql
create index if not exists orders_idx_o_orderpriority_o_orderdate on orders(o_orderpriority, o_orderdate);

--12.sql
create index if not exists supplier_idx_s_suppkey on supplier(s_suppkey); 
create index if not exists lineitem_idx_l_orderkey_l_suppkey on lineitem(l_orderkey, l_suppkey);
create index if not exists orders_idx_o_orderpriority_o_orderkey on orders(o_orderpriority, o_orderkey);

--13.sql
create index if not exists supplier_idx_s_suppkey_s_name on supplier(s_suppkey, s_name);
create index if not exists lineitem_idx_l_discount on lineitem(l_discount);

--14.sql
create index if not exists region_idx_r_regionkey_r_name on region(r_regionkey, r_name);
create index if not exists orders_idx_o_orderstatus on orders(o_orderstatus);

--15.sql
-- (no new indexes)