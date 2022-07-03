package model;

public class Comentario {
	
	private Integer id_comentario;
	private Integer id_iphone;
	private String descricao_comentario;
	private String data_do_comentario;
	
	
	public Integer getId_iphone() {
		return id_iphone;
	}
	public void setId_iphone(Integer id_iphone) {
		this.id_iphone = id_iphone;
	}
	
	public Integer getId_comentario() {
		return id_comentario;
	}
	public void setId_comentario(Integer id_comentario) {
		this.id_comentario = id_comentario;
	}
	public String getDescricao_comentario() {
		return descricao_comentario;
	}
	public void setDescricao_comentario(String descricao_comentario) {
		this.descricao_comentario = descricao_comentario;
	}
	public String getData_do_comentario() {
		return data_do_comentario;
	}
	public void setData_do_comentario(String data_do_comentario) {
		this.data_do_comentario = data_do_comentario;
	}
	
	
}
