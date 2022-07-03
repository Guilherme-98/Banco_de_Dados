package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

import model.Camera;

public class PgCameraDAO implements CameraDAO{

	private static final String CREATE_QUERY =
            "INSERT INTO produto.camera(resolucao_camera) VALUES(?);";

    private static final String READ_QUERY =
            "SELECT id_camera, resolucao_camera FROM produto.camera WHERE id_camera = ?;";

    private static final String UPDATE_QUERY =
            "UPDATE produto.camera SET resolucao_camera = ? WHERE id_camera = ?;";

    private static final String DELETE_QUERY =
            "DELETE FROM produto.camera WHERE id_camera = ?;";

    private static final String ALL_QUERY =
            "SELECT DISTINCT id_camera, resolucao_camera FROM produto.camera ORDER BY id_camera;";
    
private Connection connection;
    
    public PgCameraDAO(Connection connection) {
        this.connection = connection;
    }

	@Override
	public void create(Camera camera) throws SQLException {
		try (PreparedStatement statement = connection.prepareStatement(CREATE_QUERY)) {
            statement.setString(1, camera.getResolucao_camera());
            statement.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(PgCameraDAO.class.getName()).log(Level.SEVERE, "DAO", ex);
        }
		
	}

	@Override
	public Camera read(Integer id) throws SQLException {
		Camera camera = new Camera();

        try (PreparedStatement statement = connection.prepareStatement(READ_QUERY)) {
            statement.setInt(1, id);
            try (ResultSet result = statement.executeQuery()) {
                if (result.next()) {
                	camera.setId_camera(result.getInt("id_camera"));
                	camera.setResolucao_camera(result.getString("resolucao_camera"));
                } else {
                    throw new SQLException("Erro ao visualizar: camera não encontrada.");
                }
            }
        } catch (SQLException ex) {
            Logger.getLogger(PgCameraDAO.class.getName()).log(Level.SEVERE, "DAO", ex);
            
            if (ex.getMessage().equals("Erro ao visualizar: camera não encontrada.")) {
                throw ex;
            } else {
                throw new SQLException("Erro ao visualizar camera.");
            }
        }
        return camera;
	}

	@Override
	public void update(Camera camera) throws SQLException {
		String query;
        query = UPDATE_QUERY;

        try (PreparedStatement statement = connection.prepareStatement(query)) {
        	statement.setString(1, camera.getResolucao_camera());
        	statement.setInt(2, camera.getId_camera());
            if (statement.executeUpdate() < 1) {
                throw new SQLException("Erro ao editar: camera não encontrada.");
            }
        } catch (SQLException ex) {
            Logger.getLogger(PgCameraDAO.class.getName()).log(Level.SEVERE, "DAO", ex);

            if (ex.getMessage().equals("Erro ao editar: camera não encontrada.")) {
                throw ex;
            } else if (ex.getMessage().contains("pk_camera")) {
                throw new SQLException("Erro ao editar camera: id já existente.");
            } else if (ex.getMessage().contains("not-null")) {
                throw new SQLException("Erro ao editar camera: pelo menos um campo está em branco.");
            } else {
                throw new SQLException("Erro ao editar camera.");
            }
        }
		
	}

	@Override
	public void delete(Integer id) throws SQLException {
		try (PreparedStatement statement = connection.prepareStatement(DELETE_QUERY)) {
            statement.setInt(1, id);

            if (statement.executeUpdate() < 1) {
                throw new SQLException("Erro ao excluir: camera não encontrada.");
            }
        } catch (SQLException ex) {
            Logger.getLogger(PgCameraDAO.class.getName()).log(Level.SEVERE, "DAO", ex);

            if (ex.getMessage().equals("Erro ao excluir: camera não encontrada.")) {
                throw ex;
            } else {
                throw new SQLException("Erro ao excluir camera.");
            }
        }
		
	}

	@Override
	public List<Camera> all() throws SQLException {
		List<Camera> cameraList = new ArrayList<>();

        try (PreparedStatement statement = connection.prepareStatement(ALL_QUERY);
             ResultSet result = statement.executeQuery()) {
            while (result.next()) {
            	Camera camera = new Camera();
            	camera.setId_camera(result.getInt("id_camera"));
            	camera.setResolucao_camera(result.getString("resolucao_camera"));
            	cameraList.add(camera);
            }
        } catch (SQLException ex) {
            Logger.getLogger(PgCameraDAO.class.getName()).log(Level.SEVERE, "DAO", ex);
            throw new SQLException("Erro ao listar camera.");
        }

        return cameraList;
	}

	@Override
	public void createRepeat(Camera t) throws SQLException {
		// TODO Auto-generated method stub
		
	}

	@Override
	public List<Camera> readByTitle(String titulo) throws SQLException {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public List<Camera> orderByAsc() throws SQLException {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public List<Camera> orderByDesc() throws SQLException {
		// TODO Auto-generated method stub
		return null;
	}


	@Override
	public void integrarCaracteristicas(Camera t, Integer id, List<Camera> l) throws SQLException {
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
