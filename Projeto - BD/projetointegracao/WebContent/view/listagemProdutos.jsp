<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%@include file="../head.jsp"%>
<title>Lista de Produtos</title>

</head>
<body>
	<header>
		<nav class="menu">
			<div class="nav-wrapper">
				<br />
				<div style="margin-left: 60px" class="container">
					<i class="far fa-arrow-alt-circle-left"></i> 
					<a href="${pageContext.servletContext.contextPath}/" class="btn btn-secondary">Voltar</a>
					<a style="margin-left: 10px" href="${pageContext.servletContext.contextPath}/iphonesRegistrados" 
						class="btn btn-secondary">Visualizar iPhones Registrados</a>
					
				</div>				
			</div>
		</nav>
	</header>
	<br />
	<br />
	<div class="modal fade modal_excluir_iphone">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<h4 class="modal-title">Confirmação</h4>
					<button class="close" type="button" data-dismiss="modal">
						<span>&times;</span>
					</button>
				</div>
				<div class="modal-body">
					<p>Tem certeza de que deseja excluir este Iphone?</p>
				</div>
				<div class="modal-footer">
					<a class="btn btn-danger link_confirmacao_excluir_iphone" onclick="document.location.reload(true)">Sim</a>
					<button class="btn btn-primary" type="button" data-dismiss="modal">Não</button>
				</div>
			</div>
		</div>
	</div>
	<div class="container">
		<div class="col-12">
			<h1 style="text-align: center">Catálogo de iPhones</h1>
			<br>
			<form action="${pageContext.servletContext.contextPath}/procurarProduto" method="GET">
                <div class="row">
                    <input class="form-control col-6" style="height: 48px; margin-left: 250px; margin-right: 3rem"
                           type="text" name="titulo"
                           placeholder="Título do Iphone">
                    <button class="btn btn-lg btn-primary btn-block col-1" type="submit">Buscar</button>
                    
                </div>
            </form>
            <div class="container" style="display: flex; justify-content: center;">
	            <form action="${pageContext.servletContext.contextPath}/filtroPrecoCrescente" method="GET">
	            	<div class="col-6">
	            		<br/>
	            		<button style="height: 70px; width: 200px; " class="btn btn-lg btn-primary" type="submit"><i class="far fa-arrow-alt-circle-down"></i> Histórico de Menores Preços</button>
	            	</div>
	            </form>
	            <form action="${pageContext.servletContext.contextPath}/filtroPrecoDecrescente" method="GET">
	            	<div class="col-6">
	            		<br/>
	            		<button style="height: 70px; width: 200px; " class="btn btn-lg btn-primary" type="submit"><i class="far fa-arrow-alt-circle-up"></i> Histórico de Maiores Preços</button>
	            	</div>
	            </form>
	        </div>
            <br/>
			<div class="container" style="display: grid; grid-template-columns: 1fr 1fr 1fr;">
				<c:forEach var="iphone" items="${requestScope.iphoneList}">		
					<div class="col-4 mb-5">
						<div class="card" style="width: 20rem">
							<div class="container" style="display: flex; justify-content: space-between; margin: 10px;">
								<a class="link_editar_iphone"
									href="${pageContext.servletContext.contextPath}/atualizarProduto?id_iphone=${iphone.id_iphone}"
									data-toggle="tooltip"> 
									<i style="margin: 10px" class="fas fa-pen"></i>
								</a> 
								<a class="link_excluir_iphone"
									href="#"
									data-href="${pageContext.servletContext.contextPath}/deletarProduto?id_iphone=${iphone.id_iphone}"
									data-toggle="tooltip" 
									style="margin: 10px"> <i
									class="fas fa-trash"></i>
								</a> 
							</div>
							<a style="text-decoration: none; color: black;"
								href="${pageContext.servletContext.contextPath}/detalhesProduto?id_iphone=${iphone.id_iphone}">
								<div
									style="display: flex; flex-direction: column; justify-content: center; height: 17rem; background: white; padding: 25px; border-top-left-radius: 0.25rem; border-top-right-radius: 0.25rem;">
									<img class="card-img-top" src="${iphone.imagem_iphone}" >
								</div>
								<div class="card-body" style="background-color: #DDDAD5">
									<p class="card-text"><c:out value="${iphone.titulo}"/></p>
								</div>
 							</a> 
						</div>
					</div>
				</c:forEach>
			</div>
		</div>
	</div>
	<%@include file="../scripts.jsp"%>
</body>
</html>
