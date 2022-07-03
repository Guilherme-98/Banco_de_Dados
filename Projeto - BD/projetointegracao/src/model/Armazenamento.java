package model;


public class Armazenamento {

 private Integer id_armazenamento;
	
	private Integer id_iphone;
	
	private String capacidade_armazenamento;
	
	
	public Integer getId_armazenamento() {
		return id_armazenamento;
	}
	public void setId_armazenamento(Integer id_armazenamento) {
		this.id_armazenamento = id_armazenamento;
	}
	public Integer getId_iphone() {
		return id_iphone;
	}
	public void setId_iphone(Integer id_iphone) {
		this.id_iphone = id_iphone;
	}

	public String getCapacidade_armazenamento() {
		return capacidade_armazenamento;
	}
	public void setCapacidade_armazenamento(String capacidade_armazenamento) {
		this.capacidade_armazenamento = capacidade_armazenamento;
	}
}
