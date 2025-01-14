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


def createTable(_conn):
    print("++++++++++++++++++++++++++++++++++")
    print("Create table")
    try:
        sql = '''CREATE TABLE if not exists warehouse(
            wId decimal(9,0) not null,
            wName char(100) not null,
            wCap decimal(6,0) not null,
            sId decimal(9,0) not null,
            nId decimal(2,0) not null
        );'''
        _conn.execute(sql)
        print('Table created')
    except Error as e:
        print(e)
    print("++++++++++++++++++++++++++++++++++")



def dropTable(_conn):
    print("++++++++++++++++++++++++++++++++++")
    print("Drop tables")
    try:
        sql = '''DROP TABLE IF EXISTS warehouse;'''
        _conn.execute(sql)
        print('Table dropped')
    except Error as e:
        print(e)
    print("++++++++++++++++++++++++++++++++++")


def populateTable(_conn):
    print("++++++++++++++++++++++++++++++++++")
    print("Populate table")
    try:

        cursor = _conn.cursor()

        cursor.execute("select s_suppkey from supplier")
        supplier = cursor.fetchall()

        wKey = 1
        wName = ""

        for s_suppkey in supplier:
            getquery = '''
            select s.s_name, n.n_name, n.n_nationkey, count(l.l_orderkey) as lineitem_cnt, sum(p.p_size)*3 as total_size
            from supplier s
            join lineitem l ON s.s_suppkey = l.l_suppkey
            join orders o ON o.o_orderkey = l.l_orderkey
            join customer c ON c.c_custkey = o.o_custkey
            join nation n ON n.n_nationkey = c.c_nationkey
            join part p ON p.p_partkey = l.l_partkey 
            where s.s_suppkey = ?
            group by s.s_name, n.n_name
            order by s.s_name, COUNT(l.l_orderkey) DESC, n.n_name ASC
            '''
            cursor.execute(getquery, s_suppkey)
            results = cursor.fetchall()
            wCap = max(row[4] for row in results)
            insert_values = []
            for i, row in enumerate(results[:3]):
                s_name, n_name, n_nationkey, lineitem_cnt, total_size = row
                wName = f"{s_name}___{n_name}"
                insert_values.append((wKey + i, wName, wCap, int(s_suppkey[0]), n_nationkey))
            query = '''
            INSERT INTO warehouse (wId, wName, wCap, sId, nId) 
            VALUES (?, ?, ?, ?, ?);'''
            cursor.executemany(query, insert_values)
            wKey += len(insert_values)
        _conn.commit()
    except Error as e:
        print(e)
    print("++++++++++++++++++++++++++++++++++")




def Q1(_conn):
    print("++++++++++++++++++++++++++++++++++")
    print("Q1")
    try:
        output = open('output/1.out', 'w')
        header = "{:>10} {:<40} {:>10} {:>10} {:>10}"
        output.write((header.format("wId", "wName", "wCap", "sId", "nId")) + '\n')
        cursor = _conn.cursor()
        query = '''
        select * from warehouse w
        order by w.wID;'''
        cursor.execute(query)
        rows = cursor.fetchall()
        if rows:
            for row in rows:
                wId, wName, wCap, sId, nId = row
                line = f"{wId:>10} {wName:<40} {wCap:>10} {sId:>10} {nId:>10}"
                # print(line)
                output.write(line + '\n')
            print("Q1 written to 1.out")
        else:
            print("Q1 failed")
        output.close()
    except Error as e:
        print(e)

    print("++++++++++++++++++++++++++++++++++")


def Q2(_conn):
    print("++++++++++++++++++++++++++++++++++")
    print("Q2")

    try:
        with open('output/2.out', 'w') as output:
            header = "{:<40} {:>10} {:>10}"
            output.write(header.format("nation", "numW", "totCap") + '\n')
            
            cursor = _conn.cursor()
            cursor.execute('''
                SELECT n.n_name AS nation, COUNT(w.wId) AS numW, SUM(w.wCap) AS totCap
                FROM warehouse w
                JOIN nation n ON w.nId = n.n_nationkey
                GROUP BY n.n_name
                ORDER BY numW DESC, totCap DESC, nation
            ''')
            rows = cursor.fetchall()

            if rows:
                for row in rows:
                    nation, numW, totCap = row
                    line = f"{nation:<40} {numW:>10} {totCap:>10}"
                    # print(line)
                    output.write(line + '\n')

                print("Q2 written to 2.out")
            else:
                print("Q2 failed")

    except Error as e:
        print(e)

    print("++++++++++++++++++++++++++++++++++")



def Q3(_conn):
    print("++++++++++++++++++++++++++++++++++")
    print("Q3")

    try:
        with open("input/3.in", "r") as input_file:
            target_nation = input_file.readline().strip()

        with open('output/3.out', 'w') as output:
            header = "{:<20} {:<20} {:<40}"
            output.write(header.format("supplier", "nation", "warehouse") + '\n')
        
            cursor = _conn.cursor()
            cursor.execute('''
                SELECT s.s_name AS supplier, n.n_name AS supplier_nation, w.wName AS warehouse
                FROM warehouse w
                JOIN supplier s ON w.sId = s.s_suppkey
                JOIN nation n ON s.s_nationkey = n.n_nationkey
                JOIN nation wn ON w.nId = wn.n_nationkey
                WHERE wn.n_name = ?
                ORDER BY s.s_name
            ''', (target_nation,))
            rows = cursor.fetchall()
            
            for row in rows:
                supplier, supplier_nation, warehouse = row
                line = f"{supplier:<20} {supplier_nation:<20} {warehouse:<40}"
                # print(line)
                output.write(line + '\n')

        print("Q3 written to 3.out")

    except Error as e:
        print(e)

    print("++++++++++++++++++++++++++++++++++")



def Q4(_conn):
    print("++++++++++++++++++++++++++++++++++")
    print("Q4")

    try:
        with open("input/4.in", "r") as input_file:
            region = input_file.readline().strip()
            cap = int(input_file.readline().strip())

        cursor = _conn.cursor()

        query = '''
        SELECT w.wName, w.wCap
        FROM warehouse w
        JOIN nation n ON w.nId = n.n_nationkey
        JOIN region r ON n.n_regionkey = r.r_regionkey
        WHERE r.r_name = ? AND w.wCap > ?
        ORDER BY w.wCap DESC
        '''
        cursor.execute(query, (region, cap))

        results = cursor.fetchall()

        with open('output/4.out', 'w') as output_file:
            header = "{:<40} {:>10}".format("warehouse", "capacity")
            output_file.write(header + '\n')

            for wName, wCap in results:
                output_file.write("{:<40} {:>10}\n".format(wName, wCap))

    except Error as e:
        print("Database error:", e)
    print("++++++++++++++++++++++++++++++++++")


def Q5(_conn):
    print("++++++++++++++++++++++++++++++++++")
    print("Q5")

    try:
        with open("input/5.in", "r") as input_file:
            nation = input_file.readline().strip()
        
        with open('output/5.out', 'w') as output_file:
            header = "{:<20} {:>20}".format("region", "capacity")
            output_file.write(header + '\n')

            query = '''
                SELECT r.r_name AS region, COALESCE(SUM(w.wCap), 0) AS total_capacity
                FROM region r
                LEFT JOIN nation n ON r.r_regionkey = n.n_regionkey
                LEFT JOIN warehouse w ON n.n_nationkey = w.nId AND w.sId IN (
                    SELECT s_suppkey FROM supplier WHERE s_nationkey = (SELECT n_nationkey FROM nation WHERE n_name = ?)
                )
                GROUP BY r.r_name
                ORDER BY r.r_name ASC;
            '''
            cursor = _conn.cursor()
            cursor.execute(query, (nation,))

            for row in cursor.fetchall():
                region, total_capacity = row
                output_file.write(f"{region:<20} {total_capacity:>20}\n")
            
            cursor.close()
        print("Q5 written to 5.out")
    except Error as e:
        print(f"Error: {e}")
    print("++++++++++++++++++++++++++++++++++")

def main():
    database = r"tpch.sqlite"

    # create a database connection
    conn = openConnection(database)
    with conn:
        dropTable(conn)
        createTable(conn)
        populateTable(conn)

        Q1(conn)
        Q2(conn)
        Q3(conn)
        Q4(conn)
        Q5(conn)

    closeConnection(conn, database)


if __name__ == '__main__':
    main()
