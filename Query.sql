Use ecommercerefinado;
show tables ;
Select * from pessoa_fisica;
INSERT INTO `ecommercerefinado`.`pessoa_fisica` (`IdCClient`, `Fname`, `Mint`, `Lname`, `Cpf`, `Birth_date`) VALUES ('1', 'Jaime ', 'P', 'Silva', '16987325911', '1969/02/03');
INSERT INTO `ecommercerefinado`.`pessoa_fisica` (`IdCClient`, `Fname`, `Mint`, `Lname`, `Cpf`, `Birth_date`) VALUES ('7', 'Paloma', 'K', 'Barros', '96324856321', '2002/03/07');
INSERT INTO `ecommercerefinado`.`pessoa_fisica` (`IdCClient`, `Fname`, `Mint`, `Lname`, `Cpf`, `Birth_date`) VALUES ('3', 'Rodrigo', 'M', 'Silva', '74136985231', '2000/04/08');
INSERT INTO `ecommercerefinado`.`pessoa_fisica` (`IdCClient`, `Fname`, `Mint`, `Lname`, `Cpf`, `Birth_date`) VALUES ('6', 'Miguel', 'C', 'Matos', '23647896321', '1999/02/02');
INSERT INTO `ecommercerefinado`.`pessoa_fisica` (`IdCClient`, `Fname`, `Mint`, `Lname`, `Cpf`, `Birth_date`) VALUES ('5', 'Bento', 'R', 'Valença', '74123658742', '2003/07/09');

Select * from pessoa_juridica;

INSERT INTO `ecommercerefinado`.`pessoa_juridica` (`IdCCliente`, `nameSocial`, `CNPJ`) VALUES ('2', 'Solange Bazar', '123654000189');
INSERT INTO `ecommercerefinado`.`pessoa_juridica` (`IdCCliente`, `nameSocial`, `CNPJ`) VALUES ('4', 'Tem Tudo Ltda', '3698745000189');

INSERT INTO `ecommercerefinado`.`shipping` (`IdCClient`, `IdSOrder`, `deliveruValue`) VALUES ('1', '1', '30');
INSERT INTO `ecommercerefinado`.`shipping` (`IdCClient`, `IdSOrder`, `deliveruValue`) VALUES ('2', '2', '100');

/*======================================================*/
/*Consultando dados do banco ecommerce refinado*/
/*======================================================*/


-- TOTAL DE CLIENTES CADASTRADOS:
SELECT	COUNT(*)	TOTAL_CLIENTES
FROM	clients;

-- NOME COMPLETO EM PESSOA FÍSICA
select concat(Fname,' ',Mint,' ',Lname) as NOME_COMPLETO_PF from pessoa_fisica;

-- TODOS OS PEDIDOS QUE ESTÃO EM ESTADO DE PROCESSAMENTO
desc orders;
select * from orders
where orderStatus = 'Em Processamento';

-- TOTAL DE CLIENTES CADASTRADOS QUE POSSUEM PEDIDO:
SELECT	COUNT(DISTINCT C.idClient)	TOTAL_CLIENTES_COM_PEDIDO
FROM	clients C
		INNER JOIN	orders O
				ON	C.idClient = O.idOrderClient;
   
-- LISTA DE CLIENTES (PESSOA FISICA) COM QUANTIDADE TOTAL DE PRODUTOS EM PEDIDOS:
SELECT	CONCAT(PF.Fname, ' ', PF.Mint, ' ', PF.Lname)	AS PF_NOME_COMPLETO
		, SUM(PO.poQuantity)							AS TOTAL_QT_PRODUTO
FROM	pessoa_fisica PF
		INNER JOIN	orders O
				ON	PF.IdPessoaFisica = O.idOrderClient
		INNER JOIN	productOrder PO
				ON	O.idOrder = PO.idPOrder
		INNER JOIN	product P
				ON	PO.idPProduct = P.idProduct
GROUP BY	PF_NOME_COMPLETO
ORDER BY 1;

-- LISTA DE CLIENTES (PESSOA JURIDICA) COM QUANTIDADE TOTAL DE PRODUTOS EM PEDIDOS:
SELECT	nameSocial	
		, SUM(PO.poQuantity)							AS TOTAL_QT_PRODUTO
FROM	pessoa_juridica PJ
		INNER JOIN	orders O
				ON	PJ.IdPessoaJuridica = O.idOrderClient
		INNER JOIN	productOrder PO
				ON	O.idOrder = PO.idPOrder
		INNER JOIN	product P
				ON	PO.idPProduct = P.idProduct
GROUP BY	nameSocial
ORDER BY 1;



-- LISTA DE CLIENTES E NÚMERO DOS RESPECTIVOS PEDIDOS:
SELECT	CONCAT(PF.Fname, ' ', PF.Mint, ' ', PF.Lname)	AS CLIENTE,
		O.idOrder									    AS NUMERO_PEDIDO
        
       
FROM	clients C
		INNER JOIN	orders O
				ON	C.IdClient = O.idOrderClient
		INNER JOIN  pessoa_fisica PF
                ON PF.IdCClient = C.IdClient

UNION

SELECT PJ.nameSocial									AS CLIENTE,
       O.idOrder								    	AS NUMERO_PEDIDO
FROM 	clients C
		INNER JOIN	orders O
				ON	C.IdClient = O.idOrderClient
		INNER JOIN  pessoa_juridica PJ
                ON PJ.IdCCliente = C.IdClient   
	oRDER BY 1;


SELECT * 
FROM clients 
       LEFT OUTER JOIN productOrder 
          ON IdClient=IdPOrder;


-- LISTA DE FORNECEDOR QUE TAMBÉM É VENDEDOR
SELECT su.socialName  AS FORNECEDOR_VENDEDOR
FROM   supplier su, seller se
WHERE  su.CNPJ = se.CNPJ;


desc productorder;
desc orders;
desc product;
DESC pessoa_juridica;
desc pessoa_fisica;
desc clients;
desc shippingsupplier;
desc seller;
desc supplier;


