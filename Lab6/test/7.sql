.headers on
--Find the total quantity (l_quantity) of line items shipped per month (l_shipdate) in 1997. 
--Hint: Check function strftime to extract the month/year from a date.
select strftime('%m', l.l_shipdate) as month, SUM(l.l_quantity) as tot_month
from lineitem l
where strftime('%Y', l.l_shipdate) = '1997'
group by strftime('%m', l.l_shipdate)
order by month;

