import scrapy
import time
from datetime import datetime


class SubmarinoSpider(scrapy.Spider):
    name = 'submarino'
    start_urls = ['https://www.submarino.com.br/produto/1614132278?pfm_carac=iphone&pfm_index=8&pfm_page=search&pfm_pos=grid&pfm_type=search_page',
                  'https://www.submarino.com.br/produto/1611318018?pfm_carac=iphone&pfm_index=4&pfm_page=search&pfm_pos=grid&pfm_type=search_page',
                  'https://www.submarino.com.br/produto/1614132251?pfm_carac=iphone&pfm_index=1&pfm_page=search&pfm_pos=grid&pfm_type=search_page',
                  'https://www.submarino.com.br/produto/3591021216?pfm_carac=iPhone%2012&pfm_index=6&pfm_page=category&pfm_pos=grid&pfm_type=vit_product_grid&cor=ROXO',
                  'https://www.submarino.com.br/produto/3591020969?pfm_carac=iPhone%2012&pfm_index=4&pfm_page=category&pfm_pos=grid&pfm_type=vit_product_grid&cor=AZUL',
                  'https://www.submarino.com.br/produto/3591023238?pfm_carac=iPhone%2012&pfm_index=2&pfm_page=category&pfm_pos=grid&pfm_type=vit_product_grid&cor=PRETO',
                  'https://www.submarino.com.br/produto/1614307701?pfm_carac=Iphone%2011&pfm_index=20&pfm_page=category&pfm_pos=grid&pfm_type=vit_product_grid&cor=AMARELO#info-section',
                  'https://www.submarino.com.br/produto/2290962881?pfm_carac=iPhone%2012%20Pro&pfm_page=category&pfm_pos=grid&pfm_type=vit_product_grid',
                  'https://www.submarino.com.br/produto/3919420924?pfm_carac=iphone-13-rosa&pfm_page=search&pfm_pos=grid&pfm_type=search_page&offerId=623ddc29d9f593c3e8c1526c&buyboxToken=smartbuybox-suba-v2-20c97f10-82d0-4b60-b603-9467c1a84c1b-2022-05-03%2023%3A18%3A14-0300&cor=ROSA',
                  'https://www.submarino.com.br/produto/3591024100?pfm_carac=iPhone&pfm_page=category&pfm_pos=grid&pfm_type=vit_product_grid&cor=BRANCO#info-section',
                  'https://www.submarino.com.br/produto/3923260231?pfm_carac=iphone-13&pfm_page=search&pfm_pos=grid&pfm_type=search_page&offerId=6271a1ebd9f593c3e8880be5&buyboxToken=smartbuybox-suba-v2-d9764cc7-80cb-4381-8129-728e5753f496-2022-05-03%2023%3A21%3A23-0300&cor=GRAFITE',
                  'https://www.submarino.com.br/produto/4806810580?pfm_carac=iphone-13&pfm_page=search&pfm_pos=grid&pfm_type=search_page&offerId=6244bcb0d9f593c3e840b497&cor=VERDE',
                  'https://www.submarino.com.br/produto/3919528409?pfm_carac=iphone-13&pfm_page=search&pfm_pos=grid&pfm_type=search_page&offerId=61dc775e90c85550371caf3b&buyboxToken=smartbuybox-suba-v2-57c8b1cc-76a7-475b-987e-51ee59d9011b-2022-05-03%2023%3A21%3A23-0300&cor=VERMELHO',
                  'https://www.submarino.com.br/produto/4864624161?pfm_carac=iphone-13&pfm_page=search&pfm_pos=grid&pfm_type=search_page&offerId=624cb89ed9f593c3e80855c2&cor=AZUL',
                  'https://www.submarino.com.br/produto/3919413759?pfm_carac=iphone-13&pfm_page=search&pfm_pos=grid&pfm_type=search_page&offerId=62688093d9f593c3e8381331&cor=Estelar']
    global url
    url = start_urls

    def parse(self, response):
        nome_site = 'submarino'
        data_requisicao = datetime.today().strftime('%Y-%m-%d')  # pega a data que foi feita a requisição
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
        titulo = ''
        descricao_comentario1 = ''
        descricao_comentario2 = ''
        descricao_comentario3 = ''
        data_do_comentario1 = ''
        data_do_comentario2 = ''
        data_do_comentario3 = ''
        data_do_comentario_formatada1 = ''
        data_do_comentario_formatada2 = ''
        data_do_comentario_formatada3 = ''
        imagem_iphone = ''
        resolucao_camera = ''
        preco_atual = '00.00'
        preco_antigo = '00.00'
        preco_antigo_formatado = '00.00'
        preco_atual_formatado = '00.00'
        nota_avaliacao = ''

        titulo = response.css('h1::text').get()
        titulo = titulo.replace("”", "").replace("'", '')
        time.sleep(1)
        preco_atual = response.xpath('//div[contains(@class, "ykHPU")]/text()').getall()
        time.sleep(1)
        preco_antigo = response.xpath('//span[contains(@class, "kiFAcL")]/text()').getall()
        time.sleep(1)

        preco_antigo_formatado = str(preco_antigo)
        preco_antigo_formatado = preco_antigo_formatado[9:17]
        preco_atual_formatado = str(preco_atual)
        preco_atual_formatado = preco_atual_formatado[9:17]

        nota_avaliacao = response.xpath('//span[contains(@class, "icCLbq")]/text()').get()
        time.sleep(1)

        if preco_antigo_formatado is '':
            preco_antigo_formatado = preco_atual_formatado

        preco_atual_formatado = preco_atual_formatado.replace('.', '').replace(',', '.')
        preco_antigo_formatado = preco_antigo_formatado.replace('.', '').replace(',', '.').replace('de ', '').replace('R$ ', '')

        imagem_iphone = response.xpath('.//picture[contains(@class, "jAziSf")]//img/@src')[1].get()

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
            if (aux == 2):
                descricao_comentario2 = comentario.css('span::text').get()
                time.sleep(1)
                data_do_comentario2 = comentario.css('div::text').getall()
                time.sleep(1)
                data_do_comentario_formatada2 = str(data_do_comentario2)
                data_do_comentario_formatada2 = data_do_comentario_formatada2[1:-22]
                data_do_comentario_formatada2 = data_do_comentario_formatada2.replace("'", '').replace(", ", " ")
            if (aux == 3):
                descricao_comentario3 = comentario.css('span::text').get()
                time.sleep(1)
                data_do_comentario3 = comentario.css('div::text').getall()
                time.sleep(1)
                data_do_comentario_formatada3 = str(data_do_comentario3)
                data_do_comentario_formatada3 = data_do_comentario_formatada3[1:-22]
                data_do_comentario_formatada3 = data_do_comentario_formatada3.replace("'", '').replace(", ", " ")

        if (descricao_comentario1 == ''):
            descricao_comentario1 = 'Comentário vazio'
            data_do_comentario_formatada1 = 'Comentário vazio'

        if (descricao_comentario2 == ''):
            descricao_comentario2 = 'Comentário vazio'
            data_do_comentario_formatada2 = 'Comentário vazio'

        if (descricao_comentario3 == ''):
            descricao_comentario3 = 'Comentário vazio'
            data_do_comentario_formatada3 = 'Comentário vazio'

        caracteristica = response.xpath('.//td[@class="src__Text-sc-10qje1m-4 fyapQy"]/text()').getall()
        time.sleep(1)

        for i in range(len(caracteristica)):
            j = i
            time.sleep(1)
            iphone = response.xpath('.//td[@class="src__Text-sc-10qje1m-4 fyapQy"]/text()')[i].get()
            time.sleep(1)
            if (iphone == 'Modelo'):
                modelo = response.xpath('.//td[@class="src__Text-sc-10qje1m-4 fyapQy"]/text()')[j + 1].get()
                time.sleep(1)
                j = i
            elif (iphone == 'Tamanho do Display'):
                tamanho_tela = response.xpath('.//td[@class="src__Text-sc-10qje1m-4 fyapQy"]/text()')[j + 1].get()
                time.sleep(1)
                j = i
            elif (iphone == 'Resolução'):
                resolucao_tela = response.xpath('.//td[@class="src__Text-sc-10qje1m-4 fyapQy"]/text()')[j + 1].get()
                time.sleep(1)
                j = i
            elif (iphone == 'Sistema Operacional'):
                sistema_operacional = response.xpath('.//td[@class="src__Text-sc-10qje1m-4 fyapQy"]/text()')[
                    j + 1].get()
                time.sleep(1)
                j = i
            elif (iphone == 'Processador'):
                processador = response.xpath('.//td[@class="src__Text-sc-10qje1m-4 fyapQy"]/text()')[j + 1].get()
                time.sleep(1)
                j = i
            elif (iphone == 'Tipo de Chip'):
                tipo_chip = response.xpath('.//td[@class="src__Text-sc-10qje1m-4 fyapQy"]/text()')[j + 1].get()
                time.sleep(1)
                j = i
            elif (iphone == 'Peso liq. aproximado do produto (Kg)'):
                peso = response.xpath('.//td[@class="src__Text-sc-10qje1m-4 fyapQy"]/text()')[j + 1].get()
                time.sleep(1)
                j = i
            elif (iphone == 'Cor'):
                cor = response.xpath('.//td[@class="src__Text-sc-10qje1m-4 fyapQy"]/text()')[j + 1].get()
                time.sleep(1)
                j = i
            elif (iphone == 'Garantia do Fornecedor'):
                garantia = response.xpath('.//td[@class="src__Text-sc-10qje1m-4 fyapQy"]/text()')[j + 1].get()
                time.sleep(1)
                j = i
            elif (iphone == 'Conteúdo da Embalagem'):
                itens_inclusos = response.xpath('.//td[@class="src__Text-sc-10qje1m-4 fyapQy"]/text()')[j + 1].get()
                time.sleep(1)
                j = i
            elif (iphone == 'Alimentação, tipo de bateria'):
                bateria = response.xpath('.//td[@class="src__Text-sc-10qje1m-4 fyapQy"]/text()')[j + 1].get()
                time.sleep(1)
                j = i
            elif (iphone == 'Conexões'):
                conectividade = response.xpath('.//td[@class="src__Text-sc-10qje1m-4 fyapQy"]/text()')[j + 1].get()
                time.sleep(1)
                j = i
            elif (iphone == 'Dimensões do produto - cm (AxLxP)'):
                dimensao_produto = response.xpath('.//td[@class="src__Text-sc-10qje1m-4 fyapQy"]/text()')[j + 1].get()
                time.sleep(1)
                j = i
            elif (iphone == 'Câmera Traseira'):
                resolucao_camera_traseira = response.xpath('.//td[@class="src__Text-sc-10qje1m-4 fyapQy"]/text()')[
                    j + 1].get()
                time.sleep(1)
                j = i
            elif (iphone == 'Câmera Frontal'):
                resolucao_camera_frontal = response.xpath('.//td[@class="src__Text-sc-10qje1m-4 fyapQy"]/text()')[
                    j + 1].get()
                time.sleep(1)
                j = i
            elif (iphone == 'Memória Interna'):
                capacidade_armazenamento = response.xpath('.//td[@class="src__Text-sc-10qje1m-4 fyapQy"]/text()')[
                    j + 1].get()
                time.sleep(1)
                j = i

        if (resolucao_camera_frontal != '' and resolucao_camera_traseira != ''):
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
