-- JOIN TÜRLERÝ
-- left join : soldaki tablodan tüm satýrlar, saðdaki tablodan sadece eþleþen satýrlar

select CategoryName,ProductName from Categories left join Products on Categories.CategoryID=Products.CategoryID
-- ýphone8 e categori vermeden product a ekledik. bu sorguda gelmmedi ýphone 8

-- right join: saðdaki tablodan tüm satýrlar, soldaki tablodan sadece eþleþen satýrlar
select CategoryName,ProductName from Categories right join Products on Categories.CategoryID=Products.CategoryID
--select * from Categories right join Products on Categories.CategoryID=Products.CategoryID
-- bilgisayar diye category ekledik. Ürünlerden categorisi bilgisayar olan ürün yok.  bu surguda bilgisayar gelmeyecek

-- inner join : sadece eþleþen (kesiþimini) kayýtlarý getirir
-- sadece join yazsakta olur
select CategoryName,ProductName from Categories inner join Products on Categories.CategoryID=Products.CategoryID

-- NE KATEGORÝSÝZ ÜRÜN, NE ÜRÜNÜ OLMAYAN CATEGORÝ GÖRMEM- hepsinin karþýlýðý var.
select CategoryName,ProductName from Categories full join Products on Categories.CategoryID=Products.CategoryID
where Products.CategoryID is null

-- ürünü olmayan kategoriler
select CategoryName,ProductName
from Categories left join Products
on Categories.CategoryID=Products.CategoryID
where Products.CategoryID is null

-- kategorisi olmayan ürünler
select CategoryName,ProductName
from Categories right join Products
on Categories.CategoryID=Products.CategoryID
where Products.CategoryID is null

-- tüm müþterilerimin þirket isimlerini ve her müþterinin verdiði toplam sipariþ bedelini listele

select CompanyName 'Þirket Ýsmi',sum(UnitPrice*Quantity) 'Toplam Sipariþ Bedeli'
from customers c left join Orders o
on c.CustomerID=o.CustomerID
inner join [Order Details] od
on o.OrderID=od.OrderID
group by CompanyName





