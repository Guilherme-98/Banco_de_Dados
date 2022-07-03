package model;

public class Preco {
	
	private Integer id_preco;
	private Integer id_iphone;
	private String data_preco;
	public double preco_atual;
	public double preco_antigo; 
	
	public Integer getId_preco() {
		return id_preco;
	}
	public void setId_preco(Integer id_preco) {
		this.id_preco = id_preco;
	}
	public Integer getId_iphone() {
		return id_iphone;
	}
	public void setId_iphone(Integer id_iphone) {
		this.id_iphone = id_iphone;
	}
	public String getData_preco() {
		return data_preco;
	}
	public void setData_preco(String data_preco) {
		this.data_preco = data_preco;
	}
	public double getPreco_atual() {
		return preco_atual;
	}
	public void setPreco_atual(double preco_atual) {
		this.preco_atual = preco_atual;
	}
	public double getPreco_antigo() {
		return preco_antigo;
	}
	public void setPreco_antigo(double preco_antigo) {
		this.preco_antigo = preco_antigo;
	}
	
	
}
