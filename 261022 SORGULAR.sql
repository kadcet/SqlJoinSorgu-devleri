-- JOIN T�RLER�
-- left join : soldaki tablodan t�m sat�rlar, sa�daki tablodan sadece e�le�en sat�rlar

select CategoryName,ProductName from Categories left join Products on Categories.CategoryID=Products.CategoryID
-- �phone8 e categori vermeden product a ekledik. bu sorguda gelmmedi �phone 8

-- right join: sa�daki tablodan t�m sat�rlar, soldaki tablodan sadece e�le�en sat�rlar
select CategoryName,ProductName from Categories right join Products on Categories.CategoryID=Products.CategoryID
--select * from Categories right join Products on Categories.CategoryID=Products.CategoryID
-- bilgisayar diye category ekledik. �r�nlerden categorisi bilgisayar olan �r�n yok.  bu surguda bilgisayar gelmeyecek

-- inner join : sadece e�le�en (kesi�imini) kay�tlar� getirir
-- sadece join yazsakta olur
select CategoryName,ProductName from Categories inner join Products on Categories.CategoryID=Products.CategoryID

-- NE KATEGOR�S�Z �R�N, NE �R�N� OLMAYAN CATEGOR� G�RMEM- hepsinin kar��l��� var.
select CategoryName,ProductName from Categories full join Products on Categories.CategoryID=Products.CategoryID
where Products.CategoryID is null

-- �r�n� olmayan kategoriler
select CategoryName,ProductName
from Categories left join Products
on Categories.CategoryID=Products.CategoryID
where Products.CategoryID is null

-- kategorisi olmayan �r�nler
select CategoryName,ProductName
from Categories right join Products
on Categories.CategoryID=Products.CategoryID
where Products.CategoryID is null

-- t�m m��terilerimin �irket isimlerini ve her m��terinin verdi�i toplam sipari� bedelini listele

select CompanyName '�irket �smi',sum(UnitPrice*Quantity) 'Toplam Sipari� Bedeli'
from customers c left join Orders o
on c.CustomerID=o.CustomerID
inner join [Order Details] od
on o.OrderID=od.OrderID
group by CompanyName





