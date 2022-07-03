<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<%@include file="../head.jsp"%>
</head>
<body>
	<div class="container"
		style="background-color: #EAE7E2; padding-top: 200px; display: flex; border-radius: 5px">
		<div class="col-5">
			<h1 style="justify-content: center; margin-top: -130px">Edição
				do Produto</h1>
			<form class="form"
				action="${pageContext.servletContext.contextPath}/atualizarProduto"
				method="POST">
				<div class="col-4 mb-5">
					<a style="margin-bottom: 40px"
						href="${pageContext.servletContext.contextPath}/produtos"
						class="btn btn-secondary">Voltar</a>
						<input type="hidden" name="id_iphone" value="${iphone.id_iphone}">
						<input type="hidden" name="id_armazenamento" value="${armazenamento.id_armazenamento}">
						<input type="hidden" name="id_camera" value="${camera.id_camera}">
					<div class="card" style="width: 20rem; border-radius: 10px">
						<div
							style="display: flex; flex-direction: column; justify-content: center; background-color: white; height: 17rem; padding: 25px; border-top-left-radius: 0.25rem; border-top-right-radius: 0.25rem;">
							<img class="card-img-top" src="${iphone.imagem_iphone}" />
						</div>
						<div class="card-body" style="background-color: #DDDAD5; width: 745px">
							<p class="card-text"  >
								<label class="control-label">Título</label>
								<input class="form-control" name="titulo" type="text" value="${iphone.titulo}" />
							</p>
						
						</div>
					</div>
				</div>
				<div class="col-7">
					<table class="container">
						<tbody>
							<tr>
								<td>Modelo</td>
								<td><input style="width: 600px" class="form-control" name="modelo" type="text" value="${iphone.modelo}" /></td>
							</tr>
							<tr>
								<td>Sistema Operacional</td>
								<td><span><input class="form-control" name="sistema_operacional" type="text"
											value="${iphone.sistema_operacional}" /></span></td>
							</tr>
							<tr>
								<td>Cor</td>
								<td><span><input class="form-control" name="cor" type="text" value="${iphone.cor}" /></span></td>
							</tr>
							<tr>
								<td>Processador</td>
								<td><span><input class="form-control" name="processador" type="text" value="${iphone.processador}" /></span></td>
							</tr>
							<tr>
								<td>Tipo de Chip</td>
								<td><span><input class="form-control" name="tipo_chip" type="text" value="${iphone.tipo_chip}" /></span></td>
							</tr>
							<tr>
								<td>Conectividade</td>
								<td><span><input class="form-control" name="conectividade" type="text" value="${iphone.conectividade}" /></span></td>
							</tr>
							<tr>
								<td>Bateria</td>
								<td><span><input pattern="/^[a-zA-Z_0-9@\!#\$\^%&*()+=\-[]\\\';,\.\/\{\}\|\:<>\? ]+$/" class="form-control" name="bateria" type="text" value="${iphone.bateria}" /></span></td>
							</tr>
							<tr>
								<td>Peso</td>
								<td><span><input class="form-control" name="peso" type="text" value="${iphone.peso}" /></span></td>
							</tr>
							<tr>
								<td>Dimensão do Produto</td>
								<td><span><input class="form-control" name="dimensao_produto" type="text" value="${iphone.dimensao_produto}" /></span></td>
							</tr>
							<tr>
								<td>Resolução da Tela</td>
								<td><span><input class="form-control" name="resolucao_tela" type="text" value="${iphone.resolucao_tela}" /></span></td>
							</tr>
							<tr>
								<td>Tamanho da Tela</td>
								<td><span><input class="form-control" name="tamanho_tela" type="text" value="${iphone.tamanho_tela}" /></span></td>
							</tr>
							<tr>
								<td>Itens Inclusos</td>
								<td><span><input pattern="/^[a-zA-Z_0-9@\!#\$\^%&*()+=\-[]\\\';,\.\/\{\}\|\:<>\? ]+$/" class="form-control" name="itens_inclusos" type="text" value="${iphone.itens_inclusos}" /></span></td>
							</tr>
							<tr>
								<td>Garantia</td>
								<td><span><input class="form-control" name="garantia" type="text" value="${iphone.garantia}" /></span></td>
							</tr>
							<tr>
								<td>Resolução da câmera</td>
								<td><span><input class="form-control" name="resolucao_camera" type="text" value="${camera.resolucao_camera}" /></span></td>
							</tr>
							<tr>
								<td>Armazenamento</td>
								<td><span><input class="form-control" name="capacidade_armazenamento" type="text"
											value="${armazenamento.capacidade_armazenamento}" /></span></td>
							</tr>
							
						</tbody>
					</table>
					<br/>
					<button style="text-align: center" class="btn btn-lg btn-primary" type="submit">Salvar</button>
					<br /> <br /> <br /> <br />
				</div>
			</form>
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
