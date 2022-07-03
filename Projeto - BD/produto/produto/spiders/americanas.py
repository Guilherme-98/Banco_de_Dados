import scrapy
import time
from datetime import datetime


class AmericanasSpider(scrapy.Spider):
    name = 'americanas'
    start_urls = ['https://www.americanas.com.br/produto/1614132278?pfm_carac=iphone&pfm_page=search&pfm_pos=grid&pfm_type=search_page&offerId=5e8b830279bf8430cb9e9b28&buyboxToken=smartbuybox-acom-v2-9396af62-d98d-4b2d-acea-3e84f70914bf-2022-03-18%2022%3A50%3A25-0300',
                  'https://www.americanas.com.br/produto/1611318018?pfm_carac=iphone&pfm_page=search&pfm_pos=grid&pfm_type=search_page&offerId=5e8b830279bf8430cb9e9aae&buyboxToken=smartbuybox-acom-v2-b98ec644-fbbf-47e1-9ca0-287d5b834103-2022-03-18%2022%3A50%3A25-0300',
                  'https://www.americanas.com.br/produto/1614132251?pfm_carac=iphone&pfm_page=search&pfm_pos=grid&pfm_type=search_page&offerId=6014043e0c070442666aa03e&buyboxToken=smartbuybox-acom-v2-0e9a509f-ba1c-437c-970e-bddc313beba3-2022-03-18%2022%3A50%3A25-0300',
                  'https://www.americanas.com.br/produto/3591021216?pfm_page=search&pfm_pos=grid&pfm_type=search_page&cor=ROXO',
                  'https://www.americanas.com.br/produto/3591020969?pfm_page=search&pfm_pos=grid&pfm_type=search_page&cor=AZUL',
                  'https://www.americanas.com.br/produto/3591023238?pfm_page=search&pfm_pos=grid&pfm_type=search_page&cor=PRETO',
                  'https://www.americanas.com.br/produto/1614307701?pfm_page=search&pfm_pos=grid&pfm_type=search_page&cor=AMARELO#info-section',
                  'https://www.americanas.com.br/produto/2290962881?pfm_page=search&pfm_pos=grid&pfm_type=search_page',
                  'https://www.americanas.com.br/produto/3919420924?pfm_carac=iphone-13-rosa&pfm_page=search&pfm_pos=grid&pfm_type=search_page&offerId=623ddc2987c00289c2cfadad&buyboxToken=smartbuybox-acom-v2-305156c2-df97-428d-9c08-3613f5dd09b6-2022-05-03%2023%3A20%3A27-0300&cor=ROSA',
                  'https://www.americanas.com.br/produto/3591024100?pfm_page=search&pfm_pos=grid&pfm_type=search_page&cor=BRANCO#info-section',
                  'https://www.americanas.com.br/produto/3923260231?pfm_carac=iphone-13&pfm_page=search&pfm_pos=grid&pfm_type=search_page&offerId=6271a33c87c00289c24a15ac&buyboxToken=smartbuybox-acom-v2-9ed858c3-a3b8-4482-8c3f-879d4019dc81-2022-05-03%2023%3A15%3A23-0300&cor=GRAFITE',
                  'https://www.americanas.com.br/produto/4806810580?pfm_carac=iphone-13&pfm_page=search&pfm_pos=grid&pfm_type=search_page&offerId=6244bcb087c00289c25d91fa&cor=VERDE',
                  'https://www.americanas.com.br/produto/3919528409?pfm_carac=iphone-13&pfm_page=search&pfm_pos=grid&pfm_type=search_page&offerId=61dc775ed9fd6edeec3ac25e&buyboxToken=smartbuybox-acom-v2-1b9c8052-15e4-49dc-a7ab-4d93c16abe71-2022-05-03%2023%3A27%3A28-0300&cor=VERMELHO',
                  'https://www.americanas.com.br/produto/3919421222?pfm_carac=iphone-13&pfm_page=search&pfm_pos=grid&pfm_type=search_page&offerId=625ed5e187c00289c2d0de8a&buyboxToken=smartbuybox-acom-v2-bb3f9e69-0f20-4b11-b9d1-f9cfa0797410-2022-05-03%2023%3A32%3A56-0300&cor=AZUL',
                  'https://www.americanas.com.br/produto/3919413759?pfm_carac=iphone-13-estelar&pfm_page=search&pfm_pos=grid&pfm_type=search_page&offerId=6268822687c00289c2ee13c5&cor=Estelar']

    global url_site
    url_site = start_urls

    def parse(self, response):
        nome_site = 'americanas'
        data_requisicao = datetime.today().strftime('%Y-%m-%d') # pega a data que foi feita a requisição
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
        preco_atual = response.xpath('//*[@id="rsyswpsdk"]/div/main/div[2]/div[2]/div[1]/div[2]/div/text()').getall()
        time.sleep(1)
        preco_antigo = response.xpath('//*[@id="rsyswpsdk"]/div/main/div[2]/div[2]/div[1]/div[1]/span/text()').getall()
        time.sleep(1)

        preco_antigo_formatado = str(preco_antigo)
        preco_atual_formatado = str(preco_atual)

        if preco_antigo_formatado is '':
            preco_antigo_formatado = preco_atual_formatado

        preco_atual_formatado = preco_atual_formatado.replace('.', '').replace(',', '.').replace(' ', '').replace('R$', '').replace('[', '').replace(']', '').replace("'", '')
        preco_antigo_formatado = preco_antigo_formatado.replace('.', '').replace(',', '.').replace('de ', '').replace('R$ ', '').replace(' ', '').replace('[', '').replace(']', '').replace("'", '')

        imagem_iphone = response.xpath('//*[@id="rsyswpsdk"]/div/main/div[2]/div[1]/div[1]/div[2]/div/div[1]/div/picture/img/@src').getall()

        aux = 0
        for comentario in response.xpath('//div[contains(@class, "cQbOuE")]'):
            aux = aux + 1
            time.sleep(1)
            if aux == 1:
                descricao_comentario1 = comentario.css('span::text').get()
                time.sleep(1)
                data_do_comentario1 = comentario.css('div::text').getall()
                time.sleep(1)
                data_do_comentario_formatada1 = str(data_do_comentario1)
                data_do_comentario_formatada1 = data_do_comentario_formatada1[1:-22]
                data_do_comentario_formatada1 = data_do_comentario_formatada1.replace("'", '').replace(", ", " ")
            if aux == 2:
                descricao_comentario2 = comentario.css('span::text').get()
                time.sleep(1)
                data_do_comentario2 = comentario.css('div::text').getall()
                time.sleep(1)
                data_do_comentario_formatada2 = str(data_do_comentario2)
                data_do_comentario_formatada2 = data_do_comentario_formatada2[1:-22]
                data_do_comentario_formatada2 = data_do_comentario_formatada2.replace("'", '').replace(", ", " ")
            if aux == 3:
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

        nota_avaliacao = response.xpath('.//span[@class="header__RatingValue-sc-ibr017-9 jnVXpb"]/text()').get()
        time.sleep(1)

        caracteristica = response.xpath('.//td[@class="spec-drawer__Text-sc-jcvy3q-5 fMwSYd"]/text()').getall()
        time.sleep(1)

        for i in range(len(caracteristica)):
            j = i
            time.sleep(1)
            iphone = response.xpath('.//td[@class="spec-drawer__Text-sc-jcvy3q-5 fMwSYd"]/text()')[i].get()
            time.sleep(1)
            if (iphone == 'Modelo'):
                modelo = response.xpath('.//td[@class="spec-drawer__Text-sc-jcvy3q-5 fMwSYd"]/text()')[j + 1].get()
                time.sleep(1)
                j = i
            elif (iphone == 'Tamanho do Display'):
                tamanho_tela = response.xpath('.//td[@class="spec-drawer__Text-sc-jcvy3q-5 fMwSYd"]/text()')[j + 1].get()
                time.sleep(1)
                j = i
            elif (iphone == 'Resolução'):
                resolucao_tela = response.xpath('.//td[@class="spec-drawer__Text-sc-jcvy3q-5 fMwSYd"]/text()')[j + 1].get()
                time.sleep(1)
                j = i
            elif (iphone == 'Sistema Operacional'):
                sistema_operacional = response.xpath('.//td[@class="spec-drawer__Text-sc-jcvy3q-5 fMwSYd"]/text()')[
                    j + 1].get()
                time.sleep(1)
                j = i
            elif (iphone == 'Processador'):
                processador = response.xpath('.//td[@class="spec-drawer__Text-sc-jcvy3q-5 fMwSYd"]/text()')[j + 1].get()
                time.sleep(1)
                j = i
            elif (iphone == 'Tipo de Chip'):
                tipo_chip = response.xpath('.//td[@class="spec-drawer__Text-sc-jcvy3q-5 fMwSYd"]/text()')[j + 1].get()
                time.sleep(1)
                j = i
            elif (iphone == 'Peso liq. aproximado do produto (Kg)'):
                peso = response.xpath('.//td[@class="spec-drawer__Text-sc-jcvy3q-5 fMwSYd"]/text()')[j + 1].get()
                time.sleep(1)
                j = i
            elif (iphone == 'Cor'):
                cor = response.xpath('.//td[@class="spec-drawer__Text-sc-jcvy3q-5 fMwSYd"]/text()')[j + 1].get()
                time.sleep(1)
                j = i
            elif (iphone == 'Garantia do Fornecedor'):
                garantia = response.xpath('.//td[@class="spec-drawer__Text-sc-jcvy3q-5 fMwSYd"]/text()')[j + 1].get()
                time.sleep(1)
                j = i
            elif (iphone == 'Conteúdo da Embalagem'):
                itens_inclusos = response.xpath('.//td[@class="spec-drawer__Text-sc-jcvy3q-5 fMwSYd"]/text()')[j + 1].get()
                time.sleep(1)
                j = i
            elif (iphone == 'Alimentação, tipo de bateria'):
                bateria = response.xpath('.//td[@class="spec-drawer__Text-sc-jcvy3q-5 fMwSYd"]/text()')[j + 1].get()
                time.sleep(1)
                j = i
            elif (iphone == 'Conexões'):
                conectividade = response.xpath('.//td[@class="spec-drawer__Text-sc-jcvy3q-5 fMwSYd"]/text()')[j + 1].get()
                time.sleep(1)
                j = i
            elif (iphone == 'Dimensões do produto - cm (AxLxP)'):
                dimensao_produto = response.xpath('.//td[@class="spec-drawer__Text-sc-jcvy3q-5 fMwSYd"]/text()')[
                    j + 1].get()
                time.sleep(1)
                j = i
            elif (iphone == 'Câmera Traseira'):
                resolucao_camera_traseira = response.xpath('.//td[@class="spec-drawer__Text-sc-jcvy3q-5 fMwSYd"]/text()')[
                    j + 1].get()
                time.sleep(1)
                j = i
            elif (iphone == 'Câmera Frontal'):
                resolucao_camera_frontal = response.xpath('.//td[@class="spec-drawer__Text-sc-jcvy3q-5 fMwSYd"]/text()')[
                    j + 1].get()
                time.sleep(1)
                j = i
            elif (iphone == 'Memória Interna'):
                capacidade_armazenamento = response.xpath('.//td[@class="spec-drawer__Text-sc-jcvy3q-5 fMwSYd"]/text()')[
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
            'url_site': url_site,
            'imagem_iphone': imagem_iphone,
            'nome_site': nome_site,
            'nota_avaliacao': nota_avaliacao
        }
