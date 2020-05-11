package br.com.fatec.les.model.troca;

import br.com.fatec.les.model.produto.Produto;

public class ItemTroca {

	private Produto produto;
	private int quantidade;
	
	public Produto getProduto() {
		return produto;
	}
	public void setProduto(Produto produto) {
		this.produto = produto;
	}
	public int getQuantidade() {
		return quantidade;
	}
	public void setQuantidade(int quantidade) {
		this.quantidade = quantidade;
	}
}
