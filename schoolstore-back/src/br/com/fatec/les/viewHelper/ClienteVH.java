package br.com.fatec.les.viewHelper;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;

import br.com.fatec.les.facade.Mensagem;
import br.com.fatec.les.facade.MensagemStatus;
import br.com.fatec.les.facade.Resultado;
import br.com.fatec.les.model.assets.EntidadeDominio;
import br.com.fatec.les.model.assets.IDominio;
import br.com.fatec.les.model.endereco.Endereco;
import br.com.fatec.les.model.usuario.Cliente;
import br.com.fatec.les.model.usuario.Usuario;

public class ClienteVH implements IViewHelper{

	@Override
	public IDominio getEntidade(HttpServletRequest request) {
		Cliente cliente = new Cliente();
		EnderecoVH enderecoVH = new EnderecoVH();
		UsuarioVH usuarioVH = new UsuarioVH();
		
		String tarefa = request.getParameter("tarefa");
		
		if(tarefa.equals("atualizarCliente") ||
				tarefa.equals("deletarCliente") || 
				tarefa.equals("editaCliente")) {
			cliente.setId(Long.parseLong(request.getParameter("txtClienteId")));
		}
		cliente.setNome(request.getParameter("txtNome"));
		cliente.setNumeroDocumento(request.getParameter("txtNumeroDocumento"));
		cliente.setNumeroTelefone(request.getParameter("txtNumeroTelefone"));
		cliente.setUsuario((Usuario)usuarioVH.getEntidade(request));
		cliente.setEnderecos(enderecoVH.getEntidades(request));
		
		for(Endereco e : cliente.getEnderecos()) {
			e.setCliente(cliente);
		}

		return cliente;	
	}

	@Override
	public void setEntidade(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		
		String tarefa = request.getParameter("tarefa");

		if(tarefa.equals("consultarCliente")) {
			Resultado resultado = new Resultado();
			
			resultado = (Resultado)request.getAttribute("resultado");
			
			String json = new Gson().toJson(resultado);
			response.setContentType("application/json");
			response.setCharacterEncoding("UTF-8");
			response.getWriter().write(json);
			
		}else if(tarefa.equals("editaCliente")) {
			List<Cliente> clientes = new ArrayList<Cliente>();
			Resultado resultado = new Resultado();
			
			resultado = (Resultado)request.getAttribute("resultado");
			
			for(EntidadeDominio c : resultado.getEntidades()) {
				Cliente user = (Cliente) c;
				clientes.add(user);
			}
			
			Cliente cliente = clientes.get(0);

			request.setAttribute("cliente", cliente);
			request.getRequestDispatcher("clienteEditar.jsp").
			forward(request, response);
		}
		else if(tarefa.equals("atualizarCliente") || tarefa.equals("cadastrarCliente")){
			Resultado resultado = new Resultado();
			resultado = (Resultado)request.getAttribute("resultado");
			boolean flag = false; // flag para indicar se há algum erro
			
			for(Mensagem mensagem : resultado.getMensagens()) {
				if(mensagem.getMensagemStatus() == MensagemStatus.ERRO) {
					flag = true;
				}
			}
			if(flag) {
				if(tarefa.equals("atualizarCliente")) {
					request.getRequestDispatcher("clienteLista.jsp").
					forward(request, response);
				}else {
					request.getRequestDispatcher("clienteCadastro.jsp").
					forward(request, response);
				}
			}else {
				request.getRequestDispatcher("clienteMenu.jsp").
				forward(request, response);
			}
		}
		else if(tarefa.equals("deletarCliente")) {
			request.getRequestDispatcher("clienteLista.jsp").
			forward(request, response);
		}
		else {
			response.sendRedirect("index.html");
		}
	}
}