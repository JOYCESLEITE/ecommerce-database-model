-- Criação do banco de dados para o cenario de E-COMMERCE --
-- drop database ecommerce;
create database ecommerce;
use ecommerce;

-- criar tabela cliente --
create table cliente (
   idClient int auto_increment primary key,
   Fname varchar(10),
   Minit char(3),
   Lname varchar(20),
   CPF char(11) not null,
   Address varchar(255),
   Type enum('PF', 'PJ') not null,
   constraint unique_client unique (CPF)
   );
ALTER TABLE cliente ADD COLUMN Type enum('PF', 'PJ') not null;
DESC cliente;
-- desc cliente;   
   -- Criar tabela de produtos
create table product(
   idProduct int auto_increment primary key,
   Pname varchar(10),
   classification_kids bool default false,
   category enum('Eletronico', 'Vestimenta', 'Brinquedos', 'Alimentos', 'Moveis') not null,
   avaliaçao float default 0,
   size varchar(10)
   
);   

-- para ser continuado no desafio: termine de implementar a tabela e crie a conexão com as tabelas necessárias
-- além disso, reflita essa modificação no diagrama de esuema relacional 
-- criar constraints relacionadas ao pagamento

CREATE TABLE payments (
    id_payment INT AUTO_INCREMENT PRIMARY KEY,
    idClient INT,
    typePayment ENUM('Boleto', 'Cartão', 'Dois cartões'),
    limitAvailable FLOAT,
    FOREIGN KEY (idClient) REFERENCES cliente(idClient) ON DELETE CASCADE
);
DESC payments;
DROP TABLE payments;

-- criar tabela de pedidos
create table orders(
   idOrder int auto_increment primary key,
   idOrderClient int,
   orderStatus enum('Cancelado', 'Confirmado', 'Em processamento') default 'Em processamento',
   orderDescription varchar(255),
   sendValue float default 10,
   paymentCash bool default false,
   constraint fk_ordes_client foreign key (idOrderClient) references cliente(idClient)
        on update cascade
        
);
-- desc orders;
-- criar tabela estoque
create table ProductStorage(
   idProdStorage int auto_increment primary key,
   storageLocation varchar(255),
   quantity int default 0
   
 );
 
-- criat tabela fornecedor
create table Supplier(
   idSupplier int auto_increment primary key,
   SocialName varchar(255) not null,
   CNPJ char(15) not null,
   contact char(11) not null,
   constraint unique_supplier unique (CNPJ)
);
-- desc supplier;
-- criar tabela vendedor 
create table Seller(
   idSeller int auto_increment primary key,
   SocialName varchar(255) not null,
   AbstName varchar (255),
   CNPJ char(15),
   CPF char(9),
   location varchar(255),
   contact char(11) not null,
   constraint unique_cnpj_seller unique (CNPJ),
   constraint unique_cpf_seller unique (CPF)
);

create table productSeller(
   idPSeller int,
   idPproduct int, 
   prodQuantity int default 1,
   primary key (idPseller, idPproduct),
   constraint fk_product_seller foreign key (idPseller) references seller(idSeller),
   constraint fk_product_product foreign key (idPproduct) references product(idProduct)
   
   );
-- desc productSeller;
   
create table productOrder(
   idPOproduct int, 
   idPOorder int,
   poQuantity int default 1,
   poStatus enum('Disponivel', 'Sem estoque') default 'Disponivel',
   primary key (idPOproduct, idPOorder),
   constraint fk_productorder_seller foreign key (idPOproduct) references product(idProduct),
   constraint fk_productorder_product foreign key (idPOorder) references orders(idOrder)
   
);

create table storageLocation(
   idLproduct int,
   idLstorage int,
   location varchar(255) not null,
   primary key (idLproduct, idLstorage),
   constraint fk_storage_location_product foreign key (idLproduct) references product(idProduct),
   constraint fk_storage_location_storage foreign key (idLstorage) references productStorage(idProdStorage)
   );
   
create table productSupplier(
idPsSupplier int,
idPsProduct int,
quantity int not null,
primary key (idPsSupplier, idPsProduct),
constraint fk_product_supplier_supplier foreign key (idPsSupplier) references supplier(idSupplier),
constraint fk_product_supplier_product foreign key (idPsProduct) references product(idProduct)

);
-- desc productSupplier;  