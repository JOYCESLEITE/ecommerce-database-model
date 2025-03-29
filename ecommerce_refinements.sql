-- inserção de dados e queries
use ecommerce;

show tables;
-- idClient, Fname, Minit, Lname, CPF, Address
insert into Cliente (Fname, Minit, Lname, CPF, Address)
     values('Maria','M','Silva', 123456789, 'rua silva de prata 29, Carangola - Cidade das Flores'),
           ('Mateus','O','Pimentel', 21987654321, 'rua alameda 289, Centro- Cidade das Flores'),
           ('Ricardo','F','Silva', 2145678913, 'rua alameda vinha 1009, Centro- Cidade das Flores'),
           ('Julia','S','França', 21789123456, 'rua laranjeiras 861, Centro- Cidade das Flores'),
           ('Roberta','G','Assis', 2198745631, 'avenida koller 19, Centro- Cidade das Flores'),
           ('Isabela','M','Cruz', 21654789123, 'rua alameda das flores 28, Centro- Cidade das Flores');
 ALTER TABLE cliente MODIFY COLUMN Address VARCHAR(255);
 SELECT c.idClient, c.Fname, c.Lname, COUNT(o.idOrder) AS TotalOrders
FROM Cliente c
LEFT JOIN Orders o ON c.idClient = o.idOrderClient
GROUP BY c.idClient, c.Fname, c.Lname;
         

-- idProduct, Pname, classification_kids boolean, category('Eletrônico','Vestimenta','Brinquedos','Alimentos','Moveis'), avaliação, size
insert into product (Pname, classification_kids, category, avaliacao, size) values
               ('Fone de ouvido',false,'Eletronico','4',null),
               ('Barbie Elsa',true,'Brinquedos','3',null),
               ('Body Carters',true,'Vestimenta','5',null),
               ('Microfone Vedo - Youtuber',false,'Eletronico','4',null),
               ('Sofá retrátil',false,'Móveis','3','3x57x80'),
               ('Farinha de arroz',false,'Alimentos','2',null),
               ('Fire Stick Amazon',false,'Eletronico','3',null);
ALTER TABLE product ADD COLUMN avaliacao FLOAT DEFAULT 0;	
ALTER TABLE product MODIFY COLUMN Pname VARCHAR(50);
SELECT LENGTH('Fone de ouvido');
			
select * from cliente; 
select * from product; 
-- idOrder, idOrderClient, orderStatus, orderDescription, sendValue, paymentCash

insert into orders (idOrderClient, orderStatus, orderDescription, sendValue, paymentCash) values
          (1, default,'compra via aplicativo', null,1),
          (2, default,'compra via aplicativo',50,0),
          (3,'confirmado',null, null,1),
          (4, null,'compra via web site',150,0);
INSERT INTO orders (idOrderClient, orderStatus, orderDescription, sendValue, paymentCash)
VALUES
   (1, 'Confirmado', 'Ordem adicional para ID 5', 100, 1),
   (2, 'Confirmado', 'Ordem adicional para ID 6', 150, 0);
          
-- idPOproduct, idPOorder, poQuantity, poStatus
select * from orders;
insert into productOrder (idPOproduct, idPOorder, poQuantity, poStatus) values
             (1,5,2,null), 
             (2,5,1,null),
             (3,6,1,null);
 SELECT * FROM productOrder;
DELETE FROM productOrder WHERE idPOproduct = 1 AND idPOorder = 5;
UPDATE productOrder
SET poQuantity = 2, poStatus = NULL
WHERE idPOproduct = 1 AND idPOorder = 5;
SELECT * FROM productOrder;
            
-- storageLocation,quantity  
insert into productStorage (storageLocation,quantity) values
		('Rio de Janeiro',1000),
        ('Rio de Janeiro',500),
        ('São Paulo',10),
        ('São Paulo',100),
        ('São Paulo',10),
        ('Brasilia',60);
        
-- idLproduct, idLstorage, location  
insert into storageLocation (idLproduct,idLstorage, location) values
		(1,2,'RJ'),   
        (2,6,'GO');
        
create table Delivery (
    idDelivery INT AUTO_INCREMENT PRIMARY KEY,
    idOrder INT,
    TrackingCode VARCHAR(50),
    Status ENUM('Em trânsito', 'Entregue', 'Cancelado') NOT NULL,
    FOREIGN KEY (idOrder) REFERENCES Orders(idOrder)
);

-- idSupplier, SocialName, CNPJ, contact
insert into supplier (socialName,CNPJ, contact) values
		   ('Almeida e filhos',123456789123456,'21985474'),
           ('Eletronicos Silva',854519649143457,'21985484'),
           ('Eletronicos Valma',934519649143495,'21975474');
 DESC supplier;
          
select * from supplier;
-- idPsSupplier, idPsProduct, quatity
insert into productSupplier (idPsSupplier, idPsProduct, quantity) values
      (1,1,500),
      (1,2,400),
      (2,4,633),
      (3,3,5),
      (2,5,10);

-- idSeller, SocialName, AbstName, CNPJ, CPF, location, contact
insert into seller (SocialName, AbstName, CNPJ, CPF, location, contact) values
            ('Tech eletronics', null, 123456789456321, null, 'Rio de Janeiro', 219946287),
            ('Boutique Durgas', null, null, 123456783,'Rio de Janeiro', 219567895),
            ('Kids World', null, 456789123654485, null, 'São Paulo', 1198657484);

select * from seller;    
-- idSeller, idPproduct, prodQuantity
insert into productSeller (idPSeller, idPproduct, prodQuantity) values
                 (1,6,80),
                 (2,7,10);

select * from productSeller;  
               
select count(*) from cliente;                 
select * from cliente c, orders o where c.idClient = idOrderClient;

select Fname,Lname, idOrder, orderStatus from clients c, orders o where c.idClient = idOrderClient;
select concat(Fname,' ',Lname) as Client, idOrder as Request, orderStatus as Order_Status from clients c, orders o where c.idClient = idOrderClient;                 
      
insert into orders (idOrderClient, orderStatus, orderDescription, sendValue, paymentCash) values
                         (2, default, 'compra via aplicativo',null,1);
                         
select ps.quantity as StockQuantity, p.Pname, s.SocialName
from Product p
inner join ProductSupplier ps on p.idProduct = ps.idPsProduct
inner join Supplier s on ps.idPsSupplier = s.idSupplier;
LIMIT 0, 1000;


select count(*) from cliente c, orders o 
		 where c.idClient = idOrderClient;
 
 select * from orders;
 -- Recuperar quanto pedidos foram realizados pelo clientes
SELECT c.idClient, c.Fname, c.Lname, o.idOrder, o.orderStatus, p.idPOorder, COUNT(*) as number_of_orders
FROM cliente c 
INNER JOIN orders o ON c.idClient = o.idOrderClient
INNER JOIN productOrder p ON p.idPOorder = o.idOrder
GROUP BY c.idClient, c.Fname, c.Lname, o.idOrder, o.orderStatus, p.idPOorder
LIMIT 0, 1000;



          