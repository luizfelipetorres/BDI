-- Questão 1
CREATE TABLE EDITORA (
   COD_EDITORA INT NOT NULL,
   DESCRICAO VARCHAR (30) NOT NULL,
   ENDERECO VARCHAR (30) NULL,
   CONSTRAINT PK_EDITORA PRIMARY KEY (COD_EDITORA)  
);

CREATE TABLE LIVRO (
    COD_LIVRO INT NOT NULL,
    ISBN VARCHAR (20) NOT NULL,
    TITULO VARCHAR (45) NOT NULL,
	NUM_EDICAO INT NOT NULL,
	PRECO FLOAT NOT NULL,
	COD_EDITORA INT NOT NULL,
	CONSTRAINT PK_LIVRO PRIMARY KEY (COD_LIVRO),
	CONSTRAINT FK_LIVRO_EDITORA FOREIGN KEY (COD_EDITORA)
	     REFERENCES EDITORA (COD_EDITORA)
);

CREATE TABLE AUTOR (
    COD_AUTOR INT NOT NULL,
	NOME VARCHAR (45) NOT NULL,
	SEXO CHAR (1) NOT NULL,
	DATA_NASCIMENTO DATE NOT NULL,
	CONSTRAINT PK_AUTOR PRIMARY KEY (COD_AUTOR)
);

CREATE TABLE LIVRO_AUTOR (
    COD_LIVRO INT NOT NULL,
	COD_AUTOR INT NOT NULL,
	CONSTRAINT PK_LIVRO_AUTOR 
	    PRIMARY KEY (COD_LIVRO, COD_AUTOR),
	CONSTRAINT FK_LA_LIVRO FOREIGN KEY (COD_LIVRO)
	    REFERENCES LIVRO (COD_LIVRO),
	CONSTRAINT FK_LA_AUTOR FOREIGN KEY (COD_AUTOR)
	    REFERENCES AUTOR (COD_AUTOR)
);

-- Questão 2
INSERT INTO EDITORA (COD_EDITORA, DESCRICAO, ENDERECO)
   VALUES (1, 'Campus', 'Rua do Timbó'), 
          (2, 'Abril', null),
		  (3, 'Editora Teste', null);

INSERT INTO LIVRO 
	(COD_LIVRO, ISBN, TITULO, NUM_EDICAO, PRECO, COD_EDITORA)
VALUES 
	(1, '12345', 'Banco de Dados', 3, 70.00, 1),
	(2, '35790', 'SGBD', 1, 85.00, 2),
	(3, '98765', 'Redes de Computadores', 2, 80.00, 2);


INSERT INTO AUTOR (COD_AUTOR, NOME, SEXO, DATA_NASCIMENTO) 
VALUES 
	(1, 'João', 'M', '1970/01/01'),
	(2, 'Maria', 'F', '1974/05/17'),
	(3, 'José', 'M', '1977/10/10'),
	(4, 'Carla', 'F', '1964/12/08');

INSERT INTO LIVRO_AUTOR 
	(COD_LIVRO, COD_AUTOR)
VALUES
	(1, 1),
	(1, 2),
	(2, 2),
	(2, 4),
	(3, 3);
	
SELECT * FROM EDITORA;

SELECT * FROM AUTOR;

SELECT * FROM LIVRO_AUTOR;

SELECT * FROM LIVRO;

SELECT * FROM LIVRO WHERE COD_LIVRO = 1;

SELECT COUNT (*) AS QTD_LIVROS FROM LIVRO;

-- Questão 3
--1. Atualizar o endereço da Editora Campus para ‘Av. ACM’ 
UPDATE EDITORA SET ENDERECO = 'Av. ACM' WHERE COD_EDITORA = 1;

--2. Atualizar os preços dos livros em 10% 
UPDATE LIVRO SET PRECO = PRECO * 1.10;

--3. Excluir a ‘Editora Teste’ 
DELETE FROM EDITORA WHERE DESCRICAO = 'Editora Teste'; 

--4. Apresentar o nome e data de nascimento de todos os autores 
SELECT NOME, DATA_NASCIMENTO FROM AUTOR;

--5. Apresentar o nome e a data de nascimento dos autores por ordem de nome. 
SELECT NOME, DATA_NASCIMENTO FROM AUTOR ORDER BY NOME ASC;

--6. Apresentar o nome e a data de nascimento dos autores do sexo feminino ordenados pelo nome.
SELECT NOME, DATA_NASCIMENTO FROM AUTOR WHERE SEXO = 'F' ORDER BY NOME ASC;

--7. Apresentar o nome das editoras que não tem o endereço cadastrado. 
SELECT DESCRICAO FROM EDITORA WHERE ENDERECO IS NULL;

--8. Apresentar o título do livro e o nome da sua editora 
SELECT l.TITULO, e.DESCRICAO 
FROM LIVRO AS l 
INNER JOIN EDITORA AS e 
ON l.COD_EDITORA = e.COD_EDITORA;

--8 forma errada
SELECT l.TITULO, e.DESCRICAO 
FROM LIVRO AS l, EDITORA AS e 
WHERE l.COD_EDITORA = e.COD_EDITORA;

--todas as combinações possíveis 
SELECT l.TITULO, e.DESCRICAO, au.NOME
FROM LIVRO AS l, EDITORA AS e, AUTOR AS au;

--9.Apresentar o título do livro e o nome da sua editora. Caso haja alguma editora sem livro publicado, informar os dados da editora com valores nulos para os livros. 

--Obs: Inserindo editora sem livro para testar RIGHT JOIN
INSERT INTO EDITORA 
	(COD_EDITORA, DESCRICAO, ENDERECO)
VALUES
	(3, 'TESTE', null);

SELECT l.TITULO, e.DESCRICAO 
FROM LIVRO AS l 
RIGHT JOIN EDITORA AS e 
ON l.COD_EDITORA = e.COD_EDITORA;

--Mesma coisa
SELECT l.TITULO, e.DESCRICAO 
FROM EDITORA AS e
LEFT JOIN LIVRO AS l 
ON l.COD_EDITORA = e.COD_EDITORA;

--10. Apresentar o título do livro e o nome dos seus autores 
SELECT l.TITULO, au.NOME FROM LIVRO_AUTOR AS la
	INNER JOIN AUTOR AS au
	ON au.COD_AUTOR = la.COD_AUTOR
	INNER JOIN LIVRO AS l
	ON l.COD_LIVRO = la.COD_LIVRO;
	
--11 Apresentar o nome da editora e o nome dos autores que já publicaram 
--algum livro na editora
SELECT editora.DESCRICAO, autor.NOME FROM LIVRO_AUTOR as livro_autor
	INNER JOIN AUTOR AS autor
	ON livro_autor.COD_AUTOR = autor.COD_AUTOR
	INNER JOIN LIVRO AS livro
	ON livro_autor.COD_LIVRO = livro.COD_LIVRO
	INNER JOIN EDITORA as editora
	ON livro.COD_EDITORA = editora.COD_EDITORA;
	
SELECT editora.DESCRICAO, autor.NOME FROM LIVRO_AUTOR as livro_autor
	INNER JOIN AUTOR AS autor
	ON livro_autor.COD_AUTOR = autor.COD_AUTOR
	INNER JOIN LIVRO AS livro
	ON livro_autor.COD_LIVRO = livro.COD_LIVRO
	INNER JOIN EDITORA as editora
	ON livro.COD_EDITORA = editora.COD_EDITORA;




