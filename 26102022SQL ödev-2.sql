--1. �al��anlar�m�z ka� farkl� �ehirde �al���yorlar
select distinct City '�al��an Personel �ehir'
from Employees where City is not null


--2. Adresleri i�inde 'House' kelimesi ge�en �al��anlar
select * from Employees
where Address like'%House%'
--3. Herhangi bir b�lge (Region) verisi olmayan �al��anlar
select * from Employees
where Region is null
--4. �al��anlar� adlar�n� A-Z soyadlar�n� Z-A olaracak �ekilde tek sorguda listeleyelim
select FirstName 'Ad',LastName 'Soyad'
from Employees
order by FirstName asc,LastName desc
--5. �r�nleri; �r�n ad�, Fiyat�, KDV tutar�, KDV Dahil fiyat� �eklinde listeleyelim (KDV %18 olacak) 
select ProductName '�r�n Ad�',UnitPrice 'Birim Fiyat',UnitPrice*18/100 'Kdv Tutar�',(UnitPrice*18/100)+UnitPrice 'Kdv Dahil Tutar'
from Products
--6. En pahal� 5 �r�n� listeyelim
select top 5 ProductName '�r�n Ad�',UnitPrice'Birim Fiyat'
from Products
order by UnitPrice desc
--7. Stok adedi 20-50 aras�ndaki �r�nlerin listesi
select ProductName '�r�n Ad�',UnitsInStock 'Stok Adedi'
from Products where UnitsInStock between 20 and 50

--8. Hangi �lkede ka� m��terimiz var
select distinct Country 'M��terilerimizin Oldu�u �lkeler'
from Customers
--9. Her kategoride ka� kalem �r�n var (kategori ad�, o kategorideki toplam �r�n kalemi say�s�)
select CategoryName,count(ProductId) 'Toplam  �r�n Adedi'
from Products p
inner join Categories c
on p.CategoryID=c.CategoryID
group by CategoryName
--10. Her kategoride ka� adet �r�n var (kategori ad�, o kategorideki toplam �r�n adedi (stock) say�s�)
select CategoryName,sum(UnitsInStock) 'Toplam Stok Adedi'
from Products p
inner join Categories c
on p.CategoryID=c.CategoryID
group by CategoryName

--11. 50 den fazla sipari� alan personellerin ad, soyad, sipari� adedi �eklinde listeleyelim
select FirstName '�al��an Ad�',LastName'�al��an Soyad�',count(OrderID) 'Sipari� Adedi'
from Employees e
inner join Orders o
on e.EmployeeID=o.EmployeeID
group by FirstName,LastName
having count(OrderID)>50
--12. Sat�� yap�lmayan �r�n adlar�n�n listesi
select distinct ProductName
from Products p
left join [Order Details] od
on p.ProductID=od.ProductID
where od.ProductID is null

--13. Ortalaman�n alt�nda bir fiyata sahip olan �r�nlerin ad� ve fiyat�


select ProductName'�r�n Ad�',od.UnitPrice'Ortalama Fiyat'
from Products p
inner join [Order Details] od
on p.ProductID=od.ProductID
where od.UnitPrice<(select avg(UnitPrice) from [Order Details])


--14. Hi� sipari� vermeyen m��teriler
select CompanyName,o.CustomerID
from Customers c
full join Orders o
on c.CustomerID=o.CustomerID
where o.CustomerID is null

--15. Hangi tedarik�i hangi �r�n� sa�l�yor
select CompanyName,ProductName
from Products p
inner join Suppliers s
on p.SupplierID=s.SupplierID
