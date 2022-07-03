<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8">
	<%@include file="../head.jsp"%>
	<script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
	<script type="text/javascript">
		google.charts.load('current', {'packages':['corechart']});
	    google.charts.setOnLoadCallback(drawChartAmericanas);
	    google.charts.setOnLoadCallback(drawChartSubmarino);
	    google.charts.setOnLoadCallback(drawChartShoptime);
	    google.charts.setOnLoadCallback(drawChartGeral);
	    
	    var datasAmericanas = new Array()
	    var datasSubmarino = new Array()
	    var datasShoptime = new Array()
	    var datasGerais = new Array()
	    var auxAmericanas = '${datasAmericanas}'
	    var auxSubmarino = '${datasSubmarino}'
	    var auxShoptime = '${datasShoptime}'
	    var auxDatasGerais = '${datasGerais}'
	    
	    var dataFormatadaAmericanas = auxAmericanas.slice(1, -1)
	    var dataFormatadaSubmarino = auxSubmarino.slice(1, -1)
	    var dataFormatadaShoptime = auxShoptime.slice(1, -1)
	    var datasGeraisFormatadas = auxDatasGerais.slice(1, -1)
	    
	    datasAmericanas = dataFormatadaAmericanas.split(",")
	    datasSubmarino = dataFormatadaSubmarino.split(",")
	    datasShoptime = dataFormatadaShoptime.split(",")
	    datasGerais = datasGeraisFormatadas.split(",")
	    
	    var precosGerais = ${precosGerais}
	    var precosAntigos = ${precosAntigos}
	    var precosAtuaisSubmarino = ${precosAtuaisSubmarino}
	    var precosAtuaisShoptime = ${precosAtuaisShoptime}
	    var precosAtuaisAmericanas = ${precosAtuaisAmericanas}
	    function drawChartAmericanas() {
	    	var dataArray = [
                ['Data', 'Americanas'],
            ];

            for (var i = 0; i < datasAmericanas.length; i++) {
            	var row = [new Date(datasAmericanas[i]), precosAtuaisAmericanas[i]];
               	dataArray.push(row);
                
            }
	      	var data = google.visualization.arrayToDataTable(dataArray)
		    	
	      	var options = {
		        title: 'Histórico de Preços do Iphone - Site Americanas',
		       
		        hAxis: { 
		        	format: 'YYYY-MM-dd',
		        },
		        
		        legend: { position: 'bottom' },
		        
	      	};
	
	      var chart = new google.visualization.LineChart(document.getElementById('americanas_chart'));
	      chart.draw(data, options);
    	}
	    
	    function drawChartSubmarino() {
	    	var dataArray = [
                ['Data', 'Submarino'],
            ];

            for (var i = 0; i < datasSubmarino.length; i++) {
            	var row = [new Date(datasSubmarino[i]), precosAtuaisSubmarino[i]];
               	dataArray.push(row);
                
            }
	      	var data = google.visualization.arrayToDataTable(dataArray)
		    	
	      	var options = {
		        title: 'Histórico de Preços do Iphone - Site Submarino',
		       
		        hAxis: { 
		        	format: 'YYYY-MM-dd',
		        },
		        
		        legend: { position: 'bottom' },
		        
	      	};
	
	      var chart = new google.visualization.LineChart(document.getElementById('submarino_chart'));
	      chart.draw(data, options);
    	}
	    
	    function drawChartShoptime() {
	    	var dataArray = [
                ['Data', 'Shoptime'],
            ];

            for (var i = 0; i < datasShoptime.length; i++) {
            	var row = [new Date(datasShoptime[i]), precosAtuaisShoptime[i]];
               	dataArray.push(row);
                
            }
	      	var data = google.visualization.arrayToDataTable(dataArray)
		    	
	      	var options = {
		        title: 'Histórico de Preços do Iphone - Site Shoptime',
		       
		        hAxis: { 
		        	format: 'YYYY-MM-dd',
		        },
		        
		        legend: { position: 'bottom' },
		        
	      	};
	
	      var chart = new google.visualization.LineChart(document.getElementById('shoptime_chart'));
	      chart.draw(data, options);
    	}
	    
	    function drawChartGeral() {
	    	var dataArray = [
                ['Data', 'Preços'],
            ];

            for (var i = 0; i < datasGerais.length; i++) {
            	var row = [new Date(datasGerais[i]), precosGerais[i]];
               	dataArray.push(row);
                
            }
	      	var data = google.visualization.arrayToDataTable(dataArray)
		    	
	      	var options = {
		        title: 'Histórico Geral de Preços do Iphone',
		       
		        hAxis: { 
		        	format: 'YYYY-MM-dd',
		        },
		        
		        legend: { position: 'bottom' },
		        
	      	};
	      	
	      	var chart = new google.visualization.LineChart(document.getElementById('geral_chart'));
		    chart.draw(data, options);
	    }
	</script>
	
	<script type="text/javascript">
	google.charts.load('current', {packages: ['corechart', 'bar']});
	google.charts.setOnLoadCallback(drawBasic);
	function drawBasic() {

		var nota = ${mediaAvaliacao}
		var data = google.visualization.arrayToDataTable([
	          ['Título', 'Nota'],
	          ['${iphone.titulo}', nota]
	        ]);

	        var options = {
	          	chart: {
	            	title: 'Nota do iPhone',
	          	},
	          	
	          bars: 'vertical' 
	        };
	        
	      var chart = new google.visualization.ColumnChart(
	        document.getElementById('chart_div'));

	      chart.draw(data, options);
	   }
	</script>
	
</head>
<body>
	
	<div class="container"
		style="background-color: #EAE7E2; padding-top: 200px; display: flex; border-radius: 5px">
		<div class="col-5">
			<h1 style="justify-content: center; margin-top: -130px">Detalhes
				do Produto</h1>
			<div class="col-4 mb-5">
				<a style="margin-bottom: 40px" href="${pageContext.servletContext.contextPath}/produtos"
					class="btn btn-secondary">Voltar</a>
				<div class="card" style="width: 20rem; border-radius: 10px">
					<div
						style="display: flex; flex-direction: column; justify-content: center; background-color: white; height: 17rem; padding: 25px; border-top-left-radius: 0.25rem; border-top-right-radius: 0.25rem;">
						<img class="card-img-top" src="${iphone.imagem_iphone}" />
					</div>
					<div class="card-body" style="background-color: #DDDAD5">
						<p class="card-text"><c:out value="${iphone.titulo}"/></p>
						<hr class="my-4">
						<p>
							Fornecedor: <span class="card-text"><c:out value="${site.nome_site}"/></span>
						</p>
						<a href="${site.url_site}">Link do produto</a>
					</div>
				</div>
			</div>
		</div>
		<div class="col-7">
			<table class="container">
				<tbody>
					<tr>
						<td>Modelo</td>
						<td><span><c:out value="${iphone.modelo}"/></span></td>
					</tr>
					<tr>
						<td>Sistema Operacional</td>
						<td><span><c:out value="${iphone.sistema_operacional}"/></span></td>
					</tr>
					<tr>
						<td>Cor</td>
						<td><span><c:out value="${iphone.cor}"/></span></td>
					</tr>
					<tr>
						<td>Processador</td>
						<td><span><c:out value="${iphone.processador}"/></span></td>
					</tr>
					<tr>
						<td>Tipo de Chip</td>
						<td><span><c:out value="${iphone.tipo_chip}"/></span></td>
					</tr>
					<tr>
						<td>Conectividade</td>
						<td><span><c:out value="${iphone.conectividade}"/></span></td>
					</tr>
					<tr>
						<td>Bateria</td>
						<td><span><c:out value="${iphone.bateria}"/></span></td>
					</tr>
					<tr>
						<td>Peso</td>
						<td><span><c:out value="${iphone.peso}"/></span></td>
					</tr>
					<tr>
						<td>Dimensão do Produto</td>
						<td><span><c:out value="${iphone.dimensao_produto}"/></span></td>
					</tr>
					<tr>
						<td>Resolução da Tela</td>
						<td><span><c:out value="${iphone.resolucao_tela}"/></span></td>
					</tr>
					<tr>
						<td>Tamanho da Tela</td>
						<td><span><c:out value="${iphone.tamanho_tela}"/></span></td>
					</tr>
					<tr>
						<td>Itens Inclusos</td>
						<td><span><c:out value="${iphone.itens_inclusos}"/></span></td>
					</tr>
					<tr>
						<td>Garantia</td>
						<td><span><c:out value="${iphone.garantia}"/></span></td>
					</tr>
					<tr>
						<td>Resolução da câmera</td>
						<td><span><c:out value="${camera.resolucao_camera}"/></span></td>
					</tr>
					<tr>
						<td>Armazenamento</td>
						<td><span><c:out value="${armazenamento.capacidade_armazenamento}"/></span></td>
					</tr>
					<tr>
						<td>Comentário</td>
						<td><span><c:out value="${comentario.data_do_comentario1}. ${comentario.descricao_comentario1}"/></span></td>
						 
					</tr>
					<tr>
						<td>Comentário</td>
						<td><span><c:out value="${comentario.data_do_comentario2}. ${comentario.descricao_comentario2}"/></span></td>
						 
					</tr>
					<tr>
						<td>Comentário</td>
						<td><span><c:out value="${comentario.data_do_comentario3}. ${comentario.descricao_comentario3}"/></span></td>
						 
					</tr>
				</tbody>
			</table>
			<br /> <br /> <br /> <br />
		</div>
	</div>
	<hr class="my-4">
	<div class="container"
		style="background-color: #EAE7E2; padding-bottom: 200px; display: flex; border-radius: 5px">
		<div class="col-12" style="flex-direction: column">
			<h1 style="text-align: center; padding-bottom: 50px">Histórico de Preços</h1>
			<div id="americanas_chart" class="container" style="width: 1000px; height: 700px"></div>
			<br/>
			<div id="submarino_chart" class="container" style="width: 1000px; height: 700px"></div>
			<br/>
			<div id="shoptime_chart" class="container" style="width: 1000px; height: 700px"></div>
			<br/>
			<div id="geral_chart" class="container" style="width: 1000px; height: 700px"></div>
			<br/>
			<h1 style="text-align: center; padding-bottom: 50px">Nota</h1>
			<div id="chart_div" class="container" style="width: 1000px; height: 700px"></div>
		</div>
		 
	</div>		
	<%@include file="../scripts.jsp"%>
</body>
<style>
table {
	border-collapse: collapse;
	width: 100%;
}

td, th {
	border: 1px solid #dddddd;
	text-align: left;
	padding: 8px;
}

tr:nth-child(even) {
	background-color: #dddddd;
}
</style>
