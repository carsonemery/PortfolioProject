use CarsonEmeryNorthwind


-- Query1
select orderid, requireddate
from Orders
where RequiredDate between '20080701' and '20081001'

-- Query2
select *
from Employees
where LastName like '[b-k]%'

-- Query3
select HomePhone, FirstName, LastName
from Employees
where firstname like '_[an]%'

-- Query4
select datename(weekday, OrderDate), count(*)
from Orders
group by datename(weekday, OrderDate)

-- Query5
select count(*)
from Employees
where HireDate between '19940101' and '19940201'

-- Query6
select sum(Freight) as total_freight, ShipVia
from Orders
where OrderDate between '20080101' and '20090101'
group by ShipVia

-- Query 7
select orderid, datediff(day, ShippedDate, RequiredDate) as num_of_days
from Orders
where ShippedDate is not null
order by num_of_days DESC

-- Query8
select count(*) as no_fax
from Customers
where fax is null

-- Query9
select CustomerID, isnull(fax,'N/A') as new_fax_column
from Customers

-- Query 10
select orderid,ShippedDate, RequiredDate,
case when ShippedDate < RequiredDate then 'ontime'
case when shippeddate > requireddate then 'late'
else 'not shipped'
end as shippingstatus 
from Orders

