--�dev sorular�n� ��zmeye ba�lamadan �nce Northwnd db nizi restore edin ve a�a��daki kodlar� �al��t�r�n

--INSERT INTO Categories (CategoryName) VALUES ('Urunsuz')
--INSERT INTO Products (ProductName) VALUES ('Kategorisiz')
--INSERT INTO Employees (LastName,FirstName) VALUES ('�al��kan','S�leyman')

--Soru 1. �r�n� olmayan kategorilerin isimlerini listeleyin
select CategoryName from Categories left join Products on Categories.CategoryID=Products.CategoryID where  ProductName is null


--Soru 2. Herhangi bir kategoriye dahil olmayan �r�nlerin isimlerini listeyin
select ProductName from Products left join Categories on Products.CategoryID=Categories.CategoryID where CategoryName is null

--A�a��daki 2 sorgu sonu�lar�nda CategoryName ve ProductName s�tunlar� yanyana g�sterilecek �ekilde listelenmesi beklenmektedir.

--Soru 3. T�m kategorileri ve t�m �r�nleri listeleyin
select CategoryName,ProductName from Categories full join Products on Categories.CategoryID=Products.CategoryID

--Soru 4. �r�n� olmayan kategorileri ve kategorisi olmayan �r�nleri listeleyin

select CategoryName,ProductName from Categories full join Products on Categories.CategoryID=Products.CategoryID 
where Products.CategoryID is null

--Soru 5. Sat�� yapan �al��anlar�n ka� adet �r�n sat��� yapt�klar�n�, �al��an�n ad ve soyad� aras�nda bir bo�luk olacak �ekilde 'Personel' isimli tek bir kolonda, satt��� �r�n adedini 'Sat�� Adedi' ba�l�kl� kolonda olacak �ekilde listeleyin
select LastName+' '+ FirstName 'Personel',[Order Details].Quantity 'Sat�� Adedi'
from Employees join Orders  
on Employees.EmployeeID=[Orders].EmployeeID   
join  [Order Details] 
on Orders.OrderID=[Order Details].OrderID  

--Soru 6. Sat�� yapan �al��anlar�n ne kadarl�k sat�� yapt�klar�n� (toplam sat�� tutar�), �al��an�n ad ve soyad� aras�nda bir bo�luk olacak �ekilde 'Personel' isimli tek bir kolonda, yapt��� toplam sat�� tutar� 'Toplam Sat��' ba�l�kl� kolonda olacak �ekilde listeleyin
select LastName+' '+ FirstName 'Personel',sum([Order Details].Quantity) 'Toplam Sat��'
from Employees inner join Orders  
on Employees.EmployeeID=[Orders].EmployeeID   
inner join  [Order Details] 
on Orders.OrderID=[Order Details].OrderID  
group by LastName,FirstName
--Soru 7. T�m �al��anlar�n ne kadarl�k sat�� yapt�klar�n� (toplam sat�� tutar�), �al��an�n ad ve soyad� aras�nda bir bo�luk olacak �ekilde 'Personel' isimli tek bir kolonda, yapt��� toplam sat�� tutar� 'Toplam Sat��' ba�l�kl� kolonda olacak �ekilde listeleyin
select LastName+' '+ FirstName 'Personel',sum([Order Details].Quantity) 'Toplam Sat�� Tutar�'
from Employees full join Orders  
on Employees.EmployeeID=[Orders].EmployeeID   
full join  [Order Details] 
on Orders.OrderID=[Order Details].OrderID  
group by LastName,FirstName
--Soru 8. Hangi kategoriden toplam ne kadarl�k sipari� verilmi� listeleyin
select  CategoryName 'Kategori Ad�', sum(od.UnitPrice*od.Quantity)'Toplam Sipari� Tutar�'
from Orders o
inner join [Order Details] od
on o.OrderID=od.OrderID
inner join Products p
on p.ProductID=od.ProductID
inner join Categories cat
on cat.CategoryID= p.CategoryID
group by CategoryName
--Soru 9. Hangi m��teri toplam ne kadarl�k sipari� vermi�
select c.CompanyName 'M��teri Ad�',sum(od.UnitPrice*od.Quantity) 'Toplam Sipari� Tutar� '
from Customers as c left join Orders o on c.CustomerID=o.CustomerID
inner join [Order Details] as od
on o.OrderID=od.OrderID
group by CompanyName

--Soru 10. Hangi m��teri hangi kategorilerden sipari� vermi�
select distinct  CompanyName 'M��teri Ad�',CategoryName 'Kategori Ad�'
from Customers c
inner join Orders o
on c.CustomerID=o.CustomerID
inner join [Order Details] od
on o.OrderID=od.OrderID
inner join Products p
on p.ProductID=od.ProductID
inner join Categories cat
on cat.CategoryID= p.CategoryID

--Soru 11. En �ok sat�lan �r�n�n tedarik�isi hangi firma
select top 1 CompanyName 'Tedarik�i Ad�',sum(Quantity) 'Toplam Sipari� Adedi'
from [Order Details] od
inner join Orders o
on od.OrderID=o.OrderID
left join Products p
on od.ProductID=p.ProductID
inner join Suppliers sp
on p.SupplierID=sp.SupplierID
group by CompanyName
order by sum(Quantity) desc

--Soru 12. Hangi �r�nden ka� adet sat�lm��
select ProductName '�r�n Ad�',sum(Quantity) 'Toplam Sat�lan �r�n Adedi'
from [Order Details] od
inner join Products p
on od.ProductID=p.ProductID
group by ProductName

--Soru 13. En �ok sat�lan �r�n hangisi
select top 1 ProductName '�r�n Ad�',sum(Quantity)'Toplam Sat�lan �r�n Adedi'
from [Order Details] od
inner join Products p
on od.ProductID=p.ProductID
group by ProductName
order by sum(Quantity) desc

--Soru 14. Stokta 20 birim alt�nda kalan �r�nlerin isimleri ve tedarik�i firma ad�n� listeleyin 
select  ProductName '�r�n Ad�',CompanyName 'Tedarik�i Ad�'
from [Order Details] od
inner join Orders o
on od.OrderID=o.OrderID
left join Products p
on od.ProductID=p.ProductID
inner join Suppliers sp
on p.SupplierID=sp.SupplierID
where UnitsInStock<20
group by ProductName,CompanyName
-- Iphone ve kategorisi olmayan �r�n ilave etmi�tik. Onlara teradir�i girmedi�imiz i�in bu tabloda gelmez
-- burda 26 row Product tablosundan productname i stok adedi 20 den k���k olanlar� �a��rd���m�zda 28 row geliyor

