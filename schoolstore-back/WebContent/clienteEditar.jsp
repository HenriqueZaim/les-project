<%@page import="java.util.List"%>
<%@page import="javax.security.auth.message.callback.PrivateKeyCallback.Request"%>
<%@page import="br.com.fatec.les.model.usuario.Usuario"%>
<%@page import="br.com.fatec.les.model.assets.EntidadeDominio"%>
<%@page import="br.com.fatec.les.facade.Resultado"%>
<%@page import="java.util.ArrayList"%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml" lang="pt-br" xml:lang="pt-br">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta http-equiv="x-ua-compatible" content="ie=edge">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
    
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
                <h1 class="text-center">Editar Perfil</h1>
				<c:forEach var="mensagem" items="${resultado.getMensagens()}">
	                <div class="alert alert-danger" role="alert">
	            		<span>${mensagem.getMensagem()}</span>
	            	</div>
            	</c:forEach>
                <hr>
                <section>
                    <form id="clienteFormulario" method="post" action="app">
                        <input name="txtClienteId" type="hidden" value="${cliente.getId()}">
                        <input name="txtUsuarioId" type="hidden" value="${cliente.getUsuario().getId()}">
                        <input name="txtImagemId" type="hidden" value="${cliente.getUsuario().getImagem().getId()}">
                        
                        <div class="row justify-content-center">
                            <div class="col-md-10">
                                <h2 class="mt-5">1. Informações Gerais</h2>
                                <div class="form-row">
                                    <div class="col mb-3 md-form">
                                        <label for="txtNome" class="active">Nome Completo*</label>
                                        <input type="text" class="form-control" value="${cliente.getNome()}" id="txtNome" name="txtNome" required maxlength="100"
                                            minlength="3">
                                        <div class="valid-feedback">
                                            Bonito nome!
                                        </div>
                                        <div class="invalid-feedback">
                                            Campo inválido
                                        </div>
                                    </div>
                                    <div class="col mb-3 md-form">
                                        <label for="txtEmail" class="active">E-mail*</label>
                                        <input type="email" class="form-control" id="txtEmail" value="${cliente.getUsuario().getEmail()}" name="txtEmail" required
                                            maxlength="100">
                                        <div class="valid-feedback">
                                            E-mail válido!
                                        </div>
                                        <div class="invalid-feedback">
                                            Campo inválido
                                        </div>
                                    </div>
                                </div>
                                <div class="form-row">
                                    <div class="col mb-3 md-form">
                                        <label for="txtNumeroDocumento" class="active">CPF/CNPJ*</label>
                                        <input type="text" class="form-control" value="${cliente.getNumeroDocumento()}" name="txtNumeroDocumento"
                                            id="txtNumeroDocumento" required maxlength="14">
                                        <div class="valid-feedback">
                                            Documento válido!
                                        </div>
                                        <div class="invalid-feedback">
                                            Campo inválido
                                        </div>
                                    </div>
                                    <div class="col mb-3 md-form">
                                        <label for="txtNumeroTelefone" class="active">Número de Telefone*</label>
                                        <input type="text" class="form-control" value="${cliente.getNumeroTelefone()}" name="txtNumeroTelefone"
                                            id="txtNumeroTelefone" required maxlength="12">
                                        <div class="valid-feedback">
                                            Número de telefone válido!
                                        </div>
                                        <div class="invalid-feedback">
                                            Campo inválido
                                        </div>
                                    </div>
                                </div>
                                <div class="file-field md-form">
                                    <div class="btn btn-primary btn-sm float-left">
                                        <span>Procurar</span>
                                        <input type="file" id="file" >
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
                                    <h2 class="">2. Endereços</h2>
                                    <a href="#" class="btn btn-link btn-rounded p-2 mb-2" data-toggle="modal"
                                        data-target="#modalEndereco">
                                        <i class="fas fa-plus "></i>
                                    </a>
                                </div>
                                <div class="accordion md-accordion" id="accordionEndereco" role="tablist"
                                    aria-multiselectable="true">
                                    <c:forEach var="endereco" items="${cliente.getEnderecos()}">
                                        <div class="card">
                                            <div class="card-header" role="tab" id="${endereco.getId()}">
                                                <h5 class="mb-0">
                                                    ${endereco.getNome()}
                                                    <a data-toggle="collapse" data-parent="#accordionEndereco" href="#${endereco.getCep()}-${endereco.getId()}" aria-expanded="false" aria-controls="${endereco.getCep()}-${endereco.getId()}">
                                                        <i class="fas fa-angle-down rotate-icon"></i>
                                                    </a>
                                                    <button onclick="$(this).parent().parent().parent().remove()" class="btn btn-link p-0 m-0 float-right mr-5">
                                                        <i class="fas fa-times text-danger"></i>
                                                    </button>
                                                </h5>
                                            </div>
                                            <div id="${endereco.getCep()}-${endereco.getId()}" class="collapse show" role="tabpanel" aria-labelledby="${endereco.getId()}" data-parent="#accordionEndereco">
                                                <div class="card-body">
                                                    <ul>
                                                      <li><b>CEP: </b>${endereco.getCep()}</li>
                                                      <li><b>Estado: </b>${endereco.getCidade().getEstado().getNome()}</li>
                                                      <li><b>Cidade: </b>${endereco.getCidade().getNome()}</li>
                                                      <li><b>Logradouro: </b>${endereco.getLogradouro()}</li>
                                                      <li><b>Número: </b>${endereco.getNumero()}</li>
                                                      <li><b>Bairro: </b>${endereco.getBairro()}</li>
                                                      <li><b>Complemento: </b>${endereco.getComplemento() == null ? "Nenhum" : endereco.getComplemento()}</li>
                                                      <li><b>Referência: </b>${endereco.getReferencia() == null ? "Nenhum" : endereco.getReferencia()}</li>
                                                      <li><b>Favorito: </b>${endereco.isFavorito() ? "sim" : "não"}</li>
                                                    </ul>
                                                </div>
                                            </div>
                                 
											<input type="hidden" name="txtEndereco" value="true">
                                  			<input type="hidden" name="txtEnderecoId" value="${endereco.getId()}">
                                            <input type="hidden" name="txtCep" value="${endereco.getCep()}">
                                            <input type="hidden" name="txtBairro" value="${endereco.getBairro()}">
                                            <input type="hidden" name="txtLogradouro" value="${endereco.getLogradouro()}">
                                            <input type="hidden" name="txtCidadeId" value="${endereco.getCidade().getId()}">
                                            <input type="hidden" name="txtReferencia" value="${endereco.getReferencia()}">
                                            <input type="hidden" name="txtComplemento" value="${endereco.getComplemento()}">
                                            <input type="hidden" name="txtNumero" value="${endereco.getNumero()}">
                                            <input type="hidden" name="txtFavoritoEndereco" value="${endereco.isFavorito()}"> 
                                        	<input type="hidden" name="txtNomeEndereco" value="${endereco.getNome() }">
                                        </div>                                    
                                    </c:forEach>
                                </div>
                            </div>
                        </div>

                        <div class="row justify-content-center">
                            <div class="col-md-10">
                                <div class="row mt-5 align-items-center">
                                    <h2 class="">3. Cartões de crédito</h2>
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
                                <input type="hidden" name="tarefa" value="atualizarCliente"/>
                                <button class="btn btn-warning btn-lg btn-rounded" type="submit">Editar Cadastro</button>
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
                    <h4 class="modal-title w-100 font-weight-bold">Novo Endereço</h4>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body mx-3">
                    <div class="form-row">
                        <div class="col-md-4 mb-3 md-form">
                            <label for="txtCepModal">CEP*</label>
                            <input type="text" class="form-control" id="txtCepModal" required maxlength="9">
                        </div>
                        <div class="col-md-8 mb-3 md-form">
                            <label for="txtLogradouroModal">Logradouro*</label>
                            <input type="text" class="form-control" id="txtLogradouroModal" required maxlength="100">
                        </div>
                    </div>
                    <div class="form-row">
                        <div class="col-md-6 mb-3 md-form">
                            <select class="mdb-select" id="txtEstadoModal" required searchable="Selecione..">
                                <option value="" disabled selected>Selecione seu estado*</option>
                                <c:forEach var="estado" items="${estados}">
									<option value="${estado.getId()}">${ estado.getNome() }</option>
								</c:forEach>
                            </select>
                        </div>
                        <div class="col-md-6 mb-3 md-form">
                            <select id="txtCidadeModal" required placeholder="Selecione">
                                <option value="" disabled selected>Selecione sua cidade*</option>
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
                            <label for="txtNumeroModal">Número*</label>
                            <input type="number" min="1" max="9999" maxlength="4" class="form-control" id="txtNumeroModal" required>
                        </div>
                        <div class="col-md-4 mb-3 md-form">
                            <label for="txtBairroModal">Bairro*</label>
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
                            <label for="txtReferenciaModal">Referência</label>
                            <input type="text" class="form-control" id="txtReferenciaModal" required maxlength="100">
                        </div>
                    </div>
                    <div class="form-row">
                        <div class="col mb-3 md-form">
                            <label for="txtNomeEnderecoModal">Identificação de Endereço*</label>
                            <input type="text" class="form-control" id="txtNomeEnderecoModal" required maxlength="100">
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
                    <h4 class="modal-title w-100 font-weight-bold">Novo cartão de crédito</h4>
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
                            <label for="txtNumeroCartaoModal">Número*</label>
                            <input type="text" maxlength="16" class="form-control" id="txtNumeroCartaoModal" required>
                        </div>
                        <div class="col-md-4 mb-3 md-form">
                            <label for="txtCodigoModal">Código*</label>
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
    <script type="text/javascript" src="./js/jquery.mask.js"></script>
    <script type="text/javascript" src="./js/pages/register.js"></script>

</body>

</html>