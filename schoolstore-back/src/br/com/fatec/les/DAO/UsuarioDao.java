package br.com.fatec.les.DAO;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import br.com.fatec.les.database.ConexaoFactory;
import br.com.fatec.les.model.EntidadeDominio;
import br.com.fatec.les.model.IDominio;
import br.com.fatec.les.model.Imagem;
import br.com.fatec.les.model.Usuario;

public class UsuarioDao implements IDao{
	
	private Connection conexao = null;
	private String mensagem = null;
	ImagemDao imagemDao = new ImagemDao();
	
	public UsuarioDao() {
		conexao = ConexaoFactory.getConnection();
	}

	@Override
	public String atualizar(EntidadeDominio entidadeDominio) throws SQLException {
		Usuario usuario  = (Usuario) entidadeDominio;
		String sql = "UPDATE tb_usuario SET "
				+ "usu_senha = ?, "
				+ "usu_email = ? "
				+ " WHERE usu_id = ?";
		
		PreparedStatement pstm = null;
		
		try {
			if(imagemDao.atualizar(usuario.getImagem()) == null)
				return null;
			
			pstm = conexao.prepareStatement(sql);
			pstm.setString(1, usuario.getSenha());
			pstm.setString(2, usuario.getEmail());
			pstm.setLong(3, usuario.getId());
			pstm.executeUpdate();
			mensagem = "Usuário atualizado com sucesso";
		}catch(SQLException e) {
			mensagem = e.getMessage();
		}
//		finally {
//			ConexaoFactory.closeConnection(conexao, pstm);
//		}
		
		return mensagem;
	}

	@Override
	public List<EntidadeDominio> consultar(IDominio entidade) throws SQLException {
		Usuario usuario = (Usuario) entidade;
		
		List<EntidadeDominio> usuarios = new ArrayList<EntidadeDominio>();
		
		PreparedStatement pstm = null;
		ResultSet rs = null;
		String sql = "SELECT "
				+ "usu_id, "
				+ "usu_senha, "
				+ "usu_email, "
				+ "usu_ima_id "
				+ " FROM tb_usuario WHERE usu_ativo = 1 ";
		if(usuario.getId() != null) {
			sql += "AND usu_id = " + usuario.getId();
		}
				
		try {
			pstm = conexao.prepareStatement(sql);
			rs = pstm.executeQuery();
			
			Usuario u = new Usuario();
			Imagem i = new Imagem();
			
			while(rs.next()) {
				u = new Usuario();
				i = new Imagem();
				
				u.setId(Long.parseLong(rs.getString("usu_id")));
				u.setEmail(rs.getString("usu_email"));
				u.setSenha(rs.getString("usu_senha"));
				i.setId(Long.parseLong(rs.getString("usu_ima_id")));
				u.setImagem((Imagem)imagemDao.consultar(i).get(0));
				
				usuarios.add(u);
			}
		}catch(SQLException e) {
			System.err.println(e.getMessage());
		}
//		finally {
//			ConexaoFactory.closeConnection(conexao, pstm, rs);
//		}
		
		return usuarios;
	}
	
	@Override
	public String deletar(EntidadeDominio entidadeDominio) throws SQLException {
		Usuario usuario = (Usuario) entidadeDominio;
		String sql = "UPDATE tb_usuario SET "
				+ "usu_ativo = false"
				+ " WHERE usu_id = " + usuario.getId() + "";
		
		PreparedStatement pstm = null;
		
		try {
			if(imagemDao.deletar(usuario.getImagem()) == null)
				return null;
			
			pstm = conexao.prepareStatement(sql);
			pstm.executeUpdate();
			mensagem = "Usuário deletado com sucesso";
		}catch(SQLException e) {
			mensagem = e.getMessage();
		}
//		finally {
//			ConexaoFactory.closeConnection(conexao, pstm);
//		}
		
		return mensagem;
	}
	
	@Override
	public String salvar(EntidadeDominio entidadeDominio) throws SQLException {
		Usuario usuario = (Usuario) entidadeDominio;
		ResultSet rs;
		String sql = "INSERT INTO tb_usuario "
				+ "("
				+ "usu_email, "
				+ "usu_senha, "
				+ "usu_ima_id, "
				+ "usu_ativo, "
				+ "usu_dataHoraCriacao"
				+ ") "
				+ " VALUES ( ?, ?, ?, true, NOW())";
		
		PreparedStatement pstm = null;
		
		try {
			String idImagem = imagemDao.salvar(usuario.getImagem());
			pstm = conexao.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
			pstm.setString(1, usuario.getEmail());
			pstm.setString(2, usuario.getSenha());
			pstm.setInt(3, Integer.parseInt(idImagem));
			pstm.executeUpdate();
			
			rs = pstm.getGeneratedKeys();
			if (rs.next()){
				return Integer.toString(rs.getInt(1));
			}
						
		}catch(SQLException e){
			e.printStackTrace();
		}
//		finally {
//			ConexaoFactory.closeConnection(conexao, pstm);
//		}
		return null;
	}
}
