package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

import model.Comentario;

public class PgComentarioDAO implements ComentarioDAO{

	private static final String CREATE_QUERY =
            "INSERT INTO produto.comentario(descricao_comentario1, descricao_comentario2, descricao_comentario3, data_do_comentario1, data_do_comentario2, data_do_comentario3) VALUES(?, ?, ?, ?, ? ,?);";

    private static final String READ_QUERY =
            "SELECT id_comentario, descricao_comentario1, descricao_comentario2, descricao_comentario3, data_do_comentario1, data_do_comentario2, data_do_comentario3 FROM produto.comentario WHERE id_comentario = ?;";

    private static final String UPDATE_QUERY =
            "UPDATE produto.comentario SET descricao_comentario1 = ? WHERE id_comentario = ?;";

    private static final String DELETE_QUERY =
            "DELETE FROM produto.comentario WHERE id_comentario = ?;";

    private static final String ALL_QUERY =
            "SELECT DISTINCT id_comentario, descricao_comentario1, descricao_comentario2, descricao_comentario3, data_do_comentario1, data_do_comentario2, data_do_comentario3 FROM produto.comentario ORDER BY id_comentario;";

	private Connection connection;
    
    public PgComentarioDAO(Connection connection) {
        this.connection = connection;
    }

	@Override
	public void create(Comentario comentario) throws SQLException {
		try (PreparedStatement statement = connection.prepareStatement(CREATE_QUERY)) {
			statement.setString(1, comentario.getDescricao_comentario1());
			statement.setString(2, comentario.getDescricao_comentario2());
			statement.setString(3, comentario.getDescricao_comentario3());
            statement.setString(4, comentario.getData_do_comentario1());
            statement.setString(5, comentario.getData_do_comentario2());
            statement.setString(6, comentario.getData_do_comentario3());
            
            statement.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(PgComentarioDAO.class.getName()).log(Level.SEVERE, "DAO", ex);
        }
		
	}

	@Override
	public Comentario read(Integer id) throws SQLException {
		Comentario comentario = new Comentario();

        try (PreparedStatement statement = connection.prepareStatement(READ_QUERY)) {
            statement.setInt(1, id);
            try (ResultSet result = statement.executeQuery()) {
                if (result.next()) {
                	comentario.setId_comentario(result.getInt("id_comentario"));
                	comentario.setDescricao_comentario1(result.getString("descricao_comentario1"));
                	comentario.setDescricao_comentario2(result.getString("descricao_comentario2"));
                	comentario.setDescricao_comentario3(result.getString("descricao_comentario3"));
                	comentario.setData_do_comentario1(result.getString("data_do_comentario1"));
                	comentario.setData_do_comentario2(result.getString("data_do_comentario2"));
                	comentario.setData_do_comentario3(result.getString("data_do_comentario3"));
                	
                    
                } else {
                    throw new SQLException("Erro ao visualizar: comentario não encontrado.");
                }
            }
        } catch (SQLException ex) {
            Logger.getLogger(PgComentarioDAO.class.getName()).log(Level.SEVERE, "DAO", ex);
            
            if (ex.getMessage().equals("Erro ao visualizar: comentario não encontrado.")) {
                throw ex;
            } else {
                throw new SQLException("Erro ao visualizar comentario.");
            }
        }
        return comentario;
	}

	@Override
	public void update(Comentario comentario) throws SQLException {
		String query;
        query = UPDATE_QUERY;
        try (PreparedStatement statement = connection.prepareStatement(query)) {
        	statement.setInt(1, comentario.getId_comentario());
        	statement.setString(2, comentario.getDescricao_comentario1());
            if (statement.executeUpdate() < 1) {
                throw new SQLException("Erro ao editar: comentario não encontrado.");
            }
        } catch (SQLException ex) {
            Logger.getLogger(PgComentarioDAO.class.getName()).log(Level.SEVERE, "DAO", ex);

            if (ex.getMessage().equals("Erro ao editar: comentario não encontrado.")) {
                throw ex;
            } else if (ex.getMessage().contains("pk_comentario")) {
                throw new SQLException("Erro ao editar comentario: id já existente.");
            } else if (ex.getMessage().contains("not-null")) {
                throw new SQLException("Erro ao editar comentario: pelo menos um campo está em branco.");
            } else {
                throw new SQLException("Erro ao editar comentario.");
            }
        }
		
	}

	@Override
	public void delete(Integer id) throws SQLException {
		try (PreparedStatement statement = connection.prepareStatement(DELETE_QUERY)) {
            statement.setInt(1, id);

            if (statement.executeUpdate() < 1) {
                throw new SQLException("Erro ao excluir: comentario não encontrado.");
            }
        } catch (SQLException ex) {
            Logger.getLogger(PgComentarioDAO.class.getName()).log(Level.SEVERE, "DAO", ex);

            if (ex.getMessage().equals("Erro ao excluir: comentario não encontrado.")) {
                throw ex;
            } else {
                throw new SQLException("Erro ao excluir comentario.");
            }
        }
		
	}

	@Override
	public List<Comentario> all() throws SQLException {
		List<Comentario> comentarioList = new ArrayList<>();

        try (PreparedStatement statement = connection.prepareStatement(ALL_QUERY);
             ResultSet result = statement.executeQuery()) {
            while (result.next()) {
            	Comentario comentario = new Comentario();
            	comentario.setId_comentario(result.getInt("id_comentario"));
            	comentario.setDescricao_comentario1(result.getString("descricao_comentario1"));
            	comentario.setDescricao_comentario2(result.getString("descricao_comentario2"));
            	comentario.setDescricao_comentario3(result.getString("descricao_comentario3"));
            	comentario.setData_do_comentario1(result.getString("data_do_comentario1"));
            	comentario.setData_do_comentario2(result.getString("data_do_comentario2"));
            	comentario.setData_do_comentario3(result.getString("data_do_comentario3"));
            	
            	comentarioList.add(comentario);
            }
        } catch (SQLException ex) {
            Logger.getLogger(PgComentarioDAO.class.getName()).log(Level.SEVERE, "DAO", ex);

            throw new SQLException("Erro ao listar comentarios.");
        }

        return comentarioList;
	}

	@Override
	public void createRepeat(Comentario t) throws SQLException {
		// TODO Auto-generated method stub
		
	}

	@Override
	public List<Comentario> readByTitle(String titulo) throws SQLException {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public List<Comentario> orderByAsc() throws SQLException {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public List<Comentario> orderByDesc() throws SQLException {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public void integrarCaracteristicas(Comentario t, Integer id, List<Comentario> l) throws SQLException {
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
