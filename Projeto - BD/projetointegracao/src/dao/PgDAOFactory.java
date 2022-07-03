package dao;

import java.sql.Connection;

public class PgDAOFactory extends DAOFactory{

	public PgDAOFactory(Connection connection) {
        this.connection = connection;
    }

    @Override
    public SiteDAO getSiteDAO() {
        return new PgSiteDAO(this.connection);
    }

	@Override
	public IphoneDAO getIphoneDAO() {
		return new PgIphoneDAO(this.connection);
	}

	@Override
	public ComentarioDAO getComentarioDAO() {
		return new PgComentarioDAO(this.connection);
	}

	@Override
	public PrecoDAO getPrecoDAO() {
		return new PgPrecoDAO(this.connection);
	}

	@Override
	public PrecoaVistaDAO getPrecoaVistaDAO() {
		return new PgPrecoaVistaDAO(this.connection);
	}

	@Override
	public PrecoParceladoDAO getPrecoParceladoDAO() {
		return new PgPrecoParceladoDAO(this.connection);
	}

	@Override
	public CameraDAO getCameraDAO() {
		return new PgCameraDAO(this.connection);
	}

	@Override
	public ArmazenamentoDAO getArmazenamentoDAO() {
		return new PgArmazenamentoDAO(this.connection);
	}
}
