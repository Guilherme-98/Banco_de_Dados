package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

import model.Armazenamento;

public class PgArmazenamentoDAO implements ArmazenamentoDAO{

	private static final String CREATE_QUERY =
            "INSERT INTO produto.armazenamento(capacidade_armazenamento) VALUES(?);";

    private static final String READ_QUERY =
            "SELECT id_armazenamento, capacidade_armazenamento FROM produto.armazenamento WHERE id_armazenamento = ?;";

    private static final String UPDATE_QUERY =
            "UPDATE produto.armazenamento SET capacidade_armazenamento = ? WHERE id_armazenamento = ?;";

    private static final String DELETE_QUERY =
            "DELETE FROM produto.armazenamento WHERE id_armazenamento = ?;";

    private static final String ALL_QUERY =
            "SELECT DISTINCT id_armazenamento, capacidade_armazenamento FROM produto.armazenamento ORDER BY id_armazenamento;";
    
private Connection connection;
    
    public PgArmazenamentoDAO(Connection connection) {
        this.connection = connection;
    }

	@Override
	public void create(Armazenamento armazenamento) throws SQLException {
		try (PreparedStatement statement = connection.prepareStatement(CREATE_QUERY)) {
            statement.setString(1, armazenamento.getCapacidade_armazenamento());
            statement.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(PgArmazenamentoDAO.class.getName()).log(Level.SEVERE, "DAO", ex);
        }		
	}

	@Override
	public Armazenamento read(Integer id) throws SQLException {
		Armazenamento armazenamento = new Armazenamento();
        try (PreparedStatement statement = connection.prepareStatement(READ_QUERY)) {
            statement.setInt(1, id);
            try (ResultSet result = statement.executeQuery()) {
                if (result.next()) {
                	armazenamento.setId_armazenamento(result.getInt("id_armazenamento"));
                	armazenamento.setCapacidade_armazenamento(result.getString("capacidade_armazenamento"));
                } else {
                    throw new SQLException("Erro ao visualizar: armazenamento não encontrado.");
                }
            }
        } catch (SQLException ex) {
            Logger.getLogger(PgArmazenamentoDAO.class.getName()).log(Level.SEVERE, "DAO", ex);
            
            if (ex.getMessage().equals("Erro ao visualizar: armazenamento não encontrado.")) {
                throw ex;
            } else {
                throw new SQLException("Erro ao visualizar armazenamento.");
            }
        }
        return armazenamento;
	}

	@Override
	public void update(Armazenamento armazenamento) throws SQLException {
		String query;
        query = UPDATE_QUERY;

        try (PreparedStatement statement = connection.prepareStatement(query)) {
        	statement.setString(1, armazenamento.getCapacidade_armazenamento());
        	statement.setInt(2, armazenamento.getId_armazenamento());

            if (statement.executeUpdate() < 1) {
                throw new SQLException("Erro ao editar: armazenamento não encontrado.");
            }
        } catch (SQLException ex) {
            if (ex.getMessage().equals("Erro ao editar: armazenamento não encontrado.")) {
                throw ex;
            }
            else {
                throw new SQLException("Erro ao editar armazenamento.");
            }
        }
		
	}

	@Override
	public void delete(Integer id) throws SQLException {
		try (PreparedStatement statement = connection.prepareStatement(DELETE_QUERY)) {
            statement.setInt(1, id);
            if (statement.executeUpdate() < 1) {
                throw new SQLException("Erro ao excluir: armazenamento não encontrado.");
            }
        } catch (SQLException ex) {
            Logger.getLogger(PgArmazenamentoDAO.class.getName()).log(Level.SEVERE, "DAO", ex);

            if (ex.getMessage().equals("Erro ao excluir: armazenamento não encontrado.")) {
                throw ex;
            } else {
                throw new SQLException("Erro ao excluir armazenamento.");
            }
        }
		
	}

	@Override
	public List<Armazenamento> all() throws SQLException {
		List<Armazenamento> armazenamentoList = new ArrayList<>();

        try (PreparedStatement statement = connection.prepareStatement(ALL_QUERY);
             ResultSet result = statement.executeQuery()) {
            while (result.next()) {
            	Armazenamento armazenamento = new Armazenamento();
            	armazenamento.setId_armazenamento(result.getInt("id_armazenamento"));
            	armazenamento.setCapacidade_armazenamento(result.getString("capacidade_armazenamento"));
            	armazenamentoList.add(armazenamento);
            }
        } catch (SQLException ex) {
            Logger.getLogger(PgArmazenamentoDAO.class.getName()).log(Level.SEVERE, "DAO", ex);

            if (ex.getMessage().equals("Erro ao editar: armazenamento não encontrado.")) {
                throw ex;
            } else if (ex.getMessage().contains("pk_id_armazenamento")) {
                throw new SQLException("Erro ao editar armazenamento: id já existente.");
            } else if (ex.getMessage().contains("not-null")) {
                throw new SQLException("Erro ao editar armazenamento: pelo menos um campo está em branco.");
            } else {
                throw new SQLException("Erro ao editar armazenamento.");
            }
        }
        return armazenamentoList;
	}

	@Override
	public void createRepeat(Armazenamento t) throws SQLException {
		// TODO Auto-generated method stub
		
	}

	@Override
	public List<Armazenamento> readByTitle(String titulo) throws SQLException {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public List<Armazenamento> orderByAsc() throws SQLException {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public List<Armazenamento> orderByDesc() throws SQLException {
		// TODO Auto-generated method stub
		return null;
	}


	@Override
	public void integrarCaracteristicas(Armazenamento t, Integer id, List<Armazenamento> l) throws SQLException {
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
