<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="pt">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>CulinariaClick</title>
    <link rel="stylesheet" href="style.css" />
</head>
<body class="bg">
    <header class="max-width" id="home">
        <div class="container">
            <div class="menu">
                <div class="logo"></div>
                <div class="desktop-menu">
                    <ul>
                        <li><a href="#">Pesquisar</a></li>
                        <li><a href="#">Sair</a></li>
                    </ul>
                </div>
            </div>
            <div class="call">
                <div class="left">
                    <img src="diagrama7.png" alt="" />
                </div>

                <div class="right">
                    <h1 class="color-preto text-gd">Culinaria Click</h1>
                </div>
            </div>
            <div class="search-box">
                <h1 class="color-preto text-md">Pesquise sua Receita</h1>
                <form action="Tela_Principal.jsp" method="get">
                    <input type="text" name="search" placeholder="Pesquisar..." />
                    <button type="submit">Buscar</button>
                </form>

                <%
                    String searchTerm = request.getParameter("search");

                    if (searchTerm != null && !searchTerm.isEmpty()) {
                        try {
                            // Configurar a conexão com o banco de dados
                            Class.forName("com.mysql.cj.jdbc.Driver");
                            String url = "jdbc:mysql://localhost:3306/cadastro";
                            String usuario = "root";
                            String senha = "";

                            Connection conexao = DriverManager.getConnection(url, usuario, senha);
                            Statement stmt = conexao.createStatement();

                            // Consultar os dados do banco de dados com base no termo de pesquisa
                            String sql = "SELECT * FROM receitas WHERE nome_receita LIKE '%" + searchTerm + "%'";
                            ResultSet rs = stmt.executeQuery(sql);
                %>

                            <table border="1">
                                <tr>
                                    <th>ID</th>
                                    <th>Nome da Receita</th>
                                    <!-- Adicione outras colunas aqui conforme necessário -->
                                </tr>

                                <%
                                    while (rs.next()) {
                                %>
                                        <tr>
                                            <td><%= rs.getInt("id") %></td>
                                            <td><%= rs.getString("nome_receita") %></td>
                                            <!-- Adicione outras colunas aqui conforme necessário -->
                                        </tr>
                                <%
                                    }
                                    // Fechar a conexão
                                    rs.close();
                                    stmt.close();
                                    conexao.close();
                                } catch (Exception ex) {
                                    ex.printStackTrace();
                                    out.println("Erro: " + ex.toString());
                                }
                            }
                %>
                            </table>
            </div>
        </div>
    </header>
    <script>
        document.addEventListener("DOMContentLoaded", function () {
            const searchInput = document.querySelector(".search-box input");
            const searchButton = document.querySelector(".search-box button");

            searchButton.addEventListener("click", function () {
                searchInput.value = "";
            });
        });
    </script>
</body>
</html>
