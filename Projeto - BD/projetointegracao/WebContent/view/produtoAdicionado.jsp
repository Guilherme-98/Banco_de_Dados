<%@ page contentType="text/html;charset=UTF-8"%>
<html>
<head>
    <%@include file="../head.jsp" %>
    <title>Criação de produtos</title>
</head>
<body>
	<header>
		<nav class="menu">
			<div class="nav-wrapper">
				<br />
				<div style="margin-left: 60px" class="container">
					<i class="far fa-arrow-alt-circle-left"></i> 
					<a href="${pageContext.servletContext.contextPath}/" class="btn btn-secondary">Voltar</a>
				</div>
			</div>
		</nav>
	</header>
	<br />
	<br />
<div style="display: flex;height: 60vh;flex-direction: column;justify-content: center;" class="container">
    <form action="${pageContext.servletContext.contextPath}/adicionarProduto" method="POST">
        <h2>Selecione o arquivo JSON para inserir os iphones</h2>
        <div class="row">
            <input class="form-control col-6" style="height: 48px; margin-right: 2rem" type="file" name="fileName"
                   placeholder="Nome do arquivo.json" required autofocus>
            <button class="btn btn-lg btn-primary btn-block col-2" type="submit">Inserir</button>
        </div>
    </form>
</div>

<%@include file="../scripts.jsp" %>

</body>
</html>