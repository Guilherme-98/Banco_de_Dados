package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

import model.Site;

public class PgSiteDAO implements SiteDAO{
	
	private static final String CREATE_QUERY =
            "INSERT INTO produto.site(url_site, nome_site) VALUES(?, ?);";
	
	private static final String CREATE_QUERY_REPEAT =
            "INSERT INTO produto.site(url_site, nome_site, id_iphone) VALUES(?, ?, ?);";

    private static final String READ_QUERY =
            "SELECT id_site, url_site, nome_site FROM produto.site WHERE id_site = ?;";

    private static final String UPDATE_QUERY =
            "UPDATE produto.site SET url_site = ?, nome_site = ? WHERE id_site = ?;";

    private static final String DELETE_QUERY =
            "DELETE FROM produto.site WHERE id_site = ?;";

    private static final String ALL_QUERY =
            "SELECT id_site, url_site, nome_site FROM produto.site ORDER BY id_site;";

	private Connection connection;
    
    public PgSiteDAO(Connection connection) {
        this.connection = connection;
    }

	@Override
	public void create(Site site) throws SQLException {
		try (PreparedStatement statement = connection.prepareStatement(CREATE_QUERY)) {
            statement.setString(1, site.getUrl_site());
            statement.setString(2, site.getNome_site());
            statement.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(PgSiteDAO.class.getName()).log(Level.SEVERE, "DAO", ex);
        }
		
	}
	
	@Override
	public void createRepeat(Site site) throws SQLException {
		try (PreparedStatement statement = connection.prepareStatement(CREATE_QUERY_REPEAT)) {
            statement.setString(1, site.getUrl_site());
            statement.setString(2, site.getNome_site());
            statement.setInt(3, site.getId_iphone());
            statement.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(PgSiteDAO.class.getName()).log(Level.SEVERE, "DAO", ex);
        }
		
	}

	@Override
	public Site read(Integer id) throws SQLException {
		Site site = new Site();

        try (PreparedStatement statement = connection.prepareStatement(READ_QUERY)) {
            statement.setInt(1, id);
            try (ResultSet result = statement.executeQuery()) {
                if (result.next()) {
                    site.setId_site(result.getInt("id_site"));
                    site.setUrl_site(result.getString("url_site"));
                    site.setNome_site(result.getString("nome_site"));
                } else {
                    throw new SQLException("Erro ao visualizar: site não encontrado.");
                }
            }
        } catch (SQLException ex) {
            Logger.getLogger(PgSiteDAO.class.getName()).log(Level.SEVERE, "DAO", ex);
            
            if (ex.getMessage().equals("Erro ao visualizar: site não encontrado.")) {
                throw ex;
            } else {
                throw new SQLException("Erro ao visualizar site.");
            }
        }
        return site;
	}

	@Override
	public void update(Site site) throws SQLException {
		String query;
        query = UPDATE_QUERY;

        try (PreparedStatement statement = connection.prepareStatement(query)) {
        	statement.setString(1, site.getUrl_site());
            statement.setString(2, site.getNome_site());
        	statement.setInt(3, site.getId_site());

            if (statement.executeUpdate() < 1) {
                throw new SQLException("Erro ao editar: site não encontrado.");
            }
        } catch (SQLException ex) {
            if (ex.getMessage().equals("Erro ao editar: site não encontrado.")) {
                throw ex;
            }
            else {
                throw new SQLException("Erro ao editar site.");
            }
        }
		
	}

	@Override
	public void delete(Integer id) throws SQLException {
		try (PreparedStatement statement = connection.prepareStatement(DELETE_QUERY)) {
            statement.setInt(1, id);

            if (statement.executeUpdate() < 1) {
                throw new SQLException("Erro ao excluir: site não encontrado.");
            }
        } catch (SQLException ex) {
            Logger.getLogger(PgSiteDAO.class.getName()).log(Level.SEVERE, "DAO", ex);

            if (ex.getMessage().equals("Erro ao excluir: site não encontrado.")) {
                throw ex;
            } else {
                throw new SQLException("Erro ao excluir site.");
            }
        }
		
	}

	@Override
	public List<Site> all() throws SQLException {
		List<Site> siteList = new ArrayList<>();

        try (PreparedStatement statement = connection.prepareStatement(ALL_QUERY);
             ResultSet result = statement.executeQuery()) {
            while (result.next()) {
            	Site site = new Site();
            	site.setId_site(result.getInt("id_site"));
            	site.setUrl_site(result.getString("url_site"));
                site.setNome_site(result.getString("nome_site"));
                siteList.add(site);
            }
        } catch (SQLException ex) {
            Logger.getLogger(PgSiteDAO.class.getName()).log(Level.SEVERE, "DAO", ex);

            throw new SQLException("Erro ao listar sites.");
        }

        return siteList;
	}

	@Override
	public List<Site> readByTitle(String titulo) throws SQLException {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public List<Site> orderByAsc() throws SQLException {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public List<Site> orderByDesc() throws SQLException {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public void integrarCaracteristicas(Site t, Integer id, List<Site> l) throws SQLException {
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
