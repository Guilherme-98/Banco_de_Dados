package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

import model.Iphone;
import model.Preco;

public class PgIphoneDAO implements IphoneDAO {
	
	private static final String CREATE_QUERY =
			"INSERT INTO produto.iphone (bateria, peso, dimensao_produto, imagem_iphone, cor, garantia, itens_inclusos, conectividade, tipo_chip, processador, sistema_operacional, resolucao_tela, tamanho_tela, modelo, titulo) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
	
	private static final String READ_QUERY =
    		"SELECT id_iphone, bateria, peso, dimensao_produto, imagem_iphone, cor, garantia, itens_inclusos, conectividade, tipo_chip, processador, sistema_operacional, resolucao_tela, tamanho_tela, modelo, titulo FROM produto.iphone WHERE id_iphone = ?;";

	private static final String READ_QUERY_BY_NAME = 
			"SELECT id_iphone, bateria, peso, dimensao_produto, imagem_iphone, cor, garantia, itens_inclusos, conectividade, tipo_chip, processador, sistema_operacional, resolucao_tela, tamanho_tela, modelo, titulo FROM produto.iphone WHERE ";
	
    private static final String UPDATE_QUERY =
            "UPDATE produto.iphone SET bateria = ?, peso = ?, dimensao_produto = ?, cor = ?, garantia = ?, itens_inclusos = ?, conectividade = ?, tipo_chip = ?, processador = ?, sistema_operacional = ?, resolucao_tela = ?, tamanho_tela = ?, modelo = ?, titulo = ? WHERE id_iphone = ?;";

    private static final String DELETE_QUERY =
            "DELETE FROM produto.iphone WHERE id_iphone = ?;";

    private static final String ALL_QUERY =
            "SELECT DISTINCT id_iphone, bateria, peso, dimensao_produto, imagem_iphone, cor, garantia, itens_inclusos, conectividade, tipo_chip, processador, sistema_operacional, resolucao_tela, tamanho_tela, modelo, titulo FROM produto.iphone ORDER BY id_iphone;";

    private static final String FILTER_ASC = "SELECT i.id_iphone, bateria, peso, dimensao_produto, imagem_iphone, cor, garantia, itens_inclusos, conectividade, tipo_chip, processador, sistema_operacional, resolucao_tela, tamanho_tela, modelo, titulo, preco_atual, data_preco \r\n"
    		+ "FROM produto.iphone i\r\n"
    		+ "INNER JOIN produto.preco p\r\n"
    		+ "ON i.id_iphone = p.id_iphone\r\n"
    		+ "GROUP BY i.id_iphone, bateria, peso, dimensao_produto, imagem_iphone, cor, garantia, itens_inclusos, conectividade, tipo_chip, processador, sistema_operacional, resolucao_tela, tamanho_tela, modelo, titulo, preco_atual, data_preco\r\n"
    		+ "ORDER BY preco_atual ASC;\r\n";
    
    private static final String FILTER_DESC = "SELECT i.id_iphone, bateria, peso, dimensao_produto, imagem_iphone, cor, garantia, itens_inclusos, conectividade, tipo_chip, processador, sistema_operacional, resolucao_tela, tamanho_tela, modelo, titulo, preco_atual, data_preco \r\n"
    		+ "FROM produto.iphone i\r\n"
    		+ "INNER JOIN produto.preco p\r\n"
    		+ "ON i.id_iphone = p.id_iphone\r\n"
    		+ "GROUP BY i.id_iphone, bateria, peso, dimensao_produto, imagem_iphone, cor, garantia, itens_inclusos, conectividade, tipo_chip, processador, sistema_operacional, resolucao_tela, tamanho_tela, modelo, titulo, preco_atual, data_preco\r\n"
    		+ "ORDER BY preco_atual DESC;\r\n";
    
    private static final String COUNT_IPHONE11 = "SELECT COUNT(titulo)\r\n"
    		+ "FROM produto.iphone i\r\n"
    		+ "INNER JOIN produto.preco p\r\n"
    		+ "ON i.id_iphone = p.id_iphone\r\n"
    		+ "WHERE titulo LIKE '%iPhone 11%';";
    
    private static final String COUNT_IPHONE12 = "SELECT COUNT(titulo)\r\n"
    		+ "FROM produto.iphone i\r\n"
    		+ "INNER JOIN produto.preco p\r\n"
    		+ "ON i.id_iphone = p.id_iphone\r\n"
    		+ "WHERE titulo LIKE '%iPhone 12%';";
    
    private static final String COUNT_IPHONE13 = "SELECT COUNT(titulo)\r\n"
    		+ "FROM produto.iphone i\r\n"
    		+ "INNER JOIN produto.preco p\r\n"
    		+ "ON i.id_iphone = p.id_iphone\r\n"
    		+ "WHERE titulo LIKE '%iPhone 13%';";
    		
    
	private Connection connection;

	public PgIphoneDAO(Connection connection) {
		this.connection = connection;
	}

	@Override
	public void create(Iphone iphone) throws SQLException {
		try (PreparedStatement statement = connection.prepareStatement(CREATE_QUERY)) {
			statement.setString(1, iphone.getBateria());
			statement.setString(2, iphone.getPeso());
			statement.setString(3, iphone.getDimensao_produto());
			statement.setString(4, iphone.getImagem_iphone());
			statement.setString(5, iphone.getCor());
			statement.setString(6, iphone.getGarantia());
			statement.setString(7, iphone.getItens_inclusos());
			statement.setString(8, iphone.getConectividade());
			statement.setString(9, iphone.getTipo_chip());
			statement.setString(10, iphone.getProcessador());
			statement.setString(11, iphone.getSistema_operacional());
			statement.setString(12, iphone.getResolucao_tela());
			statement.setString(13, iphone.getTamanho_tela());
			statement.setString(14, iphone.getModelo());
			statement.setString(15, iphone.getTitulo());
            statement.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(PgIphoneDAO.class.getName()).log(Level.SEVERE, "DAO", ex);
        }
		
	}
	
	@Override
	public Iphone read(Integer id) throws SQLException {
		Iphone iphone = new Iphone();
        try (PreparedStatement statement = connection.prepareStatement(READ_QUERY)) {
            statement.setInt(1, id);
            try (ResultSet result = statement.executeQuery()) {
                if (result.next()) {
                	iphone.setId_iphone(result.getInt("id_iphone"));
            		iphone.setBateria(result.getString("bateria"));
            		iphone.setPeso(result.getString("peso"));
            		iphone.setDimensao_produto(result.getString("dimensao_produto"));
            		iphone.setImagem_iphone(result.getString("imagem_iphone"));
            		iphone.setCor(result.getString("cor"));
            		iphone.setGarantia(result.getString("garantia"));
            		iphone.setItens_inclusos(result.getString("itens_inclusos"));
            		iphone.setConectividade(result.getString("conectividade"));
            		iphone.setTipo_chip(result.getString("tipo_chip"));
            		iphone.setProcessador(result.getString("processador"));
            		iphone.setSistema_operacional(result.getString("sistema_operacional"));
            		iphone.setResolucao_tela(result.getString("resolucao_tela"));
            		iphone.setTamanho_tela(result.getString("tamanho_tela"));
            		iphone.setModelo(result.getString("modelo"));
            		iphone.setTitulo(result.getString("titulo"));
                } else {
                    throw new SQLException("Erro ao visualizar: iphone não encontrado.");
                }
            } 
        } catch (SQLException ex) {
            Logger.getLogger(PgIphoneDAO.class.getName()).log(Level.SEVERE, "DAO", ex);
            
            if (ex.getMessage().equals("Erro ao visualizar: iphone não encontrado.")) {
                throw ex;
            } else {
                throw new SQLException("Erro ao visualizar iphone.");
            }
        }
        return iphone;
	}

	@Override
	public void update(Iphone iphone) throws SQLException {
		String query;
        query = UPDATE_QUERY;
        try (PreparedStatement statement = connection.prepareStatement(query)) {
        	statement.setString(1, iphone.getBateria());
			statement.setString(2, iphone.getPeso());
			statement.setString(3, iphone.getDimensao_produto());
			statement.setString(4, iphone.getCor());
			statement.setString(5, iphone.getGarantia());
			statement.setString(6, iphone.getItens_inclusos());
			statement.setString(7, iphone.getConectividade());
			statement.setString(8, iphone.getTipo_chip());
			statement.setString(9, iphone.getProcessador());
			statement.setString(10, iphone.getSistema_operacional());
			statement.setString(11, iphone.getResolucao_tela());
			statement.setString(12, iphone.getTamanho_tela());
			statement.setString(13, iphone.getModelo());
			statement.setString(14, iphone.getTitulo());
			statement.setInt(15, iphone.getId_iphone());

            if (statement.executeUpdate() < 1) {
                throw new SQLException("Erro ao editar: iphone não encontrado.");
            }
        } catch (SQLException ex) {
            Logger.getLogger(PgIphoneDAO.class.getName()).log(Level.SEVERE, "DAO", ex);

            if (ex.getMessage().equals("Erro ao editar: iphone não encontrado.")) {
                throw ex;
            } else if (ex.getMessage().contains("pk_iphone")) {
                throw new SQLException("Erro ao editar iphone: id já existente.");
            } else if (ex.getMessage().contains("not-null")) {
                throw new SQLException("Erro ao editar iphone: pelo menos um campo está em branco.");
            } else {
                throw new SQLException("Erro ao editar iphone.");
            }
        }
		
	}

	@Override
	public void delete(Integer id) throws SQLException {
		try (PreparedStatement statement = connection.prepareStatement(DELETE_QUERY)) {
            statement.setInt(1, id);

            if (statement.executeUpdate() < 1) {
                throw new SQLException("Erro ao excluir: iphone não encontrado.");
            }
        } catch (SQLException ex) {
            Logger.getLogger(PgIphoneDAO.class.getName()).log(Level.SEVERE, "DAO", ex);

            if (ex.getMessage().equals("Erro ao excluir: iphone não encontrado.")) {
                throw ex;
            } else {
                throw new SQLException("Erro ao excluir iphone.");
            }
        }
		
	}

	@Override
	public List<Iphone> all() throws SQLException {
		List<Iphone> iphoneList = new ArrayList<>();
        try (PreparedStatement statement = connection.prepareStatement(ALL_QUERY);
             ResultSet result = statement.executeQuery()) {
            while (result.next()) {
            	Iphone iphone = new Iphone();
            	iphone.setId_iphone(result.getInt("id_iphone"));
            	iphone.setBateria(result.getString("bateria"));
        		iphone.setPeso(result.getString("peso"));
        		iphone.setDimensao_produto(result.getString("dimensao_produto"));
        		iphone.setImagem_iphone(result.getString("imagem_iphone"));
        		iphone.setCor(result.getString("cor"));
        		iphone.setGarantia(result.getString("garantia"));
        		iphone.setItens_inclusos(result.getString("itens_inclusos"));
        		iphone.setConectividade(result.getString("conectividade"));
        		iphone.setTipo_chip(result.getString("tipo_chip"));
        		iphone.setProcessador(result.getString("processador"));
        		iphone.setSistema_operacional(result.getString("sistema_operacional"));
        		iphone.setResolucao_tela(result.getString("resolucao_tela"));
        		iphone.setTamanho_tela(result.getString("tamanho_tela"));
        		iphone.setModelo(result.getString("modelo"));
        		iphone.setTitulo(result.getString("titulo"));
                iphoneList.add(iphone);
            }
        } catch (SQLException ex) {
            Logger.getLogger(PgIphoneDAO.class.getName()).log(Level.SEVERE, "DAO", ex);

            throw new SQLException("Erro ao listar iphones.");
        }

        return iphoneList;
	}

	@Override
	public List<Iphone> readByTitle(String titulo) throws SQLException {
		List<Iphone> iphoneList = new ArrayList<>();
		String produto = "";
		String pesquisa = "";
		if(produto != null) {
			produto += ("titulo ILIKE '%" + titulo + "%'");
		}
		pesquisa = READ_QUERY_BY_NAME + produto + " ORDER BY id_iphone;";
        try (PreparedStatement statement = connection.prepareStatement(pesquisa)) {
            try (ResultSet result = statement.executeQuery()) {
                while (result.next()) {
                	Iphone iphone = new Iphone();
                	iphone.setId_iphone(result.getInt("id_iphone"));
            		iphone.setBateria(result.getString("bateria"));
            		iphone.setPeso(result.getString("peso"));
            		iphone.setDimensao_produto(result.getString("dimensao_produto"));
            		iphone.setImagem_iphone(result.getString("imagem_iphone"));
            		iphone.setCor(result.getString("cor"));
            		iphone.setGarantia(result.getString("garantia"));
            		iphone.setItens_inclusos(result.getString("itens_inclusos"));
            		iphone.setConectividade(result.getString("conectividade"));
            		iphone.setTipo_chip(result.getString("tipo_chip"));
            		iphone.setProcessador(result.getString("processador"));
            		iphone.setSistema_operacional(result.getString("sistema_operacional"));
            		iphone.setResolucao_tela(result.getString("resolucao_tela"));
            		iphone.setTamanho_tela(result.getString("tamanho_tela"));
            		iphone.setModelo(result.getString("modelo"));
            		iphone.setTitulo(result.getString("titulo"));
            		iphoneList.add(iphone);
                } 
            } 
        } catch (SQLException ex) {
            Logger.getLogger(PgIphoneDAO.class.getName()).log(Level.SEVERE, "DAO", ex);
            
            if (ex.getMessage().equals("Erro ao visualizar: iphone não encontrado.")) {
                throw ex;
            } else {
                throw new SQLException("Erro ao visualizar iphones buscados.");
            }
        }
        return iphoneList;
	}
	
	@Override
	public Integer iphone11Count() throws SQLException {
		try (PreparedStatement statement = connection.prepareStatement(COUNT_IPHONE11);
	             ResultSet result = statement.executeQuery()) {
			 		while (result.next()) {
			 			Integer resultado = result.getInt("count");
			 			return resultado;
			 		}
		}
		return null;
	}

	@Override
	public Integer iphone12Count() throws SQLException {
		try (PreparedStatement statement = connection.prepareStatement(COUNT_IPHONE12);
	             ResultSet result = statement.executeQuery()) {
			 		while (result.next()) {
			 			Integer resultado = result.getInt("count");
			 			return resultado;
			 		}
		}
		return null;
	}

	@Override
	public Integer iphone13Count() throws SQLException {
		try (PreparedStatement statement = connection.prepareStatement(COUNT_IPHONE13);
	             ResultSet result = statement.executeQuery()) {
			 		while (result.next()) {
			 			Integer resultado = result.getInt("count");
			 			return resultado;
			 		}
		}
		return null;
	}	
	

	@Override
	public void createRepeat(Iphone t) throws SQLException {
		// TODO Auto-generated method stub
		
	}

	@Override
	public List<Iphone> orderByAsc(List<Preco> precos) throws SQLException {
		List<Iphone> iphoneList = new ArrayList<>();
		 try (PreparedStatement statement = connection.prepareStatement(FILTER_ASC);
	             ResultSet result = statement.executeQuery()) {
	            while (result.next()) {
	            	Iphone iphone = new Iphone();
	            	Preco preco = new Preco();
	            	iphone.setId_iphone(result.getInt("id_iphone"));
	            	iphone.setBateria(result.getString("bateria"));
	        		iphone.setPeso(result.getString("peso"));
	        		iphone.setDimensao_produto(result.getString("dimensao_produto"));
	        		iphone.setImagem_iphone(result.getString("imagem_iphone"));
	        		iphone.setCor(result.getString("cor"));
	        		iphone.setGarantia(result.getString("garantia"));
	        		iphone.setItens_inclusos(result.getString("itens_inclusos"));
	        		iphone.setConectividade(result.getString("conectividade"));
	        		iphone.setTipo_chip(result.getString("tipo_chip"));
	        		iphone.setProcessador(result.getString("processador"));
	        		iphone.setSistema_operacional(result.getString("sistema_operacional"));
	        		iphone.setResolucao_tela(result.getString("resolucao_tela"));
	        		iphone.setTamanho_tela(result.getString("tamanho_tela"));
	        		iphone.setModelo(result.getString("modelo"));
	        		iphone.setTitulo(result.getString("titulo"));
	        		preco.setPreco_atual(result.getDouble("preco_atual"));
	        		preco.setData_preco(result.getString("data_preco"));
	                iphoneList.add(iphone);
	                precos.add(preco);
	            }
	        } catch (SQLException ex) {
	            Logger.getLogger(PgIphoneDAO.class.getName()).log(Level.SEVERE, "DAO", ex);

	            throw new SQLException("Erro ao listar iphones.");
	        }

	        return iphoneList;
	}

	@Override
	public List<Iphone> orderByDesc(List<Preco> precos) throws SQLException {
		List<Iphone> iphoneList = new ArrayList<>();
		 try (PreparedStatement statement = connection.prepareStatement(FILTER_DESC);
	             ResultSet result = statement.executeQuery()) {
	            while (result.next()) {
	            	Iphone iphone = new Iphone();
	            	Preco preco = new Preco();
	            	iphone.setId_iphone(result.getInt("id_iphone"));
	            	iphone.setBateria(result.getString("bateria"));
	        		iphone.setPeso(result.getString("peso"));
	        		iphone.setDimensao_produto(result.getString("dimensao_produto"));
	        		iphone.setImagem_iphone(result.getString("imagem_iphone"));
	        		iphone.setCor(result.getString("cor"));
	        		iphone.setGarantia(result.getString("garantia"));
	        		iphone.setItens_inclusos(result.getString("itens_inclusos"));
	        		iphone.setConectividade(result.getString("conectividade"));
	        		iphone.setTipo_chip(result.getString("tipo_chip"));
	        		iphone.setProcessador(result.getString("processador"));
	        		iphone.setSistema_operacional(result.getString("sistema_operacional"));
	        		iphone.setResolucao_tela(result.getString("resolucao_tela"));
	        		iphone.setTamanho_tela(result.getString("tamanho_tela"));
	        		iphone.setModelo(result.getString("modelo"));
	        		iphone.setTitulo(result.getString("titulo"));
	        		preco.setPreco_atual(result.getDouble("preco_atual"));
	        		preco.setData_preco(result.getString("data_preco"));
	                iphoneList.add(iphone);
	                precos.add(preco);
	            }
	        } catch (SQLException ex) {
	            Logger.getLogger(PgIphoneDAO.class.getName()).log(Level.SEVERE, "DAO", ex);

	            throw new SQLException("Erro ao listar iphones.");
	        }

	        return iphoneList;
	}

	@Override
	public void integrarCaracteristicas(Iphone iphoneNovo, Integer id_iphone, List<Iphone> iphonesExistentes) throws SQLException {
		String query;
		for(int i = 0; i < iphonesExistentes.size(); i++) {
			if(id_iphone.equals(iphonesExistentes.get(i).getId_iphone())) {
				
				//Bateria
				if(iphonesExistentes.get(i).getBateria().equals(null) || iphonesExistentes.get(i).getBateria().equals("")) {
					query = "UPDATE produto.iphone SET bateria = ? WHERE id_iphone = ?;";
					try (PreparedStatement statement = connection.prepareStatement(query)) {
						statement.setString(1, iphoneNovo.getBateria());
						statement.setInt(2, id_iphone);
						
						if (statement.executeUpdate() < 1) {
			                throw new SQLException("Erro ao integrar característica - bateria");
			            }
					}
				}
				
				//Peso
				if(iphonesExistentes.get(i).getPeso().equals(null) || iphonesExistentes.get(i).getPeso().equals("")) {
					query = "UPDATE produto.iphone SET peso = ? WHERE id_iphone = ?;";
					try (PreparedStatement statement = connection.prepareStatement(query)) {
						statement.setString(1, iphoneNovo.getPeso());
						statement.setInt(2, id_iphone);
						
						if (statement.executeUpdate() < 1) {
			                throw new SQLException("Erro ao integrar característica - peso");
			            }
					}
				}
				
				//Dimensão do produto
				if(iphonesExistentes.get(i).getDimensao_produto().equals(null) || iphonesExistentes.get(i).getDimensao_produto().equals("")) {
					query = "UPDATE produto.iphone SET dimensao_produto = ? WHERE id_iphone = ?;";
					try (PreparedStatement statement = connection.prepareStatement(query)) {
						statement.setString(1, iphoneNovo.getDimensao_produto());
						statement.setInt(2, id_iphone);
						
						if (statement.executeUpdate() < 1) {
			                throw new SQLException("Erro ao integrar característica - dimensao_produto");
			            }
					}
				}
				
				//Cor
				if(iphonesExistentes.get(i).getCor().equals(null) || iphonesExistentes.get(i).getCor().equals("")) {
					query = "UPDATE produto.iphone SET cor = ? WHERE id_iphone = ?;";
					try (PreparedStatement statement = connection.prepareStatement(query)) {
						statement.setString(1, iphoneNovo.getCor());
						statement.setInt(2, id_iphone);
						
						if (statement.executeUpdate() < 1) {
			                throw new SQLException("Erro ao integrar característica - cor");
			            }
					}
				}
				
				//Garantia
				if(iphonesExistentes.get(i).getGarantia().equals(null) || iphonesExistentes.get(i).getGarantia().equals("")) {
					query = "UPDATE produto.iphone SET garantia = ? WHERE id_iphone = ?;";
					try (PreparedStatement statement = connection.prepareStatement(query)) {
						statement.setString(1, iphoneNovo.getGarantia());
						statement.setInt(2, id_iphone);
						
						if (statement.executeUpdate() < 1) {
			                throw new SQLException("Erro ao integrar característica - garantia");
			            }
					}
				}
				
				//Itens inclusos
				if(iphonesExistentes.get(i).getItens_inclusos().equals(null) || iphonesExistentes.get(i).getItens_inclusos().equals("")) {
					query = "UPDATE produto.iphone SET itens_inclusos = ? WHERE id_iphone = ?;";
					try (PreparedStatement statement = connection.prepareStatement(query)) {
						statement.setString(1, iphoneNovo.getItens_inclusos());
						statement.setInt(2, id_iphone);
						
						if (statement.executeUpdate() < 1) {
			                throw new SQLException("Erro ao integrar característica - itens_inclusos");
			            }
					}
				}
				
				//Conectividade
				if(iphonesExistentes.get(i).getConectividade().equals(null) || iphonesExistentes.get(i).getConectividade().equals("")) {
					query = "UPDATE produto.iphone SET conectividade = ? WHERE id_iphone = ?;";
					try (PreparedStatement statement = connection.prepareStatement(query)) {
						statement.setString(1, iphoneNovo.getConectividade());
						statement.setInt(2, id_iphone);
						
						if (statement.executeUpdate() < 1) {
			                throw new SQLException("Erro ao integrar característica - conectividade");
			            }
					}
				}
				
				//Tipo do Chip
				if(iphonesExistentes.get(i).getTipo_chip().equals(null) || iphonesExistentes.get(i).getTipo_chip().equals("")) {
					query = "UPDATE produto.iphone SET tipo_chip = ? WHERE id_iphone = ?;";
					try (PreparedStatement statement = connection.prepareStatement(query)) {
						statement.setString(1, iphoneNovo.getTipo_chip());
						statement.setInt(2, id_iphone);
						
						if (statement.executeUpdate() < 1) {
			                throw new SQLException("Erro ao integrar característica - tipo_chip");
			            }
					}
				}
				
				//Processador
				if(iphonesExistentes.get(i).getProcessador().equals(null) || iphonesExistentes.get(i).getProcessador().equals("")) {
					query = "UPDATE produto.iphone SET processador = ? WHERE id_iphone = ?;";
					try (PreparedStatement statement = connection.prepareStatement(query)) {
						statement.setString(1, iphoneNovo.getProcessador());
						statement.setInt(2, id_iphone);
						
						if (statement.executeUpdate() < 1) {
			                throw new SQLException("Erro ao integrar característica - processador");
			            }
					}
				}
				
				//Sistema operacional
				if(iphonesExistentes.get(i).getSistema_operacional().equals(null) || iphonesExistentes.get(i).getSistema_operacional().equals("")) {
					query = "UPDATE produto.iphone SET sistema_operacional = ? WHERE id_iphone = ?;";
					try (PreparedStatement statement = connection.prepareStatement(query)) {
						statement.setString(1, iphoneNovo.getSistema_operacional());
						statement.setInt(2, id_iphone);
						
						if (statement.executeUpdate() < 1) {
			                throw new SQLException("Erro ao integrar característica - sistema_operacional");
			            }
					}
				}
				
				//Resolucao da tela
				if(iphonesExistentes.get(i).getResolucao_tela().equals(null) || iphonesExistentes.get(i).getResolucao_tela().equals("")) {
					query = "UPDATE produto.iphone SET resolucao_tela = ? WHERE id_iphone = ?;";
					try (PreparedStatement statement = connection.prepareStatement(query)) {
						statement.setString(1, iphoneNovo.getResolucao_tela());
						statement.setInt(2, id_iphone);
						
						if (statement.executeUpdate() < 1) {
			                throw new SQLException("Erro ao integrar característica - resolucao_tela");
			            }
					}
				}
				
				//Tamanho da tela
				if(iphonesExistentes.get(i).getTamanho_tela().equals(null) || iphonesExistentes.get(i).getTamanho_tela().equals("")) {
					query = "UPDATE produto.iphone SET tamanho_tela = ? WHERE id_iphone = ?;";
					try (PreparedStatement statement = connection.prepareStatement(query)) {
						statement.setString(1, iphoneNovo.getTamanho_tela());
						statement.setInt(2, id_iphone);
						
						if (statement.executeUpdate() < 1) {
			                throw new SQLException("Erro ao integrar característica - tamanho_tela");
			            }
					}
				}
			}
			
		}		
	}

	
}
