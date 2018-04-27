<%@page import="modelo.Categoria"%>
<%@page import="dao.CategoriaDAO"%>
<%@page import="dao.EditoraDAO"%>
<%@page import="modelo.Editora"%>
<%@page import="dao.LivroDAO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="modelo.Autor"%>
<%@page import="java.util.Date"%>
<%@page import="modelo.Livro"%>
<%@page import="modelo.Autor"%>
<%@page import="dao.AutorDAO"%>
<%@page import="java.math.BigDecimal"%>

<%@page import="java.util.List"%>

<%@include file="../cabecalho.jsp" %>
<%
    String msg = "";
    String classe = "";
    AutorDAO adao = new AutorDAO();
    EditoraDAO edao = new EditoraDAO();
    CategoriaDAO cdao = new CategoriaDAO();
    if (request.getMethod().equals("POST")) {
        if (request.getParameter("txtNome") != null) {
            //pego uma lista de autores(com mesmo name)
            String[] autoresid = request.getParameter("autores").split(";");

            //popular o livro
            Livro l = new Livro();
            l.setNome(request.getParameter("txtNome"));
            l.setPreco(Float.parseFloat(request.getParameter("txtPreco")));
            l.setDatapublicacao(new Date());
            l.setCategoria();
            //l.setCategoria(categoria);
            l.setPreco(13.12f);
            //Autores
            List<Autor> listaautores = new ArrayList<>();
            for (String id : autoresid) {
                Integer idinteger = Integer.parseInt(id);
                listaautores.add(adao.buscarPorChavePrimaria(idinteger));
            }
            l.setAutorList(listaautores);
            
            

            LivroDAO dao = new LivroDAO();
            dao.incluir(l);
        }

    }

    //pego meus autores
    List<Autor> autores = adao.listar();
    List<Editora> editoras = edao.listar();
    List<Categoria> categorias = cdao.listar();
%>
<div class="row">
    <div class="col-lg-12">
        <h1 class="page-header">
            Sistema de Comércio Eletrônico
            <small>Admin</small>
        </h1>
        <ol class="breadcrumb">
            <li>
                <i class="fa fa-dashboard"></i>  <a href="index.jsp">Área Administrativa</a>
            </li>
            <li class="active">
                <i class="fa fa-file"></i> Aqui vai o conteúdo de apresentação 
            </li>
        </ol>
    </div>
</div>
<!-- /.row -->
<div class="row">
    <div class="panel panel-default">
        <div class="panel-heading">
            Categorias
        </div>
        <div class="panel-body">

            <div class="alert <%=classe%>">
                <%=msg%>
            </div>
            <form action="../UploadWS" method="post" enctype="multipart/form-data">

                <div class="col-lg-6">

                    <div class="form-group">
                        <label>Nome</label>
                        <input class="form-control" type="text"  name="txtNome"  required />
                    </div>

                    <div class="form-group">
                        <label>Preço</label>
                        <input class="form-control" type="text"  name="txtPreco"  required />
                    </div>

                    <div class="form-group">
                        <label>Data Publicação</label>
                        <input class="form-control" type="text"  name="txtDataPublicacao"  required />
                    </div>

                    <div class="form-group">
                        <label>Categorias</label>

                        <%for (Categoria c : categorias) {%>
                        <input type="checkbox" name="categorias" value="<%=c.getId()%>"><%=c.getNome()%>

                        <%}%>
                    </div>

                    <div class="form-group">
                        <label>Editora</label>

                        <%for (Editora e : editoras) {%>
                        <input type="checkbox" name="editoras" value="<%=e.getCnpj()%>"><%=e.getNome()%>

                        <%}%>
                    </div>

                    <div class="form-group">
                        <label>Imagem 1</label>
                        <input class="form-control" type="text"  name="txtImg1"  required />
                    </div>

                    <div class="form-group">
                        <label>Imagem 2</label>
                        <input class="form-control" type="text"  name="txtImg2"  required />
                    </div>

                    <div class="form-group">
                        <label>Imagem 3</label>
                        <input class="form-control" type="text"  name="txtImg3"  required />
                    </div>

                    <div class="form-group">
                        <label>Sinopse</label>

                        <TextArea class="form-control" name="txtSinopse"></TextArea>
                    </div>
                    
                    <div class="form-group">
                        <label>Autores</label>

                        <%for (Autor a : autores) {%>
                        <input type="checkbox" name="autores" value="<%=a.getId()%>"><%=a.getNome()%>

                        <%}%>
                    </div>
                    
                    

                    <button class="btn btn-primary btn-sm" type="submit">Salvar</button>


                </div>
            </form>


        </div>
    </div>
    <!-- 1/.row -->
    <%@include file="../rodape.jsp" %>