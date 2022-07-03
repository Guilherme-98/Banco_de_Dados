import psycopg2
import json

try:
    connection = psycopg2.connect(user="guilherme_bd",
                                  password="guilherme1998",
                                  host="localhost",
                                  port="5432",
                                  database="guilherme_bd")
    cursor = connection.cursor()

    #Lendo json
    # Opening JSON file

    f = open("../../submarino.json", encoding='utf-8')
    # returns JSON object as
    # a dictionary
    data = json.load(f)
    # Iterating through the json
    # list

    for i in data:

        valor_atual = (i['preco_atual']).replace('.', '').replace(',', '.')
        valor_antigo = (i['preco_antigo']).replace('.', '').replace(',', '.').replace('de ', '').replace('R$ ', '')

        #verificação para ver se o iphone a ser adicionado existe preço
        if(valor_atual == '' or valor_antigo == ''):
            continue

        #Inserção da tabela site
        postgres_insert_query = "INSERT INTO produto.site (url) VALUES (%s)"
        aux = (i['url'])
        record_to_insert = (aux,)
        cursor.execute(postgres_insert_query, record_to_insert)

        #Pegando variável id_site do banco de dados para usar como fk no iphone
        consulta_sql = "select * from produto.site"
        cursor.execute(consulta_sql)
        linhas = cursor.fetchall()

        for linha in linhas:
            ultimo_id_site = linha[1]

        #Inserção da tabela produto
        postgres_insert_query =  "INSERT INTO  produto.iphone (bateria, peso, dimensao_produto, cor, garantia, itens_inclusos, conectividade, tipo_chip, processador, sistema_operacional, resolucao_tela, tamanho_tela, modelo, titulo, imagem_iphone, nota, id_site)  " \
                                 "VALUES (%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s)"
        record_to_insert = (i['bateria'],i['peso'],i['dimensao_produto'],i['cor'],i['garantia'],i['itens_inclusos'],i['conectividade'],i['tipo_chip'],i['processador'],i['sistema_operacional'],i['resolucao_tela'],i['tamanho_tela'],i['modelo'],i['titulo'],i['imagem_iphone'], i['nota_iphone'], ultimo_id_site)
        cursor.execute(postgres_insert_query, record_to_insert)

        # Pegando variável id_produto do banco de dados para usar como fk no comentario
        consulta_sql = "select * from produto.iphone"
        cursor.execute(consulta_sql)
        linhas = cursor.fetchall()

        for linha in linhas:
            ultimo_id_iphone = linha[0]

        #Inserção da tabela comentario
        postgres_insert_query = "INSERT INTO produto.comentario (descricao_comentario, data_do_comentario, id_iphone)" \
                                "VALUES (%s, %s, %s)"
        record_to_insert = (i['descricao_comentario'], i['data_do_comentario'], ultimo_id_iphone)
        cursor.execute(postgres_insert_query, record_to_insert)

        # Pegando variável id_produto do banco de dados para usar como fk no preco
        consulta_sql = "select * from produto.iphone"
        cursor.execute(consulta_sql)
        linhas = cursor.fetchall()

        for linha in linhas:
            ultimo_id_iphone = linha[0]

        #Inserção da tabela preço
        postgres_insert_query = "INSERT INTO produto.preco (data_preco, id_iphone)" \
                                "VALUES (%s, %s)"
        record_to_insert = (i['data_preco'])
        aux = (i['data_preco'])
        record_to_insert = ((aux,), ultimo_id_iphone)
        cursor.execute(postgres_insert_query, record_to_insert)

        # Pegando variável id_preco do banco de dados para usar como chave primaria em preco_parcelado
        consulta_sql = "select * from produto.preco"
        cursor.execute(consulta_sql)
        linhas = cursor.fetchall()

        for linha in linhas:
            ultimo_id_preco = linha[0]

        #Inserção da tabela preço_parcelado
        postgres_insert_query = "INSERT INTO produto.preco_parcelado (descricao_preco_parcelado, id_preco)" \
                                "VALUES (%s, %s)"
        descricao_parcela = (i['descricao_preco_parcelado']).replace(']', '').replace("'", '')

        record_to_insert = (descricao_parcela, ultimo_id_preco)
        cursor.execute(postgres_insert_query, record_to_insert)

        # Pegando variável id_preco do banco de dados para usar como chave primaria em preco_a_vista
        consulta_sql = "select * from produto.preco"
        cursor.execute(consulta_sql)
        linhas = cursor.fetchall()

        for linha in linhas:
            ultimo_id_preco = linha[0]

        #Inserção da tabela preço_a_vista
        postgres_insert_query = "INSERT INTO produto.preco_a_vista (preco_atual , preco_antigo, id_preco)" \
                                "VALUES (%s, %s, %s)"

        #Formatação dos preços para numeric
        valor_atual = (i['preco_atual']).replace('.', '').replace(',', '.')
        valor_antigo = (i['preco_antigo']).replace('.', '').replace(',', '.').replace('de ', '').replace('R$ ', '')

        record_to_insert = (valor_atual, valor_antigo, ultimo_id_preco)
        cursor.execute(postgres_insert_query, record_to_insert)

        # Pegando variável id_iphone do banco de dados para usar como chave estrangeira em armazenamento
        consulta_sql = "select * from produto.iphone"
        cursor.execute(consulta_sql)
        linhas = cursor.fetchall()

        for linha in linhas:
            ultimo_id_iphone = linha[0]

        #Inserção da tabela armazenamento
        postgres_insert_query = "INSERT INTO produto.armazenamento (capacidade_armazenamento, descricao_armazenamento, id_iphone)" \
                                "VALUES (%s, %s, %s)"
        record_to_insert = (i['capacidade_armazenamento'], i['descricao_armazenamento'], ultimo_id_iphone)
        cursor.execute(postgres_insert_query, record_to_insert)

        # Pegando variável id_iphone do banco de dados para usar como chave estrangeira em camera
        consulta_sql = "select * from produto.iphone"
        cursor.execute(consulta_sql)
        linhas = cursor.fetchall()

        for linha in linhas:
            ultimo_id_iphone = linha[0]

        #Inserção da tabela camera
        postgres_insert_query = "INSERT INTO produto.camera (resolucao_camera, descricao_camera, id_iphone)" \
                                "VALUES (%s, %s, %s)"
        record_to_insert = (i['resolucao_camera'], i['descricao_camera'], ultimo_id_iphone)
        cursor.execute(postgres_insert_query, record_to_insert)

    #Closing file
    f.close()

    connection.commit()
    count = cursor.rowcount
    print(count, "Record inserted successfully")

except (Exception, psycopg2.Error) as error:
    print("Failed to insert", error)

finally:
    # closing database connection.
    if connection:
        cursor.close()
        connection.close()
        print("PostgreSQL connection is closed")