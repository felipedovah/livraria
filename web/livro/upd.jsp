<%@page import="dao.EditoraDAO"%>
<%@page import="dao.AutorDAO"%>
<%@page import="modelo.Editora"%>
<%@page import="java.util.List"%>
<%@page import="modelo.Autor"%>
<%@page import="java.math.BigDecimal"%>
<%@page import="modelo.Categoria"%>
<%@page import="dao.CategoriaDAO"%>
<%@include file="../cabecalho.jsp" %>
<%
String msg ="";
String classe = "";
    
    CategoriaDAO dao = new CategoriaDAO();
    Categoria obj = new Categoria();
    
    AutorDAO adao = new AutorDAO();
    EditoraDAO edao = new EditoraDAO();
    //verifica se é postm ou seja, quer alterar
    if(request.getMethod().equals("POST")){ 
        //popular com oq ele digitou no form    
        obj.setNome(request.getParameter("txtNome"));
        obj.setId(Integer.parseInt(request.getParameter("codigo")));
        
        Boolean resultado = dao.alterar(obj);
        dao.fecharConexao();
        
        if(resultado){
            msg = "Registro alterado com sucesso";
            classe = "alert-success";
        }
        else{
            msg = "Não foi possível alterar";
            classe = "alert-danger";
        }
        
    }else{
        //e GET
        if(request.getParameter("codigo") == null){
            response.sendRedirect("index.jsp");
            return;
        }
        
        dao = new CategoriaDAO();
        obj = dao.buscarPorChavePrimaria(Integer.parseInt(request.getParameter("codigo")));
        
        if(obj == null){
            response.sendRedirect("index.jsp");
            return;
        } 
    }
    
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
            Categoria
        </div>
        <div class="panel-body">

            <div class="alert <%=classe%>">
                <%=msg%>
            </div>
            <form action="#" method="post">
                
                <div class="col-lg-6">

                    <div class="form-group">
                        <label>Código</label>
                        <input class="form-control" type="text" name="txtCodigo" readonly value="<%=obj.getId()%>"/>
                    </div>
                    
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
                        <label>Categoria</label>
                        <input class="form-control" type="text"  name="txtCategoria"  required />
                    </div>
                    
                    <div class="form-group">
                        <label>Editora</label>
                        <input class="form-control" type="text"  name="txtEditora"  required />
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
                        <label>Imagem 3</label>
                        <input class="form-control" type="text"  name="txtImg3"  required />
                        <TextArea name="txtSinopse"></TextArea>
                    </div>
                    
                    <div class="form-group">
                        <label>Autores</label>

                        <%for (Autor a : autor) {%>
                        <input type="checkbox" name="autoreschk" value="<%=a.getId()%>"><%=a.getNome()%>

                        <%}%>
                    </div>


                <button class="btn btn-primary btn-sm" type="submit">Salvar</button>
                
            </form>

        </div>


    </div>
</div>
<!-- /.row -->
<%@include file="../rodape.jsp" %>