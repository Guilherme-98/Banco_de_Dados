package controller;

import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.IOException;
import java.nio.charset.StandardCharsets;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;

import dao.DAO;
import dao.DAOFactory;
import dao.SiteDAO;
import model.Armazenamento;
import model.Avaliacao;
import model.Camera;
import model.Comentario;
import model.Iphone;
import model.Preco;
import model.Site;

@WebServlet(name = "ProdutoController", urlPatterns = { "/produtos", "/adicionarProduto", "/detalhesProduto",
		"/atualizarProduto", "/deletarProduto", "/procurarProduto", "/filtroPrecoCrescente", "/filtroPrecoDecrescente", "/iphonesRegistrados"})
public class ProdutoController extends HttpServlet {

	private static final long serialVersionUID = 1L;

	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		DAO<Iphone> iphoneDao;
		DAO<Site> siteDAO;
		DAO<Comentario> comentarioDAO;
		DAO<Preco> precoDAO;
		DAO<Camera> cameraDAO;
		DAO<Armazenamento> armazenamentoDAO;
		DAO<Avaliacao> avaliacaoDAO;
		Iphone iphone;
		Site site;
		Comentario comentario;
		Preco preco;
		Camera camera;
		Armazenamento armazenamento;
		Avaliacao avaliacao;
		Integer iphone11Count = 0;
		Integer iphone12Count = 0;
		Integer iphone13Count = 0;
		List<String> datasSubmarino = new ArrayList<String>();
		List<String> datasShoptime = new ArrayList<String>();
		List<String> datasAmericanas = new ArrayList<String>();
		List<String> datasGerais = new ArrayList<String>();
		List<Double> precosGerais = new ArrayList<Double>();
		List<Double> precosAntigos = new ArrayList<Double>();
		List<Double> precosAtuaisSubmarino = new ArrayList<Double>();
		List<Double> precosAtuaisAmericanas = new ArrayList<Double>();
		List<Double> precosAtuaisShoptime = new ArrayList<Double>();
		List<Preco> precosFiltro = new ArrayList<Preco>();
		RequestDispatcher dispatcher;

		switch (request.getServletPath()) {
		case "/produtos": {
			try (DAOFactory daoFactory = DAOFactory.getInstance()) {
				iphoneDao = daoFactory.getIphoneDAO();
				siteDAO = daoFactory.getSiteDAO();
				precoDAO = daoFactory.getPrecoDAO();
				comentarioDAO = daoFactory.getComentarioDAO();
				cameraDAO = daoFactory.getCameraDAO();
				armazenamentoDAO = daoFactory.getArmazenamentoDAO();
				avaliacaoDAO = daoFactory.getAvaliacaoDAO();

				List<Iphone> iphoneList = iphoneDao.all();
				List<Site> siteList = siteDAO.all();
				List<Comentario> comentarioList = comentarioDAO.all();
				List<Preco> precoList = precoDAO.all();
				List<Camera> cameraList = cameraDAO.all();
				List<Armazenamento> armazenamentoList = armazenamentoDAO.all();
				List<Avaliacao> avaliacaoList = avaliacaoDAO.all();
				
				request.setAttribute("iphoneList", iphoneList);
				request.setAttribute("siteList", siteList);
				request.setAttribute("comentarioList", comentarioList);
				request.setAttribute("precoList", precoList);
				request.setAttribute("cameraList", cameraList);
				request.setAttribute("armazenamentoList", armazenamentoList);
				request.setAttribute("avaliacaoList", avaliacaoList);
			} catch (ClassNotFoundException | IOException | SQLException ex) {
				request.getSession().setAttribute("error", ex.getMessage());
			}
			dispatcher = request.getRequestDispatcher("/view/listagemProdutos.jsp");
			dispatcher.forward(request, response);
			break;
		}

		case "/adicionarProduto": {
			dispatcher = request.getRequestDispatcher("/view/produtoAdicionado.jsp");
			dispatcher.forward(request, response);
			break;
		}
		
		case "/procurarProduto": {
			try (DAOFactory daoFactory = DAOFactory.getInstance()) {
				iphoneDao = daoFactory.getIphoneDAO();
				List<Iphone> iphoneList = iphoneDao.readByTitle(request.getParameter("titulo"));
				request.setAttribute("iphoneList", iphoneList);
			} catch (ClassNotFoundException | IOException | SQLException ex) {
				request.getSession().setAttribute("error", ex.getMessage());
			}
			dispatcher = request.getRequestDispatcher("/view/listagemProdutos.jsp");
			dispatcher.forward(request, response);
			break;			
		}
		
		
		case "/filtroPrecoCrescente": {
			try (DAOFactory daoFactory = DAOFactory.getInstance()) {
				iphoneDao = daoFactory.getIphoneDAO();
				List<Iphone> iphoneList = iphoneDao.orderByAsc(precosFiltro);
				request.setAttribute("iphoneList", iphoneList);
				request.setAttribute("precosFiltro", precosFiltro);
			} catch (ClassNotFoundException | IOException | SQLException ex) {
				request.getSession().setAttribute("error", ex.getMessage());
			}
			dispatcher = request.getRequestDispatcher("/view/filtroPrecos.jsp");
			dispatcher.forward(request, response);
			precosFiltro = new ArrayList<Preco>();
			break;
		}
		
		case "/filtroPrecoDecrescente": {
			try (DAOFactory daoFactory = DAOFactory.getInstance()) {
				iphoneDao = daoFactory.getIphoneDAO();
				List<Iphone> iphoneList = iphoneDao.orderByDesc(precosFiltro);
				request.setAttribute("iphoneList", iphoneList);
				request.setAttribute("precosFiltro", precosFiltro);
			} catch (ClassNotFoundException | IOException | SQLException ex) {
				request.getSession().setAttribute("error", ex.getMessage());
			}
			dispatcher = request.getRequestDispatcher("/view/filtroPrecos.jsp");
			dispatcher.forward(request, response);
			precosFiltro = new ArrayList<Preco>();
			break;
		}
		
		case "/iphonesRegistrados": {
			try (DAOFactory daoFactory = DAOFactory.getInstance()) {
				iphoneDao = daoFactory.getIphoneDAO();
				iphone11Count = iphoneDao.iphone11Count();
				iphone12Count = iphoneDao.iphone12Count();
				iphone13Count = iphoneDao.iphone13Count();
				request.setAttribute("iphone11Count", iphone11Count);
				request.setAttribute("iphone12Count", iphone12Count);
				request.setAttribute("iphone13Count", iphone13Count);
			}  catch (ClassNotFoundException | IOException | SQLException ex) {
				request.getSession().setAttribute("error", ex.getMessage());
			}
			dispatcher = request.getRequestDispatcher("/view/graficoIphones.jsp");
			dispatcher.forward(request, response);
			break;
		}
		

		case "/detalhesProduto": {
			try (DAOFactory daoFactory = DAOFactory.getInstance()) {
				iphoneDao = daoFactory.getIphoneDAO();
				siteDAO = daoFactory.getSiteDAO();
				precoDAO = daoFactory.getPrecoDAO();
				comentarioDAO = daoFactory.getComentarioDAO();
				cameraDAO = daoFactory.getCameraDAO();
				armazenamentoDAO = daoFactory.getArmazenamentoDAO();
				avaliacaoDAO = daoFactory.getAvaliacaoDAO();

				iphone = iphoneDao.read(Integer.parseInt(request.getParameter("id_iphone")));
				site = siteDAO.read(Integer.parseInt(request.getParameter("id_iphone")));
				preco = precoDAO.read(Integer.parseInt(request.getParameter("id_iphone")));
				camera = cameraDAO.read(Integer.parseInt(request.getParameter("id_iphone")));
				armazenamento = armazenamentoDAO.read(Integer.parseInt(request.getParameter("id_iphone")));
				comentario = comentarioDAO.read(Integer.parseInt(request.getParameter("id_iphone")));
				avaliacao = avaliacaoDAO.read(Integer.parseInt(request.getParameter("id_iphone")));

				List<Preco> listPreco = new ArrayList<Preco>();
				List<Site> listSite = new ArrayList<Site>();
				List<Avaliacao> listAvaliacao = new ArrayList<Avaliacao>();
				Double somaAvaliacaoGeral = 0.0;
				Double mediaAvaliacao = 0.0;
				int contadorMedia = 0;
				listPreco = precoDAO.all();
				listSite = siteDAO.all();
				listAvaliacao = avaliacaoDAO.all();
				request.setAttribute("iphone", iphone);
				request.setAttribute("site", site);
				request.setAttribute("preco", preco);
				request.setAttribute("camera", camera);
				request.setAttribute("armazenamento", armazenamento);
				request.setAttribute("comentario", comentario);
				request.setAttribute("avaliacao", avaliacao);
				
				for(int i = 0; i < listPreco.size(); i++) {
					if(listPreco.get(i).getId_iphone().equals(iphone.getId_iphone())) {
						if(listSite.get(i).getNome_site().equals("submarino")) {
							datasSubmarino.add(listPreco.get(i).getData_preco());
							datasGerais.add(listPreco.get(i).getData_preco());
							precosGerais.add(listPreco.get(i).getPreco_atual());
							precosAtuaisSubmarino.add(listPreco.get(i).getPreco_atual());
						} else if(listSite.get(i).getNome_site().equals("shoptime")) {
							datasShoptime.add(listPreco.get(i).getData_preco());
							datasGerais.add(listPreco.get(i).getData_preco());
							precosGerais.add(listPreco.get(i).getPreco_atual());
							precosAtuaisShoptime.add(listPreco.get(i).getPreco_atual());
						} else if(listSite.get(i).getNome_site().equals("americanas")) {
							datasAmericanas.add(listPreco.get(i).getData_preco());
							datasGerais.add(listPreco.get(i).getData_preco());
							precosGerais.add(listPreco.get(i).getPreco_atual());
							precosAtuaisAmericanas.add(listPreco.get(i).getPreco_atual());
						}
					}
				}
				
				for(int i = 0; i < listAvaliacao.size(); i++) {
					if(listAvaliacao.get(i).getId_iphone().equals(iphone.getId_iphone())) {
						somaAvaliacaoGeral = somaAvaliacaoGeral + listAvaliacao.get(i).getNota_avaliacao();
						contadorMedia++;
					}
				}
				
				mediaAvaliacao = somaAvaliacaoGeral/contadorMedia;
				
				if(precosAtuaisSubmarino.size() == 0 && datasSubmarino.size() == 0) {
					precosAtuaisSubmarino.add(0.0);
					datasSubmarino.add("2022-01-01");
				}
				if(precosAtuaisAmericanas.size() == 0 && datasAmericanas.size() == 0) {
					precosAtuaisAmericanas.add(0.0);
					datasAmericanas.add("2022-01-01");
				}
				if(precosAtuaisShoptime.size() == 0 && datasShoptime.size() == 0) {
					precosAtuaisShoptime.add(0.0);
					datasShoptime.add("2022-01-01");
				}
			
				request.setAttribute("datasSubmarino", datasSubmarino);
				request.setAttribute("datasShoptime", datasShoptime);
				request.setAttribute("datasAmericanas", datasAmericanas);
				request.setAttribute("datasGerais", datasGerais);
				request.setAttribute("precosGerais", precosGerais);
				request.setAttribute("precosAntigos", precosAntigos);
				request.setAttribute("mediaAvaliacao", mediaAvaliacao);
				request.setAttribute("precosAtuaisSubmarino", precosAtuaisSubmarino);
				request.setAttribute("precosAtuaisShoptime", precosAtuaisShoptime);
				request.setAttribute("precosAtuaisAmericanas", precosAtuaisAmericanas);

			} catch (ClassNotFoundException | IOException | SQLException ex) {
				request.getSession().setAttribute("error", ex.getMessage());
			}
			dispatcher = request.getRequestDispatcher("/view/detalhesProduto.jsp");
			dispatcher.forward(request, response);
			break;
		}

		case "/deletarProduto": {
			try (DAOFactory daoFactory = DAOFactory.getInstance()) {
				iphoneDao = daoFactory.getIphoneDAO();
				siteDAO = daoFactory.getSiteDAO();
				precoDAO = daoFactory.getPrecoDAO();
				comentarioDAO = daoFactory.getComentarioDAO();
				cameraDAO = daoFactory.getCameraDAO();
				armazenamentoDAO = daoFactory.getArmazenamentoDAO();
				avaliacaoDAO = daoFactory.getAvaliacaoDAO();

				avaliacaoDAO.delete(Integer.parseInt(request.getParameter("id_iphone")));
				comentarioDAO.delete(Integer.parseInt(request.getParameter("id_iphone")));
				armazenamentoDAO.delete(Integer.parseInt(request.getParameter("id_iphone")));
				cameraDAO.delete(Integer.parseInt(request.getParameter("id_iphone")));
				precoDAO.delete(Integer.parseInt(request.getParameter("id_iphone")));
				siteDAO.delete(Integer.parseInt(request.getParameter("id_iphone")));
				iphoneDao.delete(Integer.parseInt(request.getParameter("id_iphone")));
				
			} catch (ClassNotFoundException | IOException | SQLException ex) {
				request.getSession().setAttribute("error", ex.getMessage());
			}
			dispatcher = request.getRequestDispatcher("index.jsp");
			dispatcher.forward(request, response);

			break;
		}

		case "/atualizarProduto": {
			try (DAOFactory daoFactory = DAOFactory.getInstance()) {
				iphoneDao = daoFactory.getIphoneDAO();
				cameraDAO = daoFactory.getCameraDAO();
				armazenamentoDAO = daoFactory.getArmazenamentoDAO();

				iphone = iphoneDao.read(Integer.parseInt(request.getParameter("id_iphone")));
				camera = cameraDAO.read(Integer.parseInt(request.getParameter("id_iphone")));
				armazenamento = armazenamentoDAO.read(Integer.parseInt(request.getParameter("id_iphone")));

				request.setAttribute("iphone", iphone);
				request.setAttribute("camera", camera);
				request.setAttribute("armazenamento", armazenamento);
			} catch (ClassNotFoundException | IOException | SQLException ex) {
				request.getSession().setAttribute("error", ex.getMessage());
			}
			dispatcher = request.getRequestDispatcher("/view/atualizarProduto.jsp");
			dispatcher.forward(request, response);

			break;
		}
		}
	}

	private Iphone parseObjIphone(JSONObject iphoneJson, Iphone iphone) {

		String modelo = (String) iphoneJson.get("modelo");
		iphone.setModelo(modelo);
		String titulo = (String) iphoneJson.get("titulo");
		iphone.setTitulo(titulo);
		String tamanho_tela = (String) iphoneJson.get("tamanho_tela");
		iphone.setTamanho_tela(tamanho_tela);
		String resolucao_tela = (String) iphoneJson.get("resolucao_tela");
		iphone.setResolucao_tela(resolucao_tela);
		String sistema_operacional = (String) iphoneJson.get("sistema_operacional");
		iphone.setSistema_operacional(sistema_operacional);
		String processador = (String) iphoneJson.get("processador");
		iphone.setProcessador(processador);
		String tipo_chip = (String) iphoneJson.get("tipo_chip");
		iphone.setTipo_chip(tipo_chip);
		String bateria = (String) iphoneJson.get("bateria");
		iphone.setBateria(bateria);
		String peso = (String) iphoneJson.get("peso");
		iphone.setPeso(peso);
		String cor = (String) iphoneJson.get("cor");
		iphone.setCor(cor);
		String imagem_iphone = (String) iphoneJson.get("imagem_iphone");
		iphone.setImagem_iphone(imagem_iphone);
		String garantia = (String) iphoneJson.get("garantia");
		iphone.setGarantia(garantia);
		String conectividade = (String) iphoneJson.get("conectividade");
		iphone.setConectividade(conectividade);
		String dimensao_produto = (String) iphoneJson.get("dimensao_produto");
		iphone.setDimensao_produto(dimensao_produto);
		String itens_inclusos = (String) iphoneJson.get("itens_inclusos");
		iphone.setItens_inclusos(itens_inclusos);
		String nota_iphone = (String) iphoneJson.get("nota_iphone");
		iphone.setNota_iphone(nota_iphone);
		return iphone;
	}

	private static Site parseObjSite(JSONObject siteJson, Site site) {
		String url_site = (String) siteJson.get("url_site");
		site.setUrl_site(url_site);
		String nome_site = (String) siteJson.get("nome_site");
		site.setNome_site(nome_site);
		return site;
	}

	private static Preco parseObjPreco(JSONObject precoJson, Preco preco) {
		String data_preco = (String) precoJson.get("data_preco");
		preco.setData_preco(data_preco);
		Double preco_antigo = Double.parseDouble((String) precoJson.get("preco_antigo"));
		preco.setPreco_antigo(preco_antigo);
		Double preco_atual = Double.parseDouble((String) precoJson.get("preco_atual"));
		preco.setPreco_atual(preco_atual);
		return preco;
	}

	private static Camera parseObjCamera(JSONObject cameraJson, Camera camera) {
		String resolucao_camera = (String) cameraJson.get("resolucao_camera");
		camera.setResolucao_camera(resolucao_camera);
		return camera;
	}

	private static Armazenamento parseObjArmazenamento(JSONObject armazenamentoJson, Armazenamento armazenamento) {
		String capacidade_armazenamento = (String) armazenamentoJson.get("capacidade_armazenamento");
		armazenamento.setCapacidade_armazenamento(capacidade_armazenamento);
		return armazenamento;
	}

	private static Comentario parseObjComentario(JSONObject comentarioJson, Comentario comentario) {
		String descricao_comentario1 = (String) comentarioJson.get("descricao_comentario1");
		String descricao_comentario2 = (String) comentarioJson.get("descricao_comentario2");
		String descricao_comentario3 = (String) comentarioJson.get("descricao_comentario3");
		String data_do_comentario1 = (String) comentarioJson.get("data_do_comentario1");
		String data_do_comentario2 = (String) comentarioJson.get("data_do_comentario2");
		String data_do_comentario3 = (String) comentarioJson.get("data_do_comentario3");
		comentario.setDescricao_comentario1(descricao_comentario1);
		comentario.setDescricao_comentario2(descricao_comentario2);
		comentario.setDescricao_comentario3(descricao_comentario3);
		comentario.setData_do_comentario1(data_do_comentario1);
		comentario.setData_do_comentario2(data_do_comentario2);
		comentario.setData_do_comentario3(data_do_comentario3);
		return comentario;
	}
	
	private static Avaliacao parseObjAvaliacao(JSONObject avaliacaoJson, Avaliacao avaliacao) {
		Double nota_avaliacao = Double.parseDouble((String) avaliacaoJson.get("nota_avaliacao"));
		avaliacao.setNota_avaliacao(nota_avaliacao);
		return avaliacao;
	}

	private boolean flgExiste;
	private int cont = 0;
	private int contIntegracao = 0;
	private int contPreco = 0;
	private int contPrecoRepeat = 0;
	private int contSiteRepeat = 0;
	private int contAvaliacaoRepeat = 0;
	private int idAux;
	private List<String> nomeSite = new ArrayList<String>();
	private List<String> dataPreco = new ArrayList<String>();
	private List<Double> precoAntigo = new ArrayList<Double>();
	private List<Double> precoAtual = new ArrayList<Double>();
	private List<Double> notaAvaliacao = new ArrayList<Double>();

	private void iphoneExiste(boolean flgExiste) {
		flgExiste = true;
		this.flgExiste = flgExiste;
	}

	private void iphoneNaoExiste(boolean flgNaoExiste) {
		flgNaoExiste = false;
		this.flgExiste = flgNaoExiste;
	}

	private static boolean getFlg(boolean flgExiste) {
		return flgExiste;
	}

	@SuppressWarnings("unchecked")
	private void criarSiteRepetido(HttpServletRequest request, HttpServletResponse response, Integer fk_iphone_repetido) throws IOException {
		cont = 0;
		
		DAO<Site> siteDAO;
		Site site = new Site();
		JSONParser jsonParserSite = new JSONParser();
		try {
			String jsonName = request.getParameter("fileName");
			FileReader readerSite = new FileReader(
					"C:/Users/gabri/eclipse-workspace/projetointegracao/WebContent/json/" + jsonName);
			Object objSite = jsonParserSite.parse(readerSite);
			JSONArray siteList = (JSONArray) objSite;
			siteList = (JSONArray) objSite;
			try (DAOFactory daoFactory = DAOFactory.getInstance()) {
				siteDAO = daoFactory.getSiteDAO();
				siteList.forEach(siteJson -> {
					Site siteNovo;
					siteNovo = parseObjSite((JSONObject) siteJson, site);
					nomeSite.add(siteNovo.getNome_site());
					if(cont == 0) {
						siteNovo.setId_iphone(fk_iphone_repetido);
						siteNovo.setNome_site(nomeSite.get(contSiteRepeat));
						try {
							siteDAO.createRepeat(siteNovo);
						} catch (SQLException e) {
							// TODO Auto-generated catch block
							e.printStackTrace();
						}
						cont++;
						contSiteRepeat++;
					}
				});
			} catch (SQLException | ClassNotFoundException | IOException e) {
				e.printStackTrace();
			}
		} catch (FileNotFoundException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		} catch (org.json.simple.parser.ParseException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		}
	}
	
	@SuppressWarnings("unchecked")
	private void criarPrecoRepetido(HttpServletRequest request, HttpServletResponse response, Integer fk_iphone_repetido) throws IOException {
		cont = 0;
		DAO<Preco> precoDAO;
		DAO<Site> siteDAO;
		Preco preco = new Preco();
		JSONParser jsonParserPreco = new JSONParser();
		try {
			String jsonName = request.getParameter("fileName");
			FileReader readerPreco = new FileReader(
					"C:/Users/gabri/eclipse-workspace/projetointegracao/WebContent/json/" + jsonName);
			Object objPreco = jsonParserPreco.parse(readerPreco);
			JSONArray precoList = (JSONArray) objPreco;
			precoList = (JSONArray) objPreco;
			try (DAOFactory daoFactory = DAOFactory.getInstance()) {
				precoDAO = daoFactory.getPrecoDAO();
				siteDAO = daoFactory.getSiteDAO();
				precoList.forEach(precoJson -> {
					Preco precoNovo;
					List<Site> sites = new ArrayList<Site>();
					precoNovo = parseObjPreco((JSONObject) precoJson, preco);
					try {
						sites = siteDAO.all();
						dataPreco.add(precoNovo.getData_preco());
						precoAntigo.add(precoNovo.getPreco_antigo());
						precoAtual.add(precoNovo.getPreco_atual());
						for(int i = 0; i < sites.size(); i++) {
							idAux = sites.get(i).getId_site();
						}
						if(cont == 0) {
							precoNovo.setId_iphone(fk_iphone_repetido);
							precoNovo.setId_site(idAux);
							precoNovo.setData_preco(dataPreco.get(contPrecoRepeat));
							precoNovo.setPreco_antigo(precoAntigo.get(contPrecoRepeat));
							precoNovo.setPreco_atual(precoAtual.get(contPrecoRepeat));
							precoDAO.createRepeat(precoNovo);
							cont++;
							contPrecoRepeat++; 
						}
					} catch (SQLException e) {
						e.printStackTrace();
					}
				});
			} catch (SQLException | ClassNotFoundException | IOException e) {
				e.printStackTrace();
			}
		} catch (FileNotFoundException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		} catch (org.json.simple.parser.ParseException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		}
	}
	
	@SuppressWarnings("unchecked")
	private void criarAvaliacaoRepetida(HttpServletRequest request, HttpServletResponse response, Integer fk_iphone_repetido) throws IOException {
		cont = 0;
		DAO<Avaliacao> avaliacaoDAO;
		Avaliacao avaliacao = new Avaliacao();
		JSONParser jsonParserAvaliacao = new JSONParser();
		try {
			String jsonName = request.getParameter("fileName");
			FileReader readerAvaliacao = new FileReader(
					"C:/Users/gabri/eclipse-workspace/projetointegracao/WebContent/json/" + jsonName);
			Object objAvaliacao = jsonParserAvaliacao.parse(readerAvaliacao);
			JSONArray avaliacaoList = (JSONArray) objAvaliacao;
			avaliacaoList = (JSONArray) objAvaliacao;
			try (DAOFactory daoFactory = DAOFactory.getInstance()) {
				avaliacaoDAO = daoFactory.getAvaliacaoDAO();
				avaliacaoList.forEach(avaliacaoJson -> {
					Avaliacao avaliacaoNova;
					avaliacaoNova = parseObjAvaliacao((JSONObject) avaliacaoJson, avaliacao);
					try {
						notaAvaliacao.add(avaliacaoNova.getNota_avaliacao());
						if(cont == 0) {
							avaliacaoNova.setId_iphone(fk_iphone_repetido);
							avaliacaoNova.setNota_avaliacao(notaAvaliacao.get(contAvaliacaoRepeat));
							avaliacaoDAO.createRepeat(avaliacaoNova);
							cont++;
							contAvaliacaoRepeat++; 
						}
					} catch (SQLException e) {
						e.printStackTrace();
					}
				});
			} catch (SQLException | ClassNotFoundException | IOException e) {
				e.printStackTrace();
			}
		} catch (FileNotFoundException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		} catch (org.json.simple.parser.ParseException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		}
		
	}

	@SuppressWarnings("unchecked")
	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {

		DAO<Iphone> iphoneDao;
		DAO<Site> siteDAO;
		DAO<Comentario> comentarioDAO;
		DAO<Preco> precoDAO;
		DAO<Camera> cameraDAO;
		DAO<Armazenamento> armazenamentoDAO;
		DAO<Avaliacao> avaliacaoDAO;

		Iphone iphone = new Iphone();
		Site site = new Site();
		Comentario comentario = new Comentario();
		Preco preco = new Preco();
		Camera camera = new Camera();
		Armazenamento armazenamento = new Armazenamento();
		Avaliacao avaliacao = new Avaliacao();
		RequestDispatcher dispatcher;
		HttpSession session = request.getSession();
		String servletPath = request.getServletPath();

		switch (request.getServletPath()) {
		case "/atualizarProduto": {
			try (DAOFactory daoFactory = DAOFactory.getInstance()) {
				Integer id_iphone = Integer.parseInt(request.getParameter("id_iphone"));
				String titulo = request.getParameter("titulo");
				String modelo = request.getParameter("modelo");
				String sistema_operacional = request.getParameter("sistema_operacional");
				String cor = request.getParameter("cor");
				String processador = request.getParameter("processador");
				String tipo_chip = request.getParameter("tipo_chip");
				String conectividade = request.getParameter("conectividade");
				String bateria = request.getParameter("bateria");
				String peso = request.getParameter("peso");
				String dimensao_produto = request.getParameter("dimensao_produto");
				String resolucao_tela = request.getParameter("resolucao_tela");
				String tamanho_tela = request.getParameter("tamanho_tela");
				String itens_inclusos = request.getParameter("itens_inclusos");
				String garantia = request.getParameter("garantia");
				String resolucao_camera = request.getParameter("resolucao_camera");
				String capacidade_armazenamento = request.getParameter("capacidade_armazenamento");
				
				iphone.setId_iphone(id_iphone);
				camera.setId_camera(id_iphone);
				armazenamento.setId_armazenamento(id_iphone);
				iphone.setTitulo(titulo);
				iphone.setModelo(modelo);
				iphone.setSistema_operacional(sistema_operacional);
				iphone.setCor(cor);
				iphone.setProcessador(processador);
				iphone.setTipo_chip(tipo_chip);
				iphone.setConectividade(conectividade);
				iphone.setBateria(bateria);
				iphone.setPeso(peso);
				iphone.setDimensao_produto(dimensao_produto);
				iphone.setResolucao_tela(resolucao_tela);
				iphone.setTamanho_tela(tamanho_tela);
				iphone.setItens_inclusos(itens_inclusos);
				iphone.setGarantia(garantia);
				iphone.setResolucao_tela(resolucao_tela);
				camera.setResolucao_camera(resolucao_camera);
				armazenamento.setCapacidade_armazenamento(capacidade_armazenamento);

				iphoneDao = daoFactory.getIphoneDAO();
				cameraDAO = daoFactory.getCameraDAO();
				armazenamentoDAO = daoFactory.getArmazenamentoDAO();

				if (servletPath.equals("/adicionarProduto")) {
					// iphoneDao.create(iphone);
				} else {
					servletPath += "?id_iphone=" + String.valueOf(iphone.getId_iphone());
					armazenamentoDAO.update(armazenamento);
					cameraDAO.update(camera);
					iphoneDao.update(iphone);
				}

				response.sendRedirect(request.getContextPath() + "/");
				break;
			} catch (SQLException e) {
				e.printStackTrace();
			} catch (ClassNotFoundException e1) {
				e1.printStackTrace();
			}
			break;
		}
	
		case "/adicionarProduto": {
			JSONParser jsonParserIphone = new JSONParser();
			JSONParser jsonParserSite = new JSONParser();
			JSONParser jsonParserPreco = new JSONParser();
			JSONParser jsonParserCamera = new JSONParser();
			JSONParser jsonParserArmazenamento = new JSONParser();
			JSONParser jsonParserComentario = new JSONParser();
			JSONParser jsonParserAvaliacao = new JSONParser();
			
			try {
				String jsonName = request.getParameter("fileName");
				FileReader readerIphone = new FileReader(
						"C:/Users/gabri/eclipse-workspace/projetointegracao/WebContent/json/" + jsonName);
				FileReader readerSite = new FileReader(
						"C:/Users/gabri/eclipse-workspace/projetointegracao/WebContent/json/" + jsonName);
				FileReader readerPreco = new FileReader(
						"C:/Users/gabri/eclipse-workspace/projetointegracao/WebContent/json/" + jsonName);
				FileReader readerCamera = new FileReader(
						"C:/Users/gabri/eclipse-workspace/projetointegracao/WebContent/json/" + jsonName);
				FileReader readerArmazenamento = new FileReader(
						"C:/Users/gabri/eclipse-workspace/projetointegracao/WebContent/json/" + jsonName);
				FileReader readerComentario = new FileReader(
						"C:/Users/gabri/eclipse-workspace/projetointegracao/WebContent/json/" + jsonName);
				FileReader readerAvaliacao = new FileReader(
						"C:/Users/gabri/eclipse-workspace/projetointegracao/WebContent/json/" + jsonName);

				Object objIphone = jsonParserIphone.parse(readerIphone);
				Object objSite = jsonParserSite.parse(readerSite);
				Object objPreco = jsonParserPreco.parse(readerPreco);
				Object objCamera = jsonParserCamera.parse(readerCamera);
				Object objArmazenamento = jsonParserArmazenamento.parse(readerArmazenamento);
				Object objComentario = jsonParserComentario.parse(readerComentario);
				Object objAvaliacao = jsonParserAvaliacao.parse(readerAvaliacao);

				JSONArray iphoneList = (JSONArray) objIphone;
				JSONArray siteList = (JSONArray) objSite;
				JSONArray precoList = (JSONArray) objPreco;
				JSONArray cameraList = (JSONArray) objCamera;
				JSONArray armazenamentoList = (JSONArray) objArmazenamento;
				JSONArray comentarioList = (JSONArray) objComentario;
				JSONArray avaliacaoList = (JSONArray) objAvaliacao;

				try (DAOFactory daoFactory = DAOFactory.getInstance()) {
					iphoneDao = daoFactory.getIphoneDAO();
					siteDAO = daoFactory.getSiteDAO();
					precoDAO = daoFactory.getPrecoDAO();
					comentarioDAO = daoFactory.getComentarioDAO();
					cameraDAO = daoFactory.getCameraDAO();
					armazenamentoDAO = daoFactory.getArmazenamentoDAO();
					avaliacaoDAO = daoFactory.getAvaliacaoDAO();

					// Iteração sobre os dados do iphone
					iphoneList.forEach(iphoneJson -> {
						contIntegracao = 0;
						Integer contador = 0;
						List<Iphone> iphonesExistentes = new ArrayList<Iphone>();
						Iphone iphoneNovo;
						Integer fk_iphone_repetido = null;
						try {
							iphoneNovo = parseObjIphone((JSONObject) iphoneJson, iphone);
							iphonesExistentes = iphoneDao.all();
							if (iphonesExistentes.size() == 0) {
								iphoneDao.create(iphoneNovo);
							} else {
								for (int i = 0; i < iphonesExistentes.size(); i++) {
									if (iphonesExistentes.get(i).getModelo().equals(iphoneNovo.getModelo())) {
										contador++;
									}
								}
								if (contador == 0) {
									iphoneNaoExiste(flgExiste); // Seta pra false
									iphoneDao.create(iphoneNovo);
								} else {
									iphoneExiste(flgExiste); // Seta pra true
									for(int i = 0; i < iphonesExistentes.size(); i++) {
										if (iphonesExistentes.get(i).getModelo().equals(iphoneNovo.getModelo())) {
											fk_iphone_repetido = iphonesExistentes.get(i).getId_iphone();
										}
									}
									if(contIntegracao == 0) {
										iphoneDao.integrarCaracteristicas(iphoneNovo, fk_iphone_repetido, iphonesExistentes);
										contIntegracao++;
									}
									criarSiteRepetido(request, response, fk_iphone_repetido);
									criarPrecoRepetido(request, response, fk_iphone_repetido);
									criarAvaliacaoRepetida(request, response, fk_iphone_repetido);
								}

							}
						} catch (SQLException | IOException e) {
							e.printStackTrace();
						}
					});
					
					contPrecoRepeat = 0;
					contSiteRepeat = 0;
					contAvaliacaoRepeat = 0;
					nomeSite = new ArrayList<String>();
					dataPreco = new ArrayList<String>();
					precoAntigo = new ArrayList<Double>();
					precoAtual = new ArrayList<Double>();
					

					siteList.forEach(siteJson -> {
						Site siteNovo;
						if (getFlg(flgExiste) == false) {
							siteNovo = parseObjSite((JSONObject) siteJson, site);
							try {
								siteDAO.create(siteNovo);
							} catch (SQLException e) {
								// TODO Auto-generated catch block
								e.printStackTrace();
							}
						}
					});

					// Iteração sobre os dados do preco
					
					precoList.forEach(precoJson -> {
						Preco precoNovo;
						List<Site> sites = new ArrayList<Site>();
						
						try {
							precoNovo = parseObjPreco((JSONObject) precoJson, preco);
							sites = siteDAO.all();
							if (getFlg(flgExiste) == false) {
								precoNovo.setId_site(sites.get(contPreco).getId_site());
								contPreco++;
								precoDAO.create(precoNovo);
							} 

						} catch (SQLException e) {
							e.printStackTrace();
						}
					});
					
					contPreco = 0;

					// Iteração sobre os dados da camera
					cameraList.forEach(cameraJson -> {
						Camera cameraNovo;
						if (getFlg(flgExiste) == false) {
							cameraNovo = parseObjCamera((JSONObject) cameraJson, camera);
							try {
								cameraDAO.create(cameraNovo);
							} catch (SQLException e) {
								// TODO Auto-generated catch block
								e.printStackTrace();
							}
						}
					});

					// Iteração sobre os dados do armazenamento
					armazenamentoList.forEach(armazenamentoJson -> {
						Armazenamento armazenamentoNovo;
						if (getFlg(flgExiste) == false) {
							armazenamentoNovo = parseObjArmazenamento((JSONObject) armazenamentoJson,
									armazenamento);
							try {
								armazenamentoDAO.create(armazenamentoNovo);
							} catch (SQLException e) {
								// TODO Auto-generated catch block
								e.printStackTrace();
							}
						}
					});

					// Iteração sobre os dados do comentario
					comentarioList.forEach(comentarioJson -> {
						Comentario comentarioNovo;
						if (getFlg(flgExiste) == false) {
							comentarioNovo = parseObjComentario((JSONObject) comentarioJson, comentario);
							try {
								comentarioDAO.create(comentarioNovo);
							} catch (SQLException e) {
								// TODO Auto-generated catch block
								e.printStackTrace();
							}
						}
					});
					
					// Iteração sobre os dados de avaliação
					avaliacaoList.forEach(avaliacaoJson -> {
						Avaliacao avaliacaoNova;
						if (getFlg(flgExiste) == false) {
							avaliacaoNova = parseObjAvaliacao((JSONObject) avaliacaoJson, avaliacao);
							try {
								avaliacaoDAO.create(avaliacaoNova);
							} catch (SQLException e) {
								// TODO Auto-generated catch block
								e.printStackTrace();
							}
						}
					});
				} catch (SQLException | ClassNotFoundException | IOException e) {
					e.printStackTrace();
				}
			} catch (FileNotFoundException e) {
				e.printStackTrace();
			} catch (IOException e) {
				e.printStackTrace();
			} catch (org.json.simple.parser.ParseException e1) {
				// TODO Auto-generated catch block
				e1.printStackTrace();
			}
			response.sendRedirect(request.getContextPath());
		}
		}
	}
}
