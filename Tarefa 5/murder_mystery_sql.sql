-- Guilherme Henrique Gonçalves Silva 

-- SQL Murder Mystery

-- Recebemos 3 informações: Um assassinato, 15 de janeiro de 2018 e Cidade SQL
-- Com isso, filtramos para obter dados úteis com a tabela crime_scene_report
SELECT * FROM crime_scene_report
WHERE type = 'murder' AND city = 'SQL City' AND date = '20180115'
-- Esta consulta permite-nos descobrir que o crime teve duas testemunhas

-- A primeira testemunha vive na última casa em "Northwestern Dr"
-- A segunda testemunha, chamada Annabel, mora em algum lugar na "Franklin Ave"

-- Com isso, podemos examinar as entrevistas dessas testemunhas
-- A tabela de pessoas também possui informações sobre nomes e endereços, com isso, podemos filtrar os dados para encontrar as testemunhas

-- Vamos começar encontrando o id de Annabel
-- Primeira tentativa teve erro por causa do uso do simbolo = 
SELECT * FROM person
WHERE name = '%Annabel%' AND address_street_name = 'Franklin Ave'

SELECT * FROM person
WHERE name LIKE '%Annabel%' AND address_street_name = 'Franklin Ave'
-- A consulta nos mostrou que o id de Annabel é 16371

-- Vamos procurar nossa segunda testemunha, morando na última casa na Northwestern Dr
SELECT * FROM person 
WHERE address_street_name = 'Northwestern Dr'
ORDER BY address_number DESC LIMIT 1
-- A consulta nos mostrou que a segunda testemunha é Morty Schapiro e o id é 14887

-- Agora com os dois ids, procuramos as transcrições das entrevistas
SELECT transcript FROM interview 
WHERE person_id = '16371'
/*Testemunha Annabel: Eu vi o assassinato acontecer e reconheci o assassino da minha academia
quando estava malhando na semana passada, no dia 9 de janeiro.
*/

SELECT transcript FROM interview 
WHERE person_id = '14887'
/*Testemunha Morty: Ouvi um tiro e depois vi um homem sair correndo. 
Ele tinha uma bolsa "Get Fit Now Gym". O número de membro na bolsa começava com "48Z". 
Apenas membros de ouro têm essas bolsas. O homem entrou em um carro com uma placa que incluía "H42W".
*/

-- Testemhunha de Morty confirma que o assassino é um membro da academia

-- Combinando a data de check-in da Annabel na academia e a identificação parcial do numero de membro da academia feita por Morty
-- Conseguimios a identificação completa do assassino
SELECT membership_id FROM get_fit_now_check_in 
WHERE membership_id LIKE '%48z%' AND check_in_date = '20180109'
-- Dois membros com ids começando com '48Z' fizeram check-in em 9 de janeiro

-- Agora que temos apenas 2 suspeitos, podemos usar seu person_id e a tabela get_fit_now_member para chegar na solução
-- Erro nos operadores AND e OR (troquei os comandos) 
-- E a falta de fazer o filtro usando a informação do status do membro é ouro
SELECT * FROM get_fit_now_member
WHERE id = '48Z7A' AND id = '48Z55'

SELECT * FROM get_fit_now_member
WHERE id = '48Z7A' OR id = '48Z55' AND membership_status = 'gold'
-- Com isso, temos  dois nomes: Joe Germuska e Jeremy Bowers

-- Podemos usá-los seus nomes para encontrar suas placas de veiculos e ver se alguma delas corresponde à descrição de Morty
SELECT person.name, drivers_license.plate_number 
FROM person
JOIN drivers_license
ON person.license_id = drivers_license.id
WHERE person.name = 'Joe Germuska' OR person.name = 'Jeremy Bowers'
-- Concluímos que apenas Jeremy Bowers tem um carro registrado e sua placa igual à descrição de Morty

INSERT INTO solution VALUES (1, 'Jeremy Bowers');
SELECT value FROM solution;
-- Com isso, encontramos nosso assassino, Jeremy Bowers é o seu nome
/*
Parabéns, você encontrou o assassino! Mas espere, há mais... 
Se você acha que está pronto para um desafio, tente consultar a transcrição da entrevista do assassino 
para encontrar o verdadeiro vilão por trás desse crime. 
Se você se sentir especialmente confiante em suas habilidades de SQL, tente concluir esta etapa final com no máximo 2 consultas. 
Use esta mesma instrução INSERT com seu novo suspeito para verificar sua resposta.
*/

-- O verdadeiro vilão por trás desse crime

-- O person_id de Jeremy Bowers é 67318 
-- Podemos obter a transcrição da entrevista
SELECT transcript FROM interview
WHERE person_id = '67318'
/*Fui contratado por uma mulher com muito dinheiro. 
Eu não sei o nome dela, mas eu sei que ela tem cerca de 5'5″ (65″) ou 5'7″ (67″).
Ela tem cabelos ruivos e dirige um Tesla Model S.
Eu sei que ela participou do SQL Symphony Concert 3 vezes em dezembro de 2017.
*/

-- Com as varias informações obditas por Jeremy Bowers podemos achar o nome do verdadeiro vilão por trás desse crime
-- A tabela drivers_license contém informações sobre altura, cor do cabelo, sexo, modelo e fabricante do carro
-- E a informação do evento podemos usar a tabela facebook_event_checkin 
-- Em primeiro momento eu esqueci de usar a informação do evento, 
-- Com isso, não pude achar o nome da pessoa, pois, existiam 3 nomes que tinham as mesmas caracteristicas pessoais do suspeito
SELECT person.name, drivers_license.height, drivers_license.hair_color, drivers_license.gender, drivers_license.car_model,
	drivers_license.car_make
FROM drivers_license
JOIN person 
ON drivers_license.id = person.license_id
WHERE drivers_license.height BETWEEN 65 AND 67 
	AND drivers_license.hair_color = 'red' 
	AND gender = 'female'
	AND car_model = 'Model S' AND car_make = 'Tesla'

SELECT person.name, drivers_license.height, drivers_license.hair_color, drivers_license.gender, drivers_license.car_model,
	drivers_license.car_make
FROM drivers_license
JOIN person 
ON drivers_license.id = person.license_id
WHERE drivers_license.height BETWEEN 65 AND 67 
	AND drivers_license.hair_color = 'red' 
	AND gender = 'female'
	AND car_model = 'Model S' AND car_make = 'Tesla'
	AND person.id IN (SELECT facebook_event_checkin.person_id
					  FROM facebook_event_checkin 
					  WHERE facebook_event_checkin.event_name = 'SQL Symphony Concert')
-- Concluímos que apenas Miranda Priestly possui essas informações e características pessoais 

INSERT INTO solution VALUES (1, 'Miranda Priestly');
SELECT value FROM solution;
-- Encontramos o verdadeiro vilão por trás desse crime, seu nome é Miranda Priestly
/*
Parabéns, você encontrou o cérebro por trás do assassinato! 
Todos em SQL City o aclamam como o maior detetive de SQL de todos os tempos. Hora de abrir o champanhe!
*/
