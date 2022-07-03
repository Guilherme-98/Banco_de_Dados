package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

import model.Preco;

public class PgPrecoDAO implements PrecoDAO{
	
	private static final String CREATE_QUERY =
            "INSERT INTO produto.preco(data_preco, preco_atual, preco_antigo, id_site) VALUES(?, ?, ?, ?);";
	
	private static final String CREATE_QUERY_REPEAT =
            "INSERT INTO produto.preco(data_preco, preco_atual, preco_antigo, id_iphone, id_site) VALUES(?, ?, ?, ?, ?);";

    private static final String READ_QUERY =
            "SELECT id_preco, data_preco, preco_atual, preco_antigo FROM produto.preco WHERE id_preco = ?;";

    private static final String UPDATE_QUERY =
            "UPDATE produto.preco SET data_preco = ?, preco_atual = ?, preco_antigo = ?  WHERE id_preco = ?;";

    private static final String DELETE_QUERY =
            "DELETE FROM produto.preco WHERE id_preco = ?;";

    private static final String ALL_QUERY =
            "SELECT DISTINCT id_preco, data_preco, preco_atual, preco_antigo, id_site, id_iphone FROM produto.preco ORDER BY id_preco;";
    
private Connection connection;
    
    public PgPrecoDAO(Connection connection) {
        this.connection = connection;
    }

	@Override
	public void create(Preco preco) throws SQLException {
		try (PreparedStatement statement = connection.prepareStatement(CREATE_QUERY)) {
            statement.setString(1, preco.getData_preco());
            statement.setDouble(2, preco.getPreco_atual());
            statement.setDouble(3, preco.getPreco_antigo());
            statement.setInt(4, preco.getId_site());
            statement.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(PgPrecoDAO.class.getName()).log(Level.SEVERE, "DAO", ex);
        }
		
	}
	
	@Override
	public void createRepeat(Preco preco) throws SQLException {
		try (PreparedStatement statement = connection.prepareStatement(CREATE_QUERY_REPEAT)) {
            statement.setString(1, preco.getData_preco());
            statement.setDouble(2, preco.getPreco_atual());
            statement.setDouble(3, preco.getPreco_antigo());
            statement.setInt(4, preco.getId_iphone());
            statement.setInt(5, preco.getId_site());
            statement.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(PgPrecoDAO.class.getName()).log(Level.SEVERE, "DAO", ex);
        }
	}

	@Override
	public Preco read(Integer id) throws SQLException {
		Preco preco = new Preco();

        try (PreparedStatement statement = connection.prepareStatement(READ_QUERY)) {
            statement.setInt(1, id);
            try (ResultSet result = statement.executeQuery()) {
                if (result.next()) {
                	preco.setId_preco(result.getInt("id_preco"));
                	preco.setData_preco(result.getString("data_preco"));
                	preco.setPreco_atual(result.getDouble("preco_atual"));
                	preco.setPreco_antigo(result.getDouble("preco_antigo"));
                } else {
                    throw new SQLException("Erro ao visualizar: preco não encontrado.");
                }
            }
        } catch (SQLException ex) {
            Logger.getLogger(PgPrecoDAO.class.getName()).log(Level.SEVERE, "DAO", ex);
            
            if (ex.getMessage().equals("Erro ao visualizar: preco não encontrado.")) {
                throw ex;
            } else {
                throw new SQLException("Erro ao visualizar preco.");
            }
        }
        return preco;
	}

	@Override
	public void update(Preco preco) throws SQLException {
		String query;
        query = UPDATE_QUERY;

        try (PreparedStatement statement = connection.prepareStatement(query)) {
        	statement.setString(1, preco.getData_preco());
        	statement.setDouble(2, preco.getPreco_atual());
            statement.setDouble(3, preco.getPreco_antigo());
        	statement.setInt(4, preco.getId_preco());

            if (statement.executeUpdate() < 1) {
                throw new SQLException("Erro ao editar: preco não encontrado.");
            }
        } catch (SQLException ex) {
            Logger.getLogger(PgIphoneDAO.class.getName()).log(Level.SEVERE, "DAO", ex);

            if (ex.getMessage().equals("Erro ao editar: preco não encontrado.")) {
                throw ex;
            } else if (ex.getMessage().contains("pk_preco")) {
                throw new SQLException("Erro ao editar preco: id já existente.");
            } else if (ex.getMessage().contains("not-null")) {
                throw new SQLException("Erro ao editar preco: pelo menos um campo está em branco.");
            } else {
                throw new SQLException("Erro ao editar preco.");
            }
        }
	}

	@Override
	public void delete(Integer id) throws SQLException {
		try (PreparedStatement statement = connection.prepareStatement(DELETE_QUERY)) {
            statement.setInt(1, id);

            if (statement.executeUpdate() < 1) {
                throw new SQLException("Erro ao excluir: preco não encontrado.");
            }
        } catch (SQLException ex) {
            Logger.getLogger(PgPrecoDAO.class.getName()).log(Level.SEVERE, "DAO", ex);

            if (ex.getMessage().equals("Erro ao excluir: preco não encontrado.")) {
                throw ex;
            } else {
                throw new SQLException("Erro ao excluir preco.");
            }
        }
		
	}

	@Override
	public List<Preco> all() throws SQLException {
		List<Preco> precoList = new ArrayList<>();

        try (PreparedStatement statement = connection.prepareStatement(ALL_QUERY);
             ResultSet result = statement.executeQuery()) {
            while (result.next()) {
            	Preco preco = new Preco();
            	preco.setId_preco(result.getInt("id_preco"));
            	preco.setData_preco(result.getString("data_preco"));
            	preco.setPreco_atual(result.getDouble("preco_atual"));
            	preco.setPreco_antigo(result.getDouble("preco_antigo"));
            	preco.setId_site(result.getInt("id_site"));
            	preco.setId_iphone(result.getInt("id_iphone"));
            	precoList.add(preco);
            }
        } catch (SQLException ex) {
            Logger.getLogger(PgPrecoDAO.class.getName()).log(Level.SEVERE, "DAO", ex);

            throw new SQLException("Erro ao listar precos.");
        }

        return precoList;
	}

	@Override
	public List<Preco> readByTitle(String titulo) throws SQLException {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public List<Preco> orderByAsc() throws SQLException {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public List<Preco> orderByDesc() throws SQLException {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public void integrarCaracteristicas(Preco t, Integer id, List<Preco> l) throws SQLException {
		// TODO Auto-generated method stub
		
	}

	@Override
	public Integer iphone11Count() throws SQLException {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public Integer iphone12Count() throws SQLException {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public Integer iphone13Count() throws SQLException {
		// TODO Auto-generated method stub
		return null;
	}
}
