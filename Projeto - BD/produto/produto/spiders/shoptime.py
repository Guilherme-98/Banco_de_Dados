import scrapy
import time
from datetime import datetime


class ShoptimeSpider(scrapy.Spider):
    name = 'shoptime'
    download_delay = 2
    start_urls = ['https://www.shoptime.com.br/produto/1614132278?pfm_carac=IPhone%2011&pfm_index=4&pfm_page=category&pfm_pos=grid&pfm_type=vit_product_grid#info-section',
                  'https://www.shoptime.com.br/produto/1611318018?pfm_carac=IPhone%2011&pfm_page=category&pfm_pos=grid&pfm_type=vit_product_grid',
                  'https://www.shoptime.com.br/produto/1614132251?pfm_carac=IPhone%2011&pfm_index=2&pfm_page=category&pfm_pos=grid&pfm_type=vit_product_grid',
                  'https://www.shoptime.com.br/produto/3591021216?pfm_carac=iPhone%2012&pfm_index=9&pfm_page=category&pfm_pos=grid&pfm_type=vit_product_grid&cor=ROXO',
                  'https://www.shoptime.com.br/produto/3591020969?pfm_carac=iPhone%2012&pfm_index=4&pfm_page=category&pfm_pos=grid&pfm_type=vit_product_grid&cor=AZUL',
                  'https://www.shoptime.com.br/produto/3591023238?pfm_carac=iPhone%2012&pfm_index=1&pfm_page=category&pfm_pos=grid&pfm_type=vit_product_grid&cor=PRETO',
                  'https://www.shoptime.com.br/produto/1614307701?pfm_carac=IPhone%2011&pfm_index=8&pfm_page=category&pfm_pos=grid&pfm_type=vit_product_grid&cor=AMARELO#info-section',
                  'https://www.shoptime.com.br/produto/2290962881?pfm_carac=iPhone%2012%20Pro&pfm_page=category&pfm_pos=grid&pfm_type=vit_product_grid',
                  'https://www.shoptime.com.br/produto/3919420924?pfm_carac=iphone-13-rosa&pfm_page=search&pfm_pos=grid&pfm_type=search_page&offerId=623ddc2901eed16e39d8d605&buyboxToken=smartbuybox-shop-v2-19adb1cc-ad6e-40ec-977f-20c9c7275e48-2022-05-03%2023%3A19%3A14-0300&cor=ROSA',
                  'https://www.shoptime.com.br/produto/3591024100?pfm_carac=iPhone%2012&pfm_index=2&pfm_page=category&pfm_pos=grid&pfm_type=vit_product_grid&cor=BRANCO#info-section',
                  'https://www.shoptime.com.br/produto/3923260231?pfm_carac=iphone-13&pfm_page=search&pfm_pos=grid&pfm_type=search_page&offerId=6271a1eb01eed16e39f87785&buyboxToken=smartbuybox-shop-v2-0ba79779-95df-4c6c-b385-a31808001993-2022-05-03%2023%3A21%3A49-0300&cor=GRAFITE',
                  'https://www.shoptime.com.br/produto/4806810580?pfm_carac=iphone-13&pfm_page=search&pfm_pos=grid&pfm_type=search_page&offerId=6244bcb001eed16e39113537&cor=VERDE',
                  'https://www.shoptime.com.br/produto/3919528409?pfm_carac=iphone-13&pfm_page=search&pfm_pos=grid&pfm_type=search_page&offerId=61dc775e062ff5a5744bb2af&buyboxToken=smartbuybox-shop-v2-09bef22a-5cf6-4c86-a193-660bc1fa00a9-2022-05-03%2023%3A21%3A49-0300&cor=VERMELHO',
                  'https://www.shoptime.com.br/produto/3919421222?pfm_carac=iphone-13&pfm_page=search&pfm_pos=grid&pfm_type=search_page&offerId=625ed5e101eed16e3918fba3&buyboxToken=smartbuybox-shop-v2-a133e041-7782-4546-9284-6554fc54138a-2022-05-03%2023%3A31%3A55-0300&cor=AZUL',
                  'https://www.shoptime.com.br/produto/3919413759?pfm_carac=iphone-13&pfm_page=search&pfm_pos=grid&pfm_type=search_page&offerId=6268809301eed16e39d47179&cor=Estelar']

    global url
    url = start_urls

    def parse(self, response):
        data_requisicao = datetime.today().strftime('%Y-%m-%d')  # pega a data que foi feita a requisi????o
        nome_site = 'shoptime'
        modelo = ''
        tamanho_tela = ''
        resolucao_tela = ''
        sistema_operacional = ''
        processador = ''
        tipo_chip = ''
        peso = ''
        cor = ''
        garantia = ''
        itens_inclusos = ''
        bateria = ''
        conectividade = ''
        dimensao_produto = ''
        resolucao_camera_traseira = ''
        resolucao_camera_frontal = ''
        capacidade_armazenamento = ''
        descricao_comentario1 = ''
        data_do_comentario1 = ''
        data_do_comentario_formatada1 = ''
        descricao_comentario2 = ''
        data_do_comentario2 = ''
        data_do_comentario_formatada2 = ''
        descricao_comentario3 = ''
        data_do_comentario3 = ''
        data_do_comentario_formatada3 = ''
        titulo = ''
        imagem_iphone = ''
        resolucao_camera = ''
        preco_atual = '00.00'
        preco_antigo = '00.00'
        preco_antigo_formatado = '00.00'
        preco_atual_formatado = '00.00'
        nota_avaliacao = ''

        preco_atual = response.xpath('//div[contains(@class, "iyyimP")]/text()').getall()
        time.sleep(1)
        preco_antigo = response.xpath('//span[contains(@class, "kUiXiw")]/text()').getall()
        time.sleep(1)
        titulo = response.css('h1::text').get()
        titulo = titulo.replace("???", "").replace("'", '')
        time.sleep(1)

        preco_antigo_formatado = str(preco_antigo)
        preco_antigo_formatado = preco_antigo_formatado[9:17]
        preco_atual_formatado = str(preco_atual)
        preco_atual_formatado = preco_atual_formatado[9:17]

        preco_atual_formatado = preco_atual_formatado.replace('.', '').replace(',', '.')
        preco_antigo_formatado = preco_antigo_formatado.replace('.', '').replace(',', '.').replace('de ', '').replace('R$ ', '')

        if preco_antigo_formatado is '':
            preco_antigo_formatado = preco_atual_formatado

        imagem_iphone = response.xpath('.//picture[contains(@class, "jAziSf")]//img/@src')[1].get()

        nota_avaliacao = response.xpath('//span[contains(@class, "icCLbq")]/text()').get()
        time.sleep(1)

        aux = 0
        for comentario in response.xpath('//div[contains(@class, "ebzHvE")]'):
            aux = aux + 1
            time.sleep(1)
            if(aux == 1):
                descricao_comentario1 = comentario.css('span::text').get()
                time.sleep(1)
                data_do_comentario1 = comentario.css('div::text').getall()
                time.sleep(1)
                data_do_comentario_formatada1 = str(data_do_comentario1)
                data_do_comentario_formatada1 = data_do_comentario_formatada1[1:-22]
                data_do_comentario_formatada1 = data_do_comentario_formatada1.replace("'", '').replace(", ", " ")
            if(aux == 2):
                descricao_comentario2 = comentario.css('span::text').get()
                time.sleep(1)
                data_do_comentario2 = comentario.css('div::text').getall()
                time.sleep(1)
                data_do_comentario_formatada2 = str(data_do_comentario1)
                data_do_comentario_formatada2 = data_do_comentario_formatada2[1:-22]
                data_do_comentario_formatada2 = data_do_comentario_formatada2.replace("'", '').replace(", ", " ")
            if(aux == 3):
                descricao_comentario3 = comentario.css('span::text').get()
                time.sleep(1)
                data_do_comentario3 = comentario.css('div::text').getall()
                time.sleep(1)
                data_do_comentario_formatada3 = str(data_do_comentario1)
                data_do_comentario_formatada3 = data_do_comentario_formatada3[1:-22]
                data_do_comentario_formatada3 = data_do_comentario_formatada3.replace("'", '').replace(", ", " ")

        if (descricao_comentario1 == ''):
            descricao_comentario1 = 'Coment??rio vazio'
            data_do_comentario_formatada1 = 'Usu??rio oculto'

        if (descricao_comentario2 == ''):
            descricao_comentario2 = 'Coment??rio vazio'
            data_do_comentario_formatada2 = 'Usu??rio oculto'

        if (descricao_comentario3 == ''):
            descricao_comentario3 = 'Coment??rio vazio'
            data_do_comentario_formatada3 = 'Usu??rio oculto'

        caracteristica = response.xpath('.//td[@class="src__Text-sc-1m6tc2l-4 kBDbsy"]/text()').getall()
        time.sleep(1)

        for i in range(len(caracteristica)):
            j = i
            time.sleep(1)
            iphone = response.xpath('.//td[@class="src__Text-sc-1m6tc2l-4 kBDbsy"]/text()')[i].get()
            time.sleep(1)
            if (iphone == 'Modelo'):
                modelo = response.xpath('.//td[@class="src__Text-sc-1m6tc2l-4 kBDbsy"]/text()')[j + 1].get()
                time.sleep(1)
                j = i
            elif (iphone == 'Tamanho do Display'):
                tamanho_tela = response.xpath('.//td[@class="src__Text-sc-1m6tc2l-4 kBDbsy"]/text()')[j + 1].get()
                time.sleep(1)
                j = i
            elif (iphone == 'Resolu????o'):
                resolucao_tela = response.xpath('.//td[@class="src__Text-sc-1m6tc2l-4 kBDbsy"]/text()')[j + 1].get()
                time.sleep(1)
                j = i
            elif (iphone == 'Sistema Operacional'):
                sistema_operacional = response.xpath('.//td[@class="src__Text-sc-1m6tc2l-4 kBDbsy"]/text()')[
                    j + 1].get()
                time.sleep(1)
                j = i
            elif (iphone == 'Processador'):
                processador = response.xpath('.//td[@class="src__Text-sc-1m6tc2l-4 kBDbsy"]/text()')[j + 1].get()
                time.sleep(1)
                j = i
            elif (iphone == 'Tipo de Chip'):
                tipo_chip = response.xpath('.//td[@class="src__Text-sc-1m6tc2l-4 kBDbsy"]/text()')[j + 1].get()
                time.sleep(1)
                j = i
            elif (iphone == 'Peso liq. aproximado do produto (Kg)'):
                peso = response.xpath('.//td[@class="src__Text-sc-1m6tc2l-4 kBDbsy"]/text()')[j + 1].get()
                time.sleep(1)
                j = i
            elif (iphone == 'Cor'):
                cor = response.xpath('.//td[@class="src__Text-sc-1m6tc2l-4 kBDbsy"]/text()')[j + 1].get()
                time.sleep(1)
                j = i
            elif (iphone == 'Garantia do Fornecedor'):
                garantia = response.xpath('.//td[@class="src__Text-sc-1m6tc2l-4 kBDbsy"]/text()')[j + 1].get()
                time.sleep(1)
                j = i
            elif (iphone == 'Conte??do da Embalagem'):
                itens_inclusos = response.xpath('.//td[@class="src__Text-sc-1m6tc2l-4 kBDbsy"]/text()')[j + 1].get()
                time.sleep(1)
                j = i
            elif (iphone == 'Alimenta????o, tipo de bateria'):
                bateria = response.xpath('.//td[@class="src__Text-sc-1m6tc2l-4 kBDbsy"]/text()')[j + 1].get()
                time.sleep(1)
                j = i
            elif (iphone == 'Conex??es'):
                conectividade = response.xpath('.//td[@class="src__Text-sc-1m6tc2l-4 kBDbsy"]/text()')[j + 1].get()
                time.sleep(1)
                j = i
            elif (iphone == 'Dimens??es do produto - cm (AxLxP)'):
                dimensao_produto = response.xpath('.//td[@class="src__Text-sc-1m6tc2l-4 kBDbsy"]/text()')[j + 1].get()
                time.sleep(1)
                j = i
            elif (iphone == 'C??mera Traseira'):
                resolucao_camera_traseira = response.xpath('.//td[@class="src__Text-sc-1m6tc2l-4 kBDbsy"]/text()')[
                    j + 1].get()
                time.sleep(1)
                j = i
            elif (iphone == 'C??mera Frontal'):
                resolucao_camera_frontal = response.xpath('.//td[@class="src__Text-sc-1m6tc2l-4 kBDbsy"]/text()')[
                    j + 1].get()
                time.sleep(1)
                j = i
            elif (iphone == 'Mem??ria Interna'):
                capacidade_armazenamento = response.xpath('.//td[@class="src__Text-sc-1m6tc2l-4 kBDbsy"]/text()')[
                    j + 1].get()
                time.sleep(1)
                j = i

        if(resolucao_camera_frontal != '' and resolucao_camera_traseira != ''):
            resolucao_camera = 'Traseira  ' + resolucao_camera_traseira + '  ---  Frontal  ' + resolucao_camera_frontal

        yield {
            'titulo': titulo,
            'preco_antigo': preco_antigo_formatado,
            'preco_atual': preco_atual_formatado,
            'modelo': modelo,
            'tamanho_tela': tamanho_tela,
            'resolucao_tela': resolucao_tela,
            'sistema_operacional': sistema_operacional,
            'processador': processador,
            'tipo_chip': tipo_chip,
            'peso': peso,
            'cor': cor,
            'garantia': garantia,
            'itens_inclusos': itens_inclusos,
            'bateria': bateria,
            'conectividade': conectividade,
            'dimensao_produto': dimensao_produto,
            'resolucao_camera': resolucao_camera,
            'capacidade_armazenamento': capacidade_armazenamento,
            'descricao_comentario1': descricao_comentario1,
            'data_do_comentario1': data_do_comentario_formatada1,
            'descricao_comentario2': descricao_comentario2,
            'data_do_comentario2': data_do_comentario_formatada2,
            'descricao_comentario3': descricao_comentario3,
            'data_do_comentario3': data_do_comentario_formatada3,
            'data_preco': data_requisicao,
            'url': url,
            'imagem_iphone': imagem_iphone,
            'nome_site': nome_site,
            'nota_avaliacao': nota_avaliacao
        }
