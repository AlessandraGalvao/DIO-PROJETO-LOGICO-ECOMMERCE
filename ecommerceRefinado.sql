
-- *********************************************************** 
 -- DIO Projeto Lógico de Banco de Dados E-commerce Refinado
-- *********************************************************** 

use ecommercerefinado;
show tables;
select* from clients;
Alter table clients
     DROP column   Cpf;
Alter table clients     
	 DROP column   Fname;
     
     Alter table clients     
	 DROP column  Birth_date;
     
     Alter table clients     
	 ADD column  ( senha varchar(10) not null,
				  email  varchar (20),
                  telefone varchar (15)
	  );
    
     desc clients;
     
     create table Pessoa_Fisica(
	IdPessoaFisica int auto_increment ,
    IdCClient int,
    Fname varchar(10) not null,
    Mint char (3),
    Lname varchar (20) not null,
    Cpf char(11) not null,
	Birth_date date,
    constraint unique_cpf_client unique (Cpf),
    primary key (IdPessoaFisica,IdCClient),
	constraint fk_Cliente_PessoaFisica foreign key (IdCClient) references clients(IdClient)
);

drop table Pessoa_Fisica;

  create table Pessoa_Juridica(
	IdPessoaJuridica int auto_increment,
    IdCCliente int,
    nameSocial varchar(150) not null,
    CNPJ char(15) not null,
	constraint unique_CNPJ_client unique (CNPJ),
    primary key (IdPessoaJuridica,IdCCliente),
	constraint fk_Cliente_PessoaJuridica foreign key (IdCCliente) references clients(IdClient)
);

  create table shipping(
	IdShipping int auto_increment ,
    IdCClient int,
    IdSOrder int,
    deliveruValue float,
    primary key (IdShipping, IdCClient, IdSOrder),
	constraint fk_Cliente_shipping foreign key (IdCClient) references clients(IdClient),
    constraint fk_order_shipping foreign key (IdSOrder) references orders(IdOrder)
);


drop table shipping;

  create table delivery(
	IdDelivery int auto_increment ,
    IdDShipping int,
    IdDOrder  int,
    deliveruValue float,
    primary key (IdDelivery,IdDShipping),
	constraint fk_delivery_shipping foreign key ( IdDShipping) references shipping(IdShipping),
    constraint fk_delivery_order foreign key ( IdDOrder) references orders(IdOrder)
);



Alter table product    
	 ADD column  (valor float not null);
				  
  alter table product MODIFY Pname varchar(80);
 alter table product MODIFY category enum ('Eletrônico', 'Vestimenta', 'Brinquedos', 'Alimentos','Moveis', 'Livros');
 
 alter table payments
		MODIFY column  typePayment enum('Cartão','Dois Cartões', 'Dinheiro', 'Boleto');
 
   create table pagamentoCartao(
	IdCartao int auto_increment,
    IdPpayments int,
    numbe  char(16) not null,
    validityMonth varchar(10) not null,
    validityYear char(4) not null,
    NameCart varchar (30),
    credit boolean,
    debit  boolean,
	Primary key (IdCartao,IdPpayments),
	constraint fk_Cartao_Pagamento foreign key (IdPpayments) references payments(IdPayments)
);
 
  create table pagamentoBoleto(
	IdBoleto int auto_increment,
    IdPpayments int,
    barcode varchar (30),
    dueDate date,
	Primary key (IdBoleto,IdPpayments),
	constraint fk_Boleto_Pagamento foreign key (IdPpayments) references payments(IdPayments)
);


-- *********************************************************** 
 --  Antes das Alterações:
-- DIO Projeto Lógico de Banco de Dados E-commerce
-- *********************************************************** 

-- drop database ecommerce;
create database ecommerce_refinado;

use ecommerce_refinado;

-- criar tabelas cliente

create table clients(
	IdClient int auto_increment  primary key,
    Fname varchar(10),
    Mint char (3),
    Lname varchar (20),
    Cpf char(11) not null,
    Adress varchar(255),
    Birth_date date,
    constraint unique_cpf_client unique (Cpf)
);
alter table clients auto_increment=1;

desc clients;

-- criar tabela produto

create table product(
	IdProduct int auto_increment primary key,
    Pname varchar(10),
    classification_kids bool default false,
    category enum ('Eletrônico', 'Vestimenta', 'Alimentos','Moveis', 'Livros'),
    avaliacao float default 0,
    size varchar(10)
 );
 alter table product auto_increment=1;
 
    
create table payments(
	IdClient int,
    IdPayment int,
    typePayment enum('Cartão','Dois Cartões'),
    limitAvailable float,
    primary key(IdClient, IdPayment)
);


create table orders(
	IdOrder int auto_increment primary key,
    IdOrderClient int,
    orderStatus enum('Cancelado','Confirmado','Em Processamento','Em Andamento','Enviado','Entregue') default 'Em Processamento',
    orderDescription varchar(255),
    sendValue float default 10,
    IdPayment boolean default false,
    paymentCash bool default false,
    constraint fk_ordersClient foreign key (IdOrderClient) references clients(IdClient),
   constraint fk_Payments foreign key (IdPayment) references payments(IdPayment)
);

alter table orders auto_increment=1;
desc orders;

create table productStorage(
	IdProductStorage int auto_increment primary key,
    storageLocation varchar(255),
    quantity int default 0
);

alter table productStorage auto_increment=1;

create table supplier(
	IdSupplier int auto_increment primary key,
    socialName varchar (255) not null,
    CNPJ char (14) not null,
    contact char (11) not null,
    constraint unique_supplier unique (CNPJ)
);
alter table supplier auto_increment=1;

desc supplier;

-- criar tabela vendedor

create table seller(
	IdSeller int auto_increment primary key,
    socialName varchar (255) not null,
	CNPJ char (15),
    CPF char (11),
    location varchar(255),
    contact char (11) not null,
    fantasyName varchar (255),
    constraint unique_cpf_seller unique (CPF),
	constraint unique_cnpj_seller unique (CNPJ)
);
alter table seller auto_increment=1;

create table productSeller(
	IdPSeller int,
    IdPProduct int,
	prodquantity int default 1,
    primary key (IdPSeller, IdPProduct),
    constraint fk_product_seller foreign key (IdPSeller) references seller(IdSeller),
    constraint fk_product_product foreign key (IdPProduct) references product(IdProduct)
);

desc productSeller;

create table productOrder(
	IdPOrder int,
    IdPProduct int,
    poQuantity int default 1,
    poStatus enum('Disponível','Sem Estoque') default 'Disponível',
    primary key (IdPOrder,IdPProduct),
    constraint fk_product_prodOrder foreign key  (IdPProduct) references product(IdProduct),
    constraint fk_product_order foreign key (IdPOrder) references orders(IdOrder)
);
desc productOrder;
-- drop table productOrder;

create table storageLocation(
	IdLProduct int,
    IdLStorage int,
    location varchar(255) not null,
    primary key (IdLProduct, IdLStorage),
    constraint fk_storage_loction_product foreign key (IdLProduct) references product(IdProduct),
    constraint fk_storage_loction_storage foreign key (IdLStorage) references productStorage(IdProductStorage)
);

create table productSupplier(
	IdPSSupplier int,
    IdPSProduct int,
    psQuantity int default 1,
    primary key (IdPSSupplier, IdPSProduct ),
    constraint fk_product_supplier_supplier foreign key  (IdPSSupplier) references supplier(IdSupplier),
    constraint fk_product_supplier_product foreign key (IdPSProduct) references product(IdProduct)
);
show tables;
