<%@page import="java.util.List"%>
<%@page import="javax.security.auth.message.callback.PrivateKeyCallback.Request"%>
<%@page import="br.com.fatec.les.model.Usuario"%>
<%@page import="br.com.fatec.les.model.EntidadeDominio"%>
<%@page import="br.com.fatec.les.facade.Result"%>
<%@page import="java.util.ArrayList"%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="pt">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta http-equiv="x-ua-compatible" content="ie=edge">
    <title>Material Design for Bootstrap</title>
    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.11.2/css/all.css">
    <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Roboto:300,400,500,700&display=swap">
    <link rel="stylesheet" href="./css/bootstrap.min.css">
    <link rel="stylesheet" href="./css/mdb.min.css">
</head>

<body>
    <header style="background: rgba(0,0,0,0.8);">
        <nav class="navbar navbar-expand-lg navbar-dark bg-transparent shadow-none scrolling-navbar">
            <div class="container">
                <a class="navbar-brand mx-auto font-weight-bold" href="index.html">SCHOOLSTORE</a>
            </div>
        </nav>
    </header>

    <main>
        <section class="py-5 px-2">
            <div class="container mt-5 dark-grey-text">
                <h1 class="text-center">CADASTRO DE USU�RIO</h1>
                <hr>
                <section>
                    <form class="needs-validation" method="post" action="cliente" novalidate>
                        <div class="row justify-content-center">
                            <div class="col-md-10">
                                <h2 class="mt-5">1. Informa��es Gerais</h2>
                                <div class="form-row">
                                    <div class="col mb-3 md-form">
                                        <label for="txtNome">Nome Completo*</label>
                                        <input type="text" class="form-control" id="txtNome" name="txtNome" required maxlength="100"
                                            minlength="3">
                                        <div class="valid-feedback">
                                            Bonito nome!
                                        </div>
                                        <div class="invalid-feedback">
                                            Campo inv�lido
                                        </div>
                                    </div>
                                    <div class="col mb-3 md-form">
                                        <label for="txtEmail">E-mail*</label>
                                        <input type="email" class="form-control" id="txtEmail" name="txtEmail" required
                                            maxlength="100">
                                        <div class="valid-feedback">
                                            E-mail v�lido!
                                        </div>
                                        <div class="invalid-feedback">
                                            Campo inv�lido
                                        </div>
                                    </div>
                                </div>
                                <div class="form-row">
                                    <div class="col mb-3 md-form">
                                        <label for="txtNumeroDocumento">CPF/CNPJ*</label>
                                        <input type="text" class="form-control" name="txtNumeroDocumento"
                                            id="txtNumeroDocumento" required maxlength="14">
                                        <div class="valid-feedback">
                                            Documento v�lido!
                                        </div>
                                        <div class="invalid-feedback">
                                            Campo inv�lido
                                        </div>
                                    </div>
                                    <div class="col mb-3 md-form">
                                        <label for="txtNumeroTelefone">N�mero de Telefone*</label>
                                        <input type="text" class="form-control" name="txtNumeroTelefone"
                                            id="txtNumeroTelefone" required maxlength="12">
                                        <div class="valid-feedback">
                                            N�mero de telefone v�lido!
                                        </div>
                                        <div class="invalid-feedback">
                                            Campo inv�lido
                                        </div>
                                    </div>
                                </div>
                                <div class="form-row">
                                    <div class="col mb-3 md-form">
                                        <label for="txtSenha">Senha*</label>
                                        <input type="password" maxlength="100" class="form-control" name="txtSenha" id="txtSenha" required>
                                        <div class="valid-feedback">
                                            Senha v�lida!
                                        </div>
                                        <div class="invalid-feedback">
                                            Campo inv�lido
                                        </div>
                                    </div>
                                    <div class="col mb-3 md-form">
                                        <label for="txtConfirmacaoSenha">Confirma��o de Senha*</label>
                                        <input type="password" maxlength="100" class="form-control" id="txtConfirmacaoSenha" required>
                                        <div class="valid-feedback">
                                            Confirma��o de senha v�lida!
                                        </div>
                                        <div class="invalid-feedback">
                                            Campo inv�lido
                                        </div>
                                    </div>
                                </div>
                                <div class="file-field md-form">
                                    <div class="btn btn-primary btn-sm float-left">
                                        <span>Procurar</span>
                                        <input type="file" id="file">
                                    </div>
                                    <div class="file-path-wrapper">
                                        <input class="file-path validate" type="text"
                                            placeholder="Escolha uma imagem de perfil">
                                        <input type="hidden" id="base64" name="txtFile">
                                    </div>
                                </div>
                            </div>
                        </div>

                        <div class="row justify-content-center">
                            <div class="col-md-10">
                                <div class="row mt-5 align-items-center">
                                    <h2 class="">2. Endere�os</h2>
                                    <a href="#" class="btn btn-link btn-rounded p-2 mb-2" data-toggle="modal"
                                        data-target="#modalEndereco">
                                        <i class="fas fa-plus "></i>
                                    </a>
                                </div>
                                <div class="accordion md-accordion" id="accordionEndereco" role="tablist"
                                    aria-multiselectable="true">

                                </div>
                            </div>
                        </div>

                        <div class="row justify-content-center">
                            <div class="col-md-10">
                                <div class="row mt-5 align-items-center">
                                    <h2 class="">3. Cart�es de cr�dito</h2>
                                    <a href="" class="btn btn-link btn-rounded p-2 mb-2" data-toggle="modal"
                                        data-target="#modalCartao">
                                        <i class="fas fa-plus "></i>
                                    </a>
                                </div>
                                <div class="accordion md-accordion" id="accordionCartao" role="tablist"
                                    aria-multiselectable="true">

                                </div>
                            </div>
                        </div>

                        <div class="row mt-5 text-center">
                            <div class="col-md-12">
                                <div class="form-group mt-3">
                                    <div class="form-check pl-0">
                                        <input class="form-check-input" type="checkbox" value="" id="invalidCheck2"
                                            required>
                                        <label class="form-check-label" for="invalidCheck2">
                                            Li e concordo com os termos de uso
                                        </label>
                                        <div class="invalid-feedback">
                                            � necess�rio concordar com os termos de uso
                                        </div>
                                    </div>
                                </div>
                                <input type="hidden" name="tarefa" value="cadastrarCliente"/>
                                <button class="btn btn-success btn-lg btn-rounded" type="submit">Cadastrar</button>
                            </div>
                        </div>
                    </form>
                </section>
            </div>
        </section>
    </main>

    <div class="modal fade" id="modalEndereco" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header text-center">
                    <h4 class="modal-title w-100 font-weight-bold">Novo Endere�o</h4>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body mx-3">
                    <div class="form-row">
                        <div class="col-md-4 mb-3 md-form">
                            <label for="txtCepModal">CEP</label>
                            <input type="text" class="form-control" id="txtCepModal" required maxlength="9">
                        </div>
                        <div class="col-md-8 mb-3 md-form">
                            <label for="txtLogradouroModal">Logradouro</label>
                            <input type="text" class="form-control" id="txtLogradouroModal" required maxlength="100">
                        </div>
                    </div>
                    <div class="form-row">
                        <div class="col-md-6 mb-3 md-form">
                            <select class="mdb-select" id="txtEstadoModal" required searchable="Selecione..">
                                <option value="" disabled selected>Selecione seu estado</option>
                                <c:forEach var="estado" items="${estados}">
									<option value="${estado.getId()}">${ estado.getNome() }</option>
								</c:forEach>
                            </select>
                        </div>
                        <div class="col-md-6 mb-3 md-form">
                            <select id="txtCidadeModal" required placeholder="Selecione">
                                <option value="" disabled selected>Selecione sua cidade</option>
							    <c:forEach var="estado" items="${estados}">
							     	<c:forEach var="cidade" items="${estado.getCidades()}">
							       		<option value="${cidade.getId()}" class="${cidade.getEstado().getId()}">${ cidade.getNome() }</option>
						        	</c:forEach>
						        </c:forEach>
                            </select>
                        </div>
                    </div>
                    <div class="form-row">
                        <div class="col-md-4 mb-3 md-form">
                            <label for="txtNumeroModal">N�mero</label>
                            <input type="number" min="1" max="9999" maxlength="4" class="form-control" id="txtNumeroModal" required>
                        </div>
                        <div class="col-md-4 mb-3 md-form">
                            <label for="txtBairroModal">Bairro</label>
                            <input type="text" class="form-control"
                                id="txtBairroModal" required maxlength="100">
                        </div>
                        <div class="col-md-4 mb-3 md-form">
                            <label for="txtComplementoModal">Complemento</label>
                            <input type="text" maxlength="100"
                                class="form-control"
                                id="txtComplementoModal" required>
                        </div>
                    </div>
                    <div class="form-row">
                        <div class="col mb-3 md-form">
                            <label for="txtReferenciaModal">Refer�ncia</label>
                            <input type="text" class="form-control" id="txtReferenciaModal" required maxlength="100">
                        </div>
                    </div>
                    <div class="form-row">
                        <div class="col mb-3 md-form">
                            <input class="form-check-input" type="checkbox" value="false" id="txtFavoritoModal">
                            <label class="form-check-label" for="txtFavoritoModal">
                                Marcar como favorito
                            </label>
                        </div>
                    </div>
                </div>
                <div class="modal-footer d-flex justify-content-center">
                    <button class="btn btn-unique" id="btnSalvarEndereco">Adicionar <i class="fas fa-paper-plane-o ml-1"></i></button>
                </div>
            </div>
        </div>
    </div>

    <div class="modal fade" id="modalCartao" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header text-center">
                    <h4 class="modal-title w-100 font-weight-bold">Novo cart�o de cr�dito</h4>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body mx-3">
                    <div class="form-row">
                        <div class="col mb-3 md-form">
                            <label for="txtNomeImpressoModal">Nome Impresso*</label>
                            <input type="text" class="form-control" id="txtNomeImpressoModal" required maxlength="100">
                        </div>
                    </div>
                    <div class="form-row">
                        <div class="col-md-8 mb-3 md-form">
                            <label for="txtNumeroCartaoModal">N�mero*</label>
                            <input type="text" maxlength="16" class="form-control" id="txtNumeroCartaoModal" required>
                        </div>
                        <div class="col-md-4 mb-3 md-form">
                            <label for="txtCodigoModal">C�digo*</label>
                            <input type="text" class="form-control" id="txtCodigoModal" required maxlength="3">
                        </div>
                    </div>
                    <div class="form-row">
                        <div class="col mb-3 md-form">
                            <input class="form-check-input" type="checkbox" value="false" id="txtFavoritoCartaoModal">
                            <label class="form-check-label" for="txtFavoritoCartaoModal">
                                Marcar como favorito
                            </label>
                        </div>
                    </div>
                </div>
                <div class="modal-footer d-flex justify-content-center">
                    <button class="btn btn-unique" id="btnSalvarCartao">Adicionar <i class="fas fa-paper-plane-o ml-1"></i></button>
                </div>
            </div>
        </div>
    </div>

    <script type="text/javascript" src="./js/jquery.min.js"></script>
    <script type="text/javascript" src="./js/popper.min.js"></script>
    <script type="text/javascript" src="./js/bootstrap.min.js"></script>
    <script type="text/javascript" src="./js/mdb.min.js"></script>
    <script type="text/javascript" src="./js/pages/register.js"></script>

</body>

</html>