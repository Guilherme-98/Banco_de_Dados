package dao;

import java.sql.SQLException;
import java.util.List;

import model.Preco;

public interface DAO<T> {

	public void create(T t) throws SQLException;
	
	public void createRepeat(T t) throws SQLException;
	
	public T read(Integer id) throws SQLException;
	
	public List<T> readByTitle(String titulo) throws SQLException;

	public void update(T t) throws SQLException;

	public void delete(Integer id) throws SQLException;

	public List<T> all() throws SQLException;
	
	public List<T> orderByAsc(List<Preco> t) throws SQLException;
	
	public List<T> orderByDesc(List<Preco> t) throws SQLException;
	
	public void integrarCaracteristicas(T t, Integer id, List<T> l) throws SQLException;
	
	public Integer iphone11Count() throws SQLException;
	
	public Integer iphone12Count() throws SQLException;
	
	public Integer iphone13Count() throws SQLException;
	
	
}
