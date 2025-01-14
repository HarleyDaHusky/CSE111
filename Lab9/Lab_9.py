import sqlite3
from sqlite3 import Error


def openConnection(_dbFile):
    print("++++++++++++++++++++++++++++++++++")
    print("Open database: ", _dbFile)

    conn = None
    try:
        conn = sqlite3.connect(_dbFile)
        print("success")
    except Error as e:
        print(e)

    print("++++++++++++++++++++++++++++++++++")

    return conn

def closeConnection(_conn, _dbFile):
    print("++++++++++++++++++++++++++++++++++")
    print("Close database: ", _dbFile)

    try:
        _conn.close()
        print("success")
    except Error as e:
        print(e)

    print("++++++++++++++++++++++++++++++++++")


def create_View1(_conn):
    print("++++++++++++++++++++++++++++++++++")
    print("Create V1")

    try:
        cursor = _conn.cursor()
        cursor.execute("""
            create view if not exists V1 as
                select c.c_custkey, c.c_name, c.c_address, c.c_phone, c.c_acctbal, c.c_mktsegment, c.c_comment, n.n_name as c_nation, r.r_name as c_region
                from customer c
                join nation n on c.c_nationkey = n.n_nationkey
                join region r on r.r_regionkey = n.n_regionkey
        """)
        # cursor.execute("""drop view V1""")

        _conn.commit()
        print("View V1 created successfully.")
    except Error as e:
        print("Error creating View V1:", e)

    print("++++++++++++++++++++++++++++++++++")



def Q1(_conn):
    print("++++++++++++++++++++++++++++++++++")
    print("Q1")

    try:
        cursor = _conn.cursor()
        
        cursor.execute("""
            select c_nation as country, count(*) as cnt
            from v1, orders o
            where c_custkey = o_custkey and c_region = 'MIDDLE EAST'
            group by c_nation
        """)
        
        rows = cursor.fetchall()

        output = open('output/1.out', 'w')

        header = "{}|{}"
        output.write((header.format("country", "cnt")) + '\n')

        for row in rows:
            output.write(f"{row[0]}|{row[1]}\n")

        output.close()
        print("Q1 output written successfully.")
    except Error as e:
        print("Error executing Q1:", e)

    print("++++++++++++++++++++++++++++++++++")



def create_View2(_conn):
    print("++++++++++++++++++++++++++++++++++")
    print("Create V2")

    try:
        cursor = _conn.cursor()
        cursor.execute("""           
            create view if not exists V2 as
            select o_orderkey, o_custkey, o_orderstatus, o_totalprice, substr(o_orderdate, 1, 4) as orderyear, o_orderpriority, o_clerk, o_shippriority, o_comment
            from orders o;
        """)
        # cursor.execute("""drop view V2""")

        _conn.commit()
        print("View V2 created successfully.")
    except Error as e:
        print("Error creating View V2:", e) 

    print("++++++++++++++++++++++++++++++++++")


def Q2(_conn):
    print("++++++++++++++++++++++++++++++++++")
    print("Q2")

    try:
        cursor = _conn.cursor()
        cursor.execute("""
            select c_name as customer, count(*) as cnt
            from V1, V2
            where c_custkey = o_custkey and V1.c_nation = 'MOZAMBIQUE' and V2.orderyear = '1997'
            group by c_name;
        """)
        
        rows = cursor.fetchall()

        output = open('output/2.out', 'w')

        header = "{}|{}"
        output.write((header.format("country", "cnt")) + '\n')

        for row in rows:
            output.write(f"{row[0]}|{row[1]}\n")

        output.close()
        print("Q2 output written successfully.")
    except Error as e:
        print("Error executing Q2:", e)

    print("++++++++++++++++++++++++++++++++++")


def Q3(_conn):
    print("++++++++++++++++++++++++++++++++++")
    print("Q3")

    try:
        cursor = _conn.cursor()
        cursor.execute("""
            select c_name as customer, round(sum(o.o_totalprice), 2) as total_price
            from V1, orders o
            where c_custkey = o.o_custkey and c_nation = 'GERMANY' and o.o_orderdate like '1992%'
            group by V1.c_name;
        """)

        rows = cursor.fetchall()

        output = open('output/3.out', 'w')

        header = "{}|{}"
        output.write((header.format("customer", "total_price")) + '\n')

        for row in rows:
            output.write(f"{row[0]}|{row[1]}\n")

        output.close()
        print ("Q3 output written successfully.")
    except Error as e:
        print(e)

    print("++++++++++++++++++++++++++++++++++")


def create_View4(_conn):
    print("++++++++++++++++++++++++++++++++++")
    print("Create V4")
    try:
        cursor = _conn.cursor()
        cursor.execute("""           
            create view if not exists V4 as
            select s_suppkey, s_name, s_address, s_phone, s_acctbal, s_comment, n.n_name as s_nation, r.r_name as s_region
            from supplier s
            join nation n on n.n_nationkey = s.s_nationkey
            join region r on r.r_regionkey = n.n_regionkey
        """)
        # cursor.execute("""drop view V4""")

        _conn.commit()
        print("View V4 created successfully.")
    except Error as e:
        print("Error creating View V4:", e) 
    print("++++++++++++++++++++++++++++++++++")


def Q4(_conn):
    print("++++++++++++++++++++++++++++++++++")
    print("Q4")

    try:
        cursor = _conn.cursor()
        cursor.execute("""
            select s_name as supplier, count(s_name) as cnt
            from V4, partsupp ps, part p
            where ps.ps_partkey = p.p_partkey and ps.ps_suppkey = V4.s_suppkey and V4.s_nation = 'RUSSIA' and p.p_container like '%CAN%'
            group by V4.s_name;
            
        """)
        rows = cursor.fetchall()

        output = open('output/4.out', 'w')

        header = "{}|{}"
        output.write((header.format("supplier", "cnt")) + '\n')
        for row in rows:
            output.write(f"{row[0]}|{row[1]}\n")
        output.close()
        print("Q4 output written successfully")
    except Error as e:
        print(e)

    print("++++++++++++++++++++++++++++++++++")


def Q5(_conn):
    print("++++++++++++++++++++++++++++++++++")
    print("Q5")

    try:
        cursor = _conn.cursor()
        cursor.execute("""
            select s_nation as country, count(s_nation) as cnt
            from V4
            where v4.s_nation = 'JAPAN' or v4.s_nation = 'CHINA'
            group by v4.s_nation
            
        """)
        rows = cursor.fetchall()

        output = open('output/5.out', 'w')

        header = "{}|{}"
        output.write((header.format("supplier", "cnt")) + '\n')
        for row in rows:
            output.write(f"{row[0]}|{row[1]}\n")
        output.close()
        print("Q5 output written successfully")
    except Error as e:
        print(e)

    print("++++++++++++++++++++++++++++++++++")


def Q6(_conn):
    print("++++++++++++++++++++++++++++++++++")
    print("Q6")

    try:
        cursor = _conn.cursor()
        cursor.execute("""
            select V4.s_name as supplier, o.o_orderpriority as priority, count(distinct p.p_partkey) as cnt
            from V4
            join lineitem l on v4.s_suppkey = l.l_suppkey
            join part p on p.p_partkey = l.l_partkey
            join orders o on o.o_orderkey = l.l_orderkey
            where v4.s_nation = 'ARGENTINA'
            group by v4.s_name, o.o_orderpriority
        """)
        rows = cursor.fetchall()

        output = open('output/6.out', 'w')

        header = "{}|{}|{}"
        output.write((header.format("supplier", "priority", "parts")) + '\n')
        for row in rows:
            output.write(f"{row[0]}|{row[1]}|{row[2]}\n")
        output.close()
        print("Q6 output written successfully")
    except Error as e:
        print(e)

    print("++++++++++++++++++++++++++++++++++")


def Q7(_conn):
    print("++++++++++++++++++++++++++++++++++")
    print("Q7")

    try:
        cursor = _conn.cursor()
        cursor.execute("""
            select v1.c_nation as country, v2.o_orderstatus as status, count(v2.o_orderstatus) as orders
            from v1, v2
            where v1.c_custkey = v2.o_custkey and v1.c_region = 'ASIA'
            group by v1.c_nation, v2.o_orderstatus                       
        """)
        rows = cursor.fetchall()

        output = open('output/7.out', 'w')

        header = "{}|{}|{}"
        output.write((header.format("country", "status", "orders")) + '\n')
        for row in rows:
            output.write(f"{row[0]}|{row[1]}|{row[2]}\n")
        print("Q7 output written successfully")
        output.close()
    except Error as e:
        print(e)

    print("++++++++++++++++++++++++++++++++++")


def Q8(_conn):
    print("++++++++++++++++++++++++++++++++++")
    print("Q8")

    try:
        cursor = _conn.cursor()
        cursor.execute("""
            select count(distinct v2.o_clerk) as clerks
            from V2, V4, lineitem l
            where v2.o_orderkey = l.l_orderkey and l.l_suppkey = v4.s_suppkey and  v4.s_nation = 'IRAQ'
        """)
        rows = cursor.fetchall()
        output = open('output/8.out', 'w')

        header = "{}"
        output.write((header.format("clerks")) + '\n')
        for row in rows:
            output.write(f"{row[0]}\n")
        output.close()
        print("Q8 output written successfully")
    except Error as e:
        print(e)

    print("++++++++++++++++++++++++++++++++++")


def Q9(_conn):
    print("++++++++++++++++++++++++++++++++++")
    print("Q9")

    try:
        cursor = _conn.cursor()
        cursor.execute("""
            select v4.s_nation as country, count(distinct v2.o_orderkey) as cnt
            from v4, v2, lineitem l
            where l.l_suppkey = v4.s_suppkey and v2.o_orderkey = l.l_orderkey and v2.o_orderstatus = 'F' and v2.orderyear = '1994' and v4.s_region = 'AMERICA'
            group by v4.s_nation
            having cnt > 250;
        """)
        rows = cursor.fetchall()
        output = open('output/9.out', 'w')

        header = "{}|{}"
        output.write((header.format("country", "cnt")) + '\n')
        for row in rows:
            output.write(f"{row[0]}|{row[1]}\n")
        output.close()
        print("Q9 output written successfully")
    except Error as e:
        print(e)

    print("++++++++++++++++++++++++++++++++++")


def create_View10(_conn):
    print("++++++++++++++++++++++++++++++++++")
    print("Create V10")
    try:
        cursor = _conn.cursor()
        cursor.execute("""
            create view if not exists V10 as
                select p_type, min(l.l_discount) AS min_discount, max(l.l_discount) AS max_discount
                from lineitem l
                join part p on p.p_partkey = l.l_partkey
                group by p.p_type
        """) 
        # cursor.execute("""drop view V10""")
        print("View V10 created successfully.")
    except Error as e:
        print(e)    
    print("++++++++++++++++++++++++++++++++++")


def Q10(_conn):
    print("++++++++++++++++++++++++++++++++++")
    print("Q10")

    try:
        cursor = _conn.cursor()
        cursor.execute("""
            select v10.p_type as part_type, v10.min_discount as min_disc, v10.max_discount as max_disc
            from v10
            where v10.p_type like '%MEDIUM%' or v10.p_type like '%TIN%'
            group by v10.p_type
        """)
        rows = cursor.fetchall()
        output = open('output/10.out', 'w')

        header = "{}|{}|{}"
        output.write((header.format("part_type", "min_disc", "max_disc")) + '\n')
        for row in rows:
            output.write(f"{row[0]}|{row[1]}|{row[2]}\n")
        output.close()
    except Error as e:
        print(e)

    print("++++++++++++++++++++++++++++++++++")


def create_View111(_conn):
    print("++++++++++++++++++++++++++++++++++")
    print("Create V111")
    try:
        cursor = _conn.cursor()
        cursor.execute("""
            create view if not exists V111 as
                select c.c_custkey, c.c_name, c.c_nationkey, c.c_acctbal
                from customer c
                where c.c_acctbal<0
        """) 
        # cursor.execute("""drop view V111""")
        print("View V111 created successfully.")
    except Error as e:
        print(e)
    print("++++++++++++++++++++++++++++++++++")


def create_View112(_conn):
    print("++++++++++++++++++++++++++++++++++")
    print("Create V112")
    try:
        cursor = _conn.cursor()
        cursor.execute("""
            create view if not exists V112 as
                select s.s_suppkey, s.s_name, s.s_nationkey, s.s_acctbal
                from supplier s
                where s.s_acctbal>0
        """) 
        # cursor.execute("""drop view V112""")
        print("View V112 created successfully.")
    except Error as e:
        print(e)
    print("++++++++++++++++++++++++++++++++++")


def Q11(_conn):
    print("++++++++++++++++++++++++++++++++++")
    print("Q11")

    try:
        cursor = _conn.cursor()
        cursor.execute("""
            select count(distinct l.l_orderkey) as order_cnt
            from v111, v112
            join lineitem l on l.l_suppkey = v112.s_suppkey
            join orders o on o.o_orderkey = l.l_orderkey
            where o.o_custkey = v111.c_custkey
        """)
        rows = cursor.fetchall()
        output = open('output/11.out', 'w')

        header = "{}"
        output.write((header.format("order_cnt")) + '\n')
        for row in rows:
            output.write(f"{row[0]}\n")

        output.close()
    except Error as e:
        print(e)

    print("++++++++++++++++++++++++++++++++++")


def Q12(_conn):
    print("++++++++++++++++++++++++++++++++++")
    print("Q12")

    try:
        cursor = _conn.cursor()
        cursor.execute("""
            select v4.s_region as region, max(v4.s_acctbal) as max_bal
            from v4
            group by v4.s_region
            having max(v4.s_acctbal) > 9000;
        """)
        rows = cursor.fetchall()        
        output = open('output/12.out', 'w')

        header = "{}|{}"
        output.write((header.format("region", "max_bal")) + '\n')
        for row in rows:
            output.write(f"{row[0]}|{row[1]}\n")

        output.close()
    except Error as e:
        print(e)

    print("++++++++++++++++++++++++++++++++++")


def Q13(_conn):
    print("++++++++++++++++++++++++++++++++++")
    print("Q13")

    try:
        cursor = _conn.cursor()
        cursor.execute("""
            select v4.s_region as supp_region, v1.c_region as cust_region, min(o.o_totalprice) as min_price
            from v1, v4, lineitem l, orders o
            where v1.c_custkey = o.o_custkey and l.l_orderkey = o.o_orderkey and v4.s_suppkey = l.l_suppkey
            group by v1.c_region, v4.s_region
        """)
        rows = cursor.fetchall()        
        output = open('output/13.out', 'w')

        header = "{}|{}|{}"
        output.write((header.format("supp_region", "cust_region", "min_price")) + '\n')
        for row in rows:
            output.write(f"{row[0]}|{row[1]}|{row[2]}\n")

        output.close()
    except Error as e:
        print(e)

    print("++++++++++++++++++++++++++++++++++")


def Q14(_conn):
    print("++++++++++++++++++++++++++++++++++")
    print("Q14")

    try:
        cursor = _conn.cursor()
        cursor.execute("""
            select count(*) as items
            from v1, v4, orders o, lineitem l
            where v4.s_suppkey = l.l_suppkey and o.o_orderkey = l.l_orderkey and v1.c_custkey = o.o_custkey and v4.s_region = 'EUROPE' and v1.c_nation = 'INDIA'
        """)
        rows = cursor.fetchall()              
        output = open('output/14.out', 'w')

        header = "{}"
        output.write((header.format("items")) + '\n')
        for row in rows:
            output.write(f"{row[0]}\n")

        output.close()
    except Error as e:
        print(e)

    print("++++++++++++++++++++++++++++++++++")


def Q15(_conn):
    print("++++++++++++++++++++++++++++++++++")
    print("Q15")

    try:
        cursor = _conn.cursor()
        cursor.execute("""
            select v4.s_region, v4.s_name, v4.s_acctbal
            from v4
            where v4.s_acctbal = (
                select max(view4.s_acctbal)
                from v4 view4
                where view4.s_region = v4.s_region)
        """)
        rows = cursor.fetchall()     
        output = open('output/15.out', 'w')

        header = "{}|{}|{}"
        output.write((header.format("region", "supplier", "acct_bal")) + '\n')
        for row in rows:
            output.write(f"{row[0]}|{row[1]}|{row[2]}\n")

        output.close()
    except Error as e:
        print(e)

    print("++++++++++++++++++++++++++++++++++")


def main():
    database = r"tpch.sqlite"

    # create a database connection
    conn = openConnection(database)
    with conn:
        create_View1(conn)
        Q1(conn)

        create_View2(conn)
        Q2(conn)

        Q3(conn)

        create_View4(conn)
        Q4(conn)

        Q5(conn)
        Q6(conn)
        Q7(conn)
        Q8(conn)
        Q9(conn)

        create_View10(conn)
        Q10(conn)

        create_View111(conn)
        create_View112(conn)
        Q11(conn)

        Q12(conn)
        Q13(conn)
        Q14(conn)
        Q15(conn)

    closeConnection(conn, database)


if __name__ == '__main__':
    main()
