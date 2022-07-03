package dao;

import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;

import jdbc.ConnectionFactory;

public abstract class DAOFactory implements AutoCloseable{

	protected Connection connection;
    
    public static DAOFactory getInstance() throws ClassNotFoundException, IOException, SQLException {
        Connection connection = ConnectionFactory.getInstance().getConnection();
        DAOFactory factory;
        
        if (ConnectionFactory.getDbServer().equals("postgres")) {
            factory = new PgDAOFactory(connection);
        }
        else {
            throw new RuntimeException("Servidor de banco de dados não suportado.");
        }
        
        return factory;
    }    
    
    public void beginTransaction() throws SQLException {
        try {
            connection.setAutoCommit(false);
        } catch (SQLException ex) {
            System.err.println(ex.getMessage());

            throw new SQLException("Erro ao abrir transação.");
        }
    }

    public void commitTransaction() throws SQLException {
        try {
            connection.commit();
        } catch (SQLException ex) {
            System.err.println(ex.getMessage());

            throw new SQLException("Erro ao finalizar transação.");
        }
    }

    public void rollbackTransaction() throws SQLException {
        try {
            connection.rollback();
        } catch (SQLException ex) {
            System.err.println(ex.getMessage());

            throw new SQLException("Erro ao executar transação.");
        }
    }
    
    public void endTransaction() throws SQLException {
        try {
            connection.setAutoCommit(true);
        } catch (SQLException ex) {
            System.err.println(ex.getMessage());

            throw new SQLException("Erro ao finalizar transação.");
        }
    }

    public void closeConnection() throws SQLException {
        try {
            connection.close();
        } catch (SQLException ex) {
            System.err.println(ex.getMessage());

            throw new SQLException("Erro ao fechar conexão ao banco de dados.");
        }
    }

    public abstract SiteDAO getSiteDAO();
    public abstract IphoneDAO getIphoneDAO();
    public abstract ComentarioDAO getComentarioDAO();
    public abstract PrecoDAO getPrecoDAO();
    public abstract PrecoaVistaDAO getPrecoaVistaDAO();
    public abstract PrecoParceladoDAO getPrecoParceladoDAO();
    public abstract CameraDAO getCameraDAO();
    public abstract ArmazenamentoDAO getArmazenamentoDAO();

    @Override
    public void close() throws SQLException {
        closeConnection();
    }
}
