--Ödev sorularýný çözmeye baþlamadan önce Northwnd db nizi restore edin ve aþaðýdaki kodlarý çalýþtýrýn

--INSERT INTO Categories (CategoryName) VALUES ('Urunsuz')
--INSERT INTO Products (ProductName) VALUES ('Kategorisiz')
--INSERT INTO Employees (LastName,FirstName) VALUES ('Çalýþkan','Süleyman')

--Soru 1. Ürünü olmayan kategorilerin isimlerini listeleyin
select CategoryName from Categories left join Products on Categories.CategoryID=Products.CategoryID where  ProductName is null


--Soru 2. Herhangi bir kategoriye dahil olmayan ürünlerin isimlerini listeyin
select ProductName from Products left join Categories on Products.CategoryID=Categories.CategoryID where CategoryName is null

--Aþaðýdaki 2 sorgu sonuçlarýnda CategoryName ve ProductName sütunlarý yanyana gösterilecek þekilde listelenmesi beklenmektedir.

--Soru 3. Tüm kategorileri ve tüm ürünleri listeleyin
select CategoryName,ProductName from Categories full join Products on Categories.CategoryID=Products.CategoryID

--Soru 4. Ürünü olmayan kategorileri ve kategorisi olmayan ürünleri listeleyin

select CategoryName,ProductName from Categories full join Products on Categories.CategoryID=Products.CategoryID 
where Products.CategoryID is null

--Soru 5. Satýþ yapan çalýþanlarýn kaç adet ürün satýþý yaptýklarýný, çalýþanýn ad ve soyadý arasýnda bir boþluk olacak þekilde 'Personel' isimli tek bir kolonda, sattýðý ürün adedini 'Satýþ Adedi' baþlýklý kolonda olacak þekilde listeleyin
select LastName+' '+ FirstName 'Personel',[Order Details].Quantity 'Satýþ Adedi'
from Employees join Orders  
on Employees.EmployeeID=[Orders].EmployeeID   
join  [Order Details] 
on Orders.OrderID=[Order Details].OrderID  

--Soru 6. Satýþ yapan çalýþanlarýn ne kadarlýk satýþ yaptýklarýný (toplam satýþ tutarý), çalýþanýn ad ve soyadý arasýnda bir boþluk olacak þekilde 'Personel' isimli tek bir kolonda, yaptýðý toplam satýþ tutarý 'Toplam Satýþ' baþlýklý kolonda olacak þekilde listeleyin
select LastName+' '+ FirstName 'Personel',sum([Order Details].Quantity) 'Toplam Satýþ'
from Employees inner join Orders  
on Employees.EmployeeID=[Orders].EmployeeID   
inner join  [Order Details] 
on Orders.OrderID=[Order Details].OrderID  
group by LastName,FirstName
--Soru 7. Tüm çalýþanlarýn ne kadarlýk satýþ yaptýklarýný (toplam satýþ tutarý), çalýþanýn ad ve soyadý arasýnda bir boþluk olacak þekilde 'Personel' isimli tek bir kolonda, yaptýðý toplam satýþ tutarý 'Toplam Satýþ' baþlýklý kolonda olacak þekilde listeleyin
select LastName+' '+ FirstName 'Personel',sum([Order Details].Quantity) 'Toplam Satýþ Tutarý'
from Employees full join Orders  
on Employees.EmployeeID=[Orders].EmployeeID   
full join  [Order Details] 
on Orders.OrderID=[Order Details].OrderID  
group by LastName,FirstName
--Soru 8. Hangi kategoriden toplam ne kadarlýk sipariþ verilmiþ listeleyin
select  CategoryName 'Kategori Adý', sum(od.UnitPrice*od.Quantity)'Toplam Sipariþ Tutarý'
from Orders o
inner join [Order Details] od
on o.OrderID=od.OrderID
inner join Products p
on p.ProductID=od.ProductID
inner join Categories cat
on cat.CategoryID= p.CategoryID
group by CategoryName
--Soru 9. Hangi müþteri toplam ne kadarlýk sipariþ vermiþ
select c.CompanyName 'Müþteri Adý',sum(od.UnitPrice*od.Quantity) 'Toplam Sipariþ Tutarý '
from Customers as c left join Orders o on c.CustomerID=o.CustomerID
inner join [Order Details] as od
on o.OrderID=od.OrderID
group by CompanyName

--Soru 10. Hangi müþteri hangi kategorilerden sipariþ vermiþ
select distinct  CompanyName 'Müþteri Adý',CategoryName 'Kategori Adý'
from Customers c
inner join Orders o
on c.CustomerID=o.CustomerID
inner join [Order Details] od
on o.OrderID=od.OrderID
inner join Products p
on p.ProductID=od.ProductID
inner join Categories cat
on cat.CategoryID= p.CategoryID

--Soru 11. En çok satýlan ürünün tedarikçisi hangi firma
select top 1 CompanyName 'Tedarikçi Adý',sum(Quantity) 'Toplam Sipariþ Adedi'
from [Order Details] od
inner join Orders o
on od.OrderID=o.OrderID
left join Products p
on od.ProductID=p.ProductID
inner join Suppliers sp
on p.SupplierID=sp.SupplierID
group by CompanyName
order by sum(Quantity) desc

--Soru 12. Hangi üründen kaç adet satýlmýþ
select ProductName 'Ürün Adý',sum(Quantity) 'Toplam Satýlan Ürün Adedi'
from [Order Details] od
inner join Products p
on od.ProductID=p.ProductID
group by ProductName

--Soru 13. En çok satýlan ürün hangisi
select top 1 ProductName 'Ürün Adý',sum(Quantity)'Toplam Satýlan Ürün Adedi'
from [Order Details] od
inner join Products p
on od.ProductID=p.ProductID
group by ProductName
order by sum(Quantity) desc

--Soru 14. Stokta 20 birim altýnda kalan ürünlerin isimleri ve tedarikçi firma adýný listeleyin 
select  ProductName 'Ürün Adý',CompanyName 'Tedarikçi Adý'
from [Order Details] od
inner join Orders o
on od.OrderID=o.OrderID
left join Products p
on od.ProductID=p.ProductID
inner join Suppliers sp
on p.SupplierID=sp.SupplierID
where UnitsInStock<20
group by ProductName,CompanyName
-- Iphone ve kategorisi olmayan ürün ilave etmiþtik. Onlara teradirçi girmediðimiz için bu tabloda gelmez
-- burda 26 row Product tablosundan productname i stok adedi 20 den küçük olanlarý çaðýrdýðýmýzda 28 row geliyor

