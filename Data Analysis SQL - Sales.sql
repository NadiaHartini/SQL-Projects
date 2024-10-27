select 
	company, 
	to_char(cast(order_date as timestamp), 'DD') as tanggal, 
	count(order_id) as total_rejected
from orders o 
where status = 'REJECTED'
group by 1,2;

select 
	o.customer_id, 
	o.order_id, 
	od.product_name,
	od.quantity
from orders o 
join order_detail od 
on o.order_id = od.order_id 
order by 1, 2;

select company,
	count(distinct case when status = 'SENT' then order_id end ) as total_order_sent,
	count(distinct case when status = 'REJECTED' then order_id end) as total_order_rejected
from orders o
group by 1;

--CTE Nomor 3
with total_order as(
	select 
		company,
		count(case when status = 'SENT' then order_id end ) as sent,
		count(case when status = 'REJECTED' then order_id end) as reject
	from orders o
	group by 1
)
select 
	company, 
	case when sent > 2 and reject > 0 then 'Good'
	when sent > 2 and reject = 0 then 'Superb'
	else 'Normal'
	end category,
	sent+reject as total_orders
from total_order;

--Subquery
select 
	company, 
	case when sent > 2 and reject > 0 then 'Good'
	when sent > 2 and reject = 0 then 'Superb'
	else 'Normal'
	end category,
	sent+reject as total_orders
from (select 
		company,
		count(case when status = 'SENT' then order_id end ) as sent,
		count(case when status = 'REJECTED' then order_id end) as reject
	from orders o
	group by 1
	) as total_order


