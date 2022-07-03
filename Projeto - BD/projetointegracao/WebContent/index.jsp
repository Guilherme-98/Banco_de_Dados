<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <%@include file="head.jsp"%>
        <title>Bem vindo</title>
    </head>
    <body>
        <div class="container">
			<div class="jumbotron">
				<h1 class="display-4">
					Bem-vindo
				</h1>
				<p class="lead">Selecione a opção de visualizar nossos produtos ou adicionar produtos</p>
				<hr class="my-4">
				<div class="row d-flex">
					<div class="col-md-3">
						<a class="btn btn-lg btn-primary" href="${pageContext.servletContext.contextPath}/produtos">
							Visualizar produtos
						</a>
					</div>
					<div class="col-md-3">
						<a class="btn btn-lg btn-secondary" href="${pageContext.servletContext.contextPath}/adicionarProduto">
							Adicionar produtos
						</a>
					</div>
				</div>
			</div>
		</div>
		
	    <%@include file="scripts.jsp"%>  
    </body>
</html>