<%@page import="java.util.List"%>
<%@page import="javax.security.auth.message.callback.PrivateKeyCallback.Request"%>
<%@page import="br.com.fatec.les.model.Usuario"%>
<%@page import="br.com.fatec.les.model.EntidadeDominio"%>
<%@page import="br.com.fatec.les.facade.Result"%>
<%@page import="java.util.ArrayList"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
		<title>Usu�rios</title>
		<style>
			td{
				margin: 5px 10px;
			}
		</style>
	</head>
	

	<body>	
			<ul>
			<c:forEach var="li" items="${mensagens}">
				<li><c:out value="${li}" /></li>
			</c:forEach>
		</ul>
		<table>
		<caption>Lista de usu�rios</caption>
			<theader>
				<tr>
					<th> Id </th>
					<th> Nome </th>
					<th> E-mail </th>
					<th> Telefone </th>
					<th> Documento </th>
					<th colspan="2"> A��o </th>
				</tr> 
			</theader>
			<tbody>
				<c:forEach var="li" items="${usuarios}">
			        <tr>
			            <td><c:out value="${li.getId()}" /></td>
			            <td><c:out value="${li.getNome()}" /></td>
			            <td><c:out value="${li.getEmail()}" /></td>
			            <td><c:out value="${li.getNumeroTelefone()}" /></td>
			            <td><c:out value="${li.getNumeroDocumento()}" /></td>
			            <td>
			            	<form action="usuario" method="GET">
			            		<input type="hidden" name="txtId" value="${li.getId()}">
			            		<input type="hidden" name="tarefa" value="editaUsuario">
			            		<input type="submit" value="EDITAR" >
			            	</form>
			            </td>
			            <td>
			            	<form action="usuario" method="GET">
			            		<input type="hidden" name="txtId" value="${li.getId()}">
			            		<input type="hidden" name="tarefa" value="deletarUsuario">
			            		<input type="submit" value="EXCLUIR" >
			            	</form>
			            </td>
				     </tr>
				</c:forEach>
			</tbody>
		</table>		
	</body>
</html>