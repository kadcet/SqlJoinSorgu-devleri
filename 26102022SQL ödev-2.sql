--1. Çalýþanlarýmýz kaç farklý þehirde çalýþýyorlar
select distinct City 'Çalýþan Personel Þehir'
from Employees where City is not null


--2. Adresleri içinde 'House' kelimesi geçen çalýþanlar
select * from Employees
where Address like'%House%'
--3. Herhangi bir bölge (Region) verisi olmayan çalýþanlar
select * from Employees
where Region is null
--4. Çalýþanlarý adlarýný A-Z soyadlarýný Z-A olaracak þekilde tek sorguda listeleyelim
select FirstName 'Ad',LastName 'Soyad'
from Employees
order by FirstName asc,LastName desc
--5. Ürünleri; ürün adý, Fiyatý, KDV tutarý, KDV Dahil fiyatý þeklinde listeleyelim (KDV %18 olacak) 
select ProductName 'Ürün Adý',UnitPrice 'Birim Fiyat',UnitPrice*18/100 'Kdv Tutarý',(UnitPrice*18/100)+UnitPrice 'Kdv Dahil Tutar'
from Products
--6. En pahalý 5 ürünü listeyelim
select top 5 ProductName 'Ürün Adý',UnitPrice'Birim Fiyat'
from Products
order by UnitPrice desc
--7. Stok adedi 20-50 arasýndaki ürünlerin listesi
select ProductName 'Ürün Adý',UnitsInStock 'Stok Adedi'
from Products where UnitsInStock between 20 and 50

--8. Hangi ülkede kaç müþterimiz var
select distinct Country 'Müþterilerimizin Olduðu Ülkeler'
from Customers
--9. Her kategoride kaç kalem ürün var (kategori adý, o kategorideki toplam ürün kalemi sayýsý)
select CategoryName,count(ProductId) 'Toplam  Ürün Adedi'
from Products p
inner join Categories c
on p.CategoryID=c.CategoryID
group by CategoryName
--10. Her kategoride kaç adet ürün var (kategori adý, o kategorideki toplam ürün adedi (stock) sayýsý)
select CategoryName,sum(UnitsInStock) 'Toplam Stok Adedi'
from Products p
inner join Categories c
on p.CategoryID=c.CategoryID
group by CategoryName

--11. 50 den fazla sipariþ alan personellerin ad, soyad, sipariþ adedi þeklinde listeleyelim
select FirstName 'Çalýþan Adý',LastName'Çalýþan Soyadý',count(OrderID) 'Sipariþ Adedi'
from Employees e
inner join Orders o
on e.EmployeeID=o.EmployeeID
group by FirstName,LastName
having count(OrderID)>50
--12. Satýþ yapýlmayan ürün adlarýnýn listesi
select distinct ProductName
from Products p
left join [Order Details] od
on p.ProductID=od.ProductID
where od.ProductID is null

--13. Ortalamanýn altýnda bir fiyata sahip olan ürünlerin adý ve fiyatý


select ProductName'Ürün Adý',od.UnitPrice'Ortalama Fiyat'
from Products p
inner join [Order Details] od
on p.ProductID=od.ProductID
where od.UnitPrice<(select avg(UnitPrice) from [Order Details])


--14. Hiç sipariþ vermeyen müþteriler
select CompanyName,o.CustomerID
from Customers c
full join Orders o
on c.CustomerID=o.CustomerID
where o.CustomerID is null

--15. Hangi tedarikçi hangi ürünü saðlýyor
select CompanyName,ProductName
from Products p
inner join Suppliers s
on p.SupplierID=s.SupplierID
