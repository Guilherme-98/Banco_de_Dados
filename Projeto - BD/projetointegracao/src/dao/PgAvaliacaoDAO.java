package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

import model.Avaliacao;

public class PgAvaliacaoDAO implements AvaliacaoDAO {
	
	private static final String CREATE_QUERY =
            "INSERT INTO produto.avaliacao(nota_avaliacao) VALUES(?);";
	
	private static final String CREATE_QUERY_REPEAT =
            "INSERT INTO produto.avaliacao(nota_avaliacao, id_iphone) VALUES(?, ?);";

    private static final String READ_QUERY =
            "SELECT id_avaliacao, nota_avaliacao FROM produto.avaliacao WHERE id_avaliacao = ?;";

    private static final String UPDATE_QUERY =
            "UPDATE produto.avaliacao SET nota_avaliacao = ? WHERE id_avaliacao = ?;";

    private static final String DELETE_QUERY =
            "DELETE FROM produto.avaliacao WHERE id_avaliacao = ?;";

    private static final String ALL_QUERY =
            "SELECT DISTINCT id_avaliacao, nota_avaliacao, id_iphone FROM produto.avaliacao ORDER BY id_avaliacao;";
	
	private Connection connection;

	public  PgAvaliacaoDAO(Connection connection) {
		this.connection = connection;
	}

	@Override
	public void create(Avaliacao avaliacao) throws SQLException {
		try (PreparedStatement statement = connection.prepareStatement(CREATE_QUERY)) {
            statement.setDouble(1, avaliacao.getNota_avaliacao());
            statement.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(PgCameraDAO.class.getName()).log(Level.SEVERE, "DAO", ex);
        }

	}
	
	@Override
	public void createRepeat(Avaliacao avaliacao) throws SQLException {
		try (PreparedStatement statement = connection.prepareStatement(CREATE_QUERY_REPEAT)) {
            statement.setDouble(1, avaliacao.getNota_avaliacao());
            statement.setInt(2, avaliacao.getId_iphone());
            statement.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(PgSiteDAO.class.getName()).log(Level.SEVERE, "DAO", ex);
        }

	}
	


	@Override
	public Avaliacao read(Integer id) throws SQLException {
		Avaliacao avaliacao = new Avaliacao();

        try (PreparedStatement statement = connection.prepareStatement(READ_QUERY)) {
            statement.setInt(1, id);
            try (ResultSet result = statement.executeQuery()) {
                if (result.next()) {
                	avaliacao.setId_avaliacao(result.getInt("id_avaliacao"));
                	avaliacao.setNota_avaliacao(result.getDouble("nota_avaliacao"));
                } else {
                    throw new SQLException("Erro ao visualizar: avaliação não encontrada.");
                }
            }
        } catch (SQLException ex) {
            Logger.getLogger(PgCameraDAO.class.getName()).log(Level.SEVERE, "DAO", ex);
            
            if (ex.getMessage().equals("Erro ao visualizar: avaliação não encontrada.")) {
                throw ex;
            } else {
                throw new SQLException("Erro ao visualizar avaliação.");
            }
        }
        return avaliacao;
	}

	
	@Override
	public void update(Avaliacao avaliacao) throws SQLException {
		String query;
        query = UPDATE_QUERY;

        try (PreparedStatement statement = connection.prepareStatement(query)) {
        	statement.setDouble(1, avaliacao.getNota_avaliacao());
        	statement.setInt(2, avaliacao.getId_avaliacao());
            if (statement.executeUpdate() < 1) {
                throw new SQLException("Erro ao editar: avaliação não encontrada.");
            }
        } catch (SQLException ex) {
            Logger.getLogger(PgCameraDAO.class.getName()).log(Level.SEVERE, "DAO", ex);

            if (ex.getMessage().equals("Erro ao editar: avaliação não encontrada.")) {
                throw ex;
            } else if (ex.getMessage().contains("pk_avaliacao")) {
                throw new SQLException("Erro ao editar avaliação: id já existente.");
            } else if (ex.getMessage().contains("not-null")) {
                throw new SQLException("Erro ao editar avaliação: pelo menos um campo está em branco.");
            } else {
                throw new SQLException("Erro ao editar avaliação.");
            }
        }

	}

	@Override
	public void delete(Integer id) throws SQLException {
		try (PreparedStatement statement = connection.prepareStatement(DELETE_QUERY)) {
            statement.setInt(1, id);

            if (statement.executeUpdate() < 1) {
                throw new SQLException("Erro ao excluir: avaliação não encontrada.");
            }
        } catch (SQLException ex) {
            Logger.getLogger(PgCameraDAO.class.getName()).log(Level.SEVERE, "DAO", ex);

            if (ex.getMessage().equals("Erro ao excluir: avaliação não encontrada.")) {
                throw ex;
            } else {
                throw new SQLException("Erro ao excluir avaliação.");
            }
        }

	}

	@Override
	public List<Avaliacao> all() throws SQLException {
		List<Avaliacao> avaliacaoList = new ArrayList<>();

        try (PreparedStatement statement = connection.prepareStatement(ALL_QUERY);
             ResultSet result = statement.executeQuery()) {
            while (result.next()) {
            	Avaliacao avaliacao = new Avaliacao();
            	avaliacao.setId_avaliacao(result.getInt("id_avaliacao"));
            	avaliacao.setNota_avaliacao(result.getDouble("nota_avaliacao"));
            	avaliacao.setId_iphone(result.getInt("id_iphone"));
            	avaliacaoList.add(avaliacao);
            }
        } catch (SQLException ex) {
            Logger.getLogger(PgCameraDAO.class.getName()).log(Level.SEVERE, "DAO", ex);
            throw new SQLException("Erro ao listar avaliação.");
        }

        return avaliacaoList;
	}

	@Override
	public List<Avaliacao> orderByAsc() throws SQLException {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public List<Avaliacao> orderByDesc() throws SQLException {
		// TODO Auto-generated method stub
		return null;
	}
	
	
	@Override
	public List<Avaliacao> readByTitle(String titulo) throws SQLException {
		// TODO Auto-generated method stub
		return null;
	}


	@Override
	public void integrarCaracteristicas(Avaliacao t, Integer id, List<Avaliacao> l) throws SQLException {
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
