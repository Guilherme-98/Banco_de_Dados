-- Guilherme Hnerique Gonçalves Silva

-- Select Start SQL

-- Capitulo 01 - A última declaração de Beazley

-- A First SQL Query
-- Primeira consulta SQL busca encontrar as 3 primeiras linhas da tabela 'executions'
SELECT * FROM executions LIMIT 3

-- The SELECT Block
-- Revisar a consulta para selecionar a coluna last_statement além das colunas existentes
SELECT first_name, last_name, last_statement
FROM executions
LIMIT 3

-- The FROM Block
-- Execute a consulta fornecida e observe o erro que ela produz. Corrija a consulta
-- O erro era por falta do 's' final em executions
SELECT first_name FROM executions LIMIT 3

-- Modifique a consulta para dividir 50 e 51 por 2.
SELECT 50 / 2, 51 / 2

-- Verifica que whitespaces e capitalização não interferem na consulta e dão uma consulta válida 
   SeLeCt   first_name,last_name
  fRoM      executions
           WhErE ex_number = 145

-- The WHERE Block
-- Encontre o nome e sobrenome e idades (ex_idade) dos presos com 25 anos ou menos no momento da execução
SELECT * FROM executions 
WHERE ex_age <= 25

SELECT first_name, last_name, ex_age
FROM executions 
WHERE ex_age <= 25

-- Modifique a consulta para encontrar o resultado para Raymond Landry
SELECT first_name, last_name, ex_number
FROM executions
WHERE first_name LIKE '%ond'
  AND last_name LIKE '%dry'
  
SELECT first_name, last_name, ex_number
FROM executions
WHERE first_name LIKE '%ond%'
  AND last_name LIKE '%dry%'

-- Insira um par de parênteses para que esta instrução retorne 0
SELECT 0 AND (0 OR 1)

-- Selecione os blocos WHERE com cláusulas válidas
WHERE 0 -- VERDADEIRA
WHERE ex_age == 62 -- Falsa
WHERE ex_number < ex_age -- VERDADEIRA
WHERE ex_age => 62 -- FALSA
WHERE ex_age -- VERDADEIRA 
WHERE '%obert%' LIKE first_name -- FALSA 

-- Encontre a última declaração de Napoleon Beazley
SELECT last_statement
FROM executions 
WHERE first_name = 'Napoleon'
AND last_name = 'Beazley'

-- Capitulo 02 - Reivindicações de inocência

-- A função COUNT
-- Edite a consulta para saber quantos detentos forneceram as últimas declarações
SELECT COUNT(last_statement) FROM executions

-- Verifique se 0 e a string vazia não são considerados NULL
SELECT (0 IS NOT NULL) AND ('' IS NOT NULL) 

-- Encontre o número total de execuções no conjunto de dados
SELECT COUNT(*) FROM executions

-- Variations on COUNT
-- Verifique se COUNT(*)dá o mesmo resultado de antes
SELECT COUNT(*) FROM executions
/* Observação: como eu já sabia o funcionamento do COUNT(*) e acabei usando no exerecicio anterior pois, sabia que o resultado
estaria certo, e acabou que com a continuação do toturial ele explicou o COUNT(*) e confirmou que o resultado seria o mesmo
*/

-- Substitua SUMs por COUNTs e edite os CASE blocos WHEN para que a consulta ainda funcione
SELECT
    COUNT(CASE WHEN county='Harris' THEN 1
        ELSE NULL END),
    COUNT(CASE WHEN county='Bexar' THEN 1
        ELSE NULL END)
FROM executions

-- Practice
-- Descubra quantos presos tinham mais de 50 anos no momento da execução
SELECT COUNT(*) 
FROM executions
WHERE ex_age > 50

-- Encontre o número de presos que se recusaram a dar uma última declaração
-- Com um bloco WHERE
SELECT count(*) 
from executions 
where last_statement is null

-- Com um COUNT e CASE bloco WHEN
SELECT
    COUNT(CASE WHEN last_statement IS NULL THEN 1
        ELSE NULL END)
FROM executions

-- Com duas função COUNT.
SELECT 
	COUNT(*) - COUNT(last_statement) IS NULL
FROM executions

SELECT 
	COUNT(*) - COUNT(last_statement)
FROM executions

-- Encontre a idade mínima, máxima e média dos presos no momento da execução
SELECT MIN(ex_age), MAX(ex_age), AVG(ex_age) 
FROM executions

-- Encontre o comprimento médio (com base na contagem de caracteres) das últimas instruções no conjunto de dados
SELECT AVG(LEN(last_statement)) 
FROM executions

SELECT AVG(LENGTH(last_statement)) 
FROM executions

-- Liste todos os condados no conjunto de dados sem duplicação
SELECT DISTINCT county 
FROM executions

-- Uma pergunta estranha
-- Vamos tentar de qualquer maneira e ver o que acontece
SELECT first_name, COUNT(*) 
FROM executions

-- Conclusão e Recapitulação
-- Encontre a proporção de presos com alegações de inocência em suas últimas declarações
SELECT 
	1.0 * COUNT (CASE WHEN last_statement LIKE '%innocent%'
			 THEN 1 ELSE NULL END) / COUNT(last_statement)
FROM executions

SELECT 
	1.0 * COUNT (CASE WHEN last_statement LIKE '%innocent%'
			 THEN 1 ELSE NULL END) / COUNT(*)
FROM executions

-- Capitulo 03 - A cauda longa

-- O bloco GROUP BY
-- Essa consulta extrai as contagens de execução por município
SELECT county, COUNT(*) AS county_executions
FROM executions
GROUP BY county

-- Modifique esta consulta para que haja até duas linhas por município — uma contando execuções com uma última instrução e outra sem
SELECT county, last_statement IS NOT NULL, COUNT(*)
FROM executions
GROUP BY county

SELECT county, last_statement IS NOT NULL AS last_statement_aux, COUNT(*)
FROM executions
GROUP BY county, last_statement_aux

-- O bloco HAVING
-- Conte o número de presos com 50 anos ou mais que foram executados em cada município
SELECT county, COUNT(county) AS numero_presos
FROM executions
WHERE ex_age >= 50
GROUP BY county

-- Liste os condados em que mais de 2 presos com 50 anos ou mais foram executados
SELECT county, COUNT(county) AS numero_presos
FROM executions
WHERE ex_age >= 50
GROUP BY county 
HAVING numero_presos > 2

SELECT county
FROM executions
WHERE ex_age >= 50
GROUP BY county
HAVING COUNT(county) > 2

-- Practice
-- Marque as afirmações que são verdadeiras.
/*The query is valid (ie. won't throw an error when run). -- Verdadeira 
The query would return more rows if we were to use ex_age instead of ex_age/10. -- Verdadeira 
The output will have as many rows as there are unique combinations of counties and decade_ages in the dataset. -- Verdadeira 
The output will have a group ('Bexar', 6) even though no Bexar county inmates were between 60 and 69 at execution time. -- FALSA
The output will have a different value of county for every row it returns. -- FALSA
The output can have groups where the count is 0. -- FALSA
The query would be valid even if we don't specify county in the SELECT block. -- Verdadeira
It is reasonable to add last_name to the SELECT block even without grouping by it. -- Falsa
*/

-- Liste todos os condados distintos no conjunto de dados
SELECT county 
FROM executions 
GROUP BY county

-- Consultas aninhadas
-- Encontre o nome e o sobrenome do preso com a última declaração mais longa (por contagem de caracteres)
SELECT first_name, last_name
FROM executions
WHERE LENGTH(last_statement) = MAX(LENGTH(last_statement))

SELECT first_name, last_name
FROM executions
WHERE LENGTH(last_statement) = (SELECT MAX(LENGTH(last_statement)) FROM executions)

-- Insira a count-of-all-rowsconsulta < > para encontrar a porcentagem de execuções de cada município
SELECT county,
  100.0 * COUNT(*) / (COUNT(county))
    AS percentage
FROM executions
GROUP BY county
ORDER BY percentage DESC

SELECT county,
  100.0 * COUNT(*) / (SELECT COUNT(county) FROM EXECUTIONS)
    AS percentage
FROM executions
GROUP BY county
ORDER BY percentage DESC

-- Capitulo 04 - Hiatos de execução

-- Pensando em Associações
-- Tipos de Junções
-- Marque as afirmações verdadeiras
/*
tableA JOIN tableB ON 1 returns 15 rows. -- Verdadeira
tableA JOIN tableB ON 0 returns 0 rows. -- Verdadeira
tableA LEFT JOIN tableB ON 0 returns 3 rows. -- Verdadeira
tableA OUTER JOIN tableB ON 0 returns 8 rows. -- Verdadeira
tableA OUTER JOIN tableB ON 1 returns 15 rows. -- Verdadeira
*/

-- Datas
-- Consulte a documentação para corrigir a consulta para que ela retorne o número de dias entre as datas
SELECT JULIANDAY('1993-08-10') - JULIANDAY('1989-07-07') AS day_difference

-- Auto-junções
-- Escreva uma consulta para produzir a previous tabela
SELECT
  ex_number + 1 AS ex_number,
  ex_date AS last_ex_date
FROM executions
WHERE ex_number <= 553

SELECT
  ex_number + 1 AS ex_number,
  ex_date AS last_ex_date
FROM executions
WHERE ex_number < 553

-- Aninhe a consulta que gera a previous tabela no modelo
SELECT last_ex_date AS start, ex_date AS end,
  JULIANDAY(ex_date) - JULIANDAY(last_ex_date) AS day_difference
FROM executions
JOIN (SELECT ex_number + 1 AS ex_number, ex_date AS last_ex_date
FROM executions
WHERE ex_number < 553) previous
ON executions.ex_number = previous.ex_number
ORDER BY day_difference DESC
LIMIT 10

-- Preencha a JOIN ON cláusula para completar uma versão mais elegante da consulta anterior
SELECT previous.ex_date AS start, executions.ex_date AS end,
	JULIANDAY(executions.ex_date) - JULIANDAY(previous.ex_date) AS day_difference
FROM executions
JOIN executions previous
ON executions.ex_number + 1 = previous.ex_number
ORDER BY day_difference DESC
LIMIT 10

SELECT previous.ex_date AS start, executions.ex_date AS end,
	JULIANDAY(executions.ex_date) - JULIANDAY(previous.ex_date) AS day_difference
FROM executions
JOIN executions previous
ON executions.ex_number  = previous.ex_number + 1
ORDER BY day_difference DESC
LIMIT 10

-- Capitolo 05 - Observações Finais e Perguntas-Desafio

-- Observações Finais
-- Perguntas de desafio
-- Conjunto de dados de patrocínio do Senado
-- Dê uma olhada no conjunto de dados
SELECT * FROM cosponsors LIMIT 3

-- Encontre o senador mais conectado. Ou seja, aquele com mais copatrocínios mútuos
SELECT DISTINCT aux1.sponsor_name AS senador_1, aux2.sponsor_name AS senador_2
FROM cosponsors aux1
JOIN cosponsors aux2 
ON aux1.sponsor_name = aux2.cosponsor_name
    AND aux2.sponsor_name = aux1.cosponsor_name
SELECT senador_1, COUNT(*) AS copatrocinios_mutuos
FROM aux1
GROUP BY senador_1
ORDER BY copatrocinios_mutuos DESC
-- Observação: Foi bem dificil resolver essa questão pois eu não sabia muito bem como usar o comando WITH, no primeiro momento nem pensei em usar esse comando
WITH mutuals AS (
	SELECT DISTINCT aux1.sponsor_name AS senador_1, aux2.sponsor_name AS senador_2
	FROM cosponsors aux1
	JOIN cosponsors aux2 
	ON aux1.sponsor_name = aux2.cosponsor_name
    	AND aux2.sponsor_name = aux1.cosponsor_name
)
SELECT senador_1, COUNT(*) AS copatrocinios_mutuos
FROM mutuals
GROUP BY senador_1
ORDER BY copatrocinios_mutuos DESC LIMIT 1 

-- Agora encontre o senador mais conectado de cada estado
-- Este exercicio foi bastante complexo para o entendimento, tive que refazer ele por muitas vezes e também tive que me auxiliar com a resosta que ele oferece
WITH patrocinio_mutuo_contador AS (
	SELECT senador, estado, COUNT(*) AS patrocinio_mutuo_contador
	FROM cosponsors aux1
	SELECT DISTINCT aux1.sponsor_name AS senador, aux1.sponsor_state AS estado, aux2.sponsor_name AS senador2
	FROM cosponsors aux1
	JOIN cosponsors aux2 
	ON aux1.sponsor_name = aux2.cosponsor_name
		AND aux2.sponsor_name = aux1.cosponsor_name
	GROUP BY senador, estado
),
-- Outra tentativa
WITH patrocinio_mutuo_contador AS (
  SELECT senador, estado, COUNT(*) AS mutuo_contador
  FROM (
    SELECT DISTINCT aux1.sponsor_name AS senador, aux1.sponsor_state AS estado, aux2.sponsor_name AS senador2
    FROM cosponsors aux1
    JOIN cosponsors aux2 
	ON aux1.sponsor_name = aux2.cosponsor_name
    	AND aux2.sponsor_name = aux1.cosponsor_name
    )
  GROUP BY senador, estado
),

estado_max AS (
  SELECT estado, MAX(mutuo_contador)
  FROM patrocinio_mutuo_contador
)

SELECT patrocinio_mutuo_contador.estado, patrocinio_mutuo_contador.senador, patrocinio_mutuo_contador.mutuo_contador
FROM patrocinio_mutuo_contador
JOIN estado_max 
ON patrocinio_mutuo_contador.estado = estado_max.estado 
-- Depois de várias tentaivas 
WITH patrocinio_mutuo_contador AS (
  SELECT senador, estado, COUNT(*) AS mutuo_contador
  FROM (
    SELECT DISTINCT aux1.sponsor_name AS senador, aux1.sponsor_state AS estado, aux2.sponsor_name AS senador2
    FROM cosponsors aux1
    JOIN cosponsors aux2 
	ON aux1.sponsor_name = aux2.cosponsor_name
    	AND aux2.sponsor_name = aux1.cosponsor_name
    )
  GROUP BY senador, estado
),

estado_max AS (
  SELECT estado, MAX(mutuo_contador) AS max_mutuo_contador
  FROM patrocinio_mutuo_contador
  GROUP BY estado
)

SELECT patrocinio_mutuo_contador.estado, patrocinio_mutuo_contador.senador, patrocinio_mutuo_contador.mutuo_contador
FROM patrocinio_mutuo_contador
JOIN estado_max 
ON patrocinio_mutuo_contador.estado = estado_max.estado 
	AND patrocinio_mutuo_contador.mutuo_contador = estado_max.max_mutuo_contador

-- Encontre os senadores que co-patrocinaram, mas não patrocinaram projetos de lei
SELECT DISTINCT aux1.cosponsor_name
FROM cosponsors AS aux1
LEFT JOIN cosponsors AS aux2 
ON aux1.cosponsor_name = aux2.sponsor_name
WHERE aux2.sponsor_name IS NULL

-- Finalização do tutorial de SQL
