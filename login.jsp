<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>
<!DOCTYPE html>
<html lang="pt">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Login</title>
    <link rel="stylesheet" href="style.css" />
</head>
<body class="bg">
    <div class="login-container">
        <h2>Login</h2>
        <form action="login.jsp" method="post">
            <label for="email">E-mail:</label>
            <input type="email" id="email" name="email" required />

            <label for="senha">Senha:</label>
            <input type="password" id="senha" name="senha" required />

            <button type="submit">Entrar</button>
        </form>

        <div class="options">
            <a href="Es_Senha.jsp">Esqueci a senha</a>
            <span class="divider">|</span>
            <a href="cadastro_usu.jsp">Cadastrar</a>
        </div>
    </div>

    <%
        // Verifica se o formulário foi submetido
        if (request.getMethod().equals("POST")) {
            // Recebendo dados do formulário
            String email = request.getParameter("email");
            String senha = request.getParameter("senha");

            // configurar a conexão com o banco de dados aqui
            Connection conexao = null;
            PreparedStatement stmt = null;
            ResultSet rs = null;
            try {
                Class.forName("com.mysql.jdbc.Driver");
                conexao = DriverManager.getConnection("jdbc:mysql://localhost:3306/cadastro", "root", "");

                // consulta no banco de dados
                String sql = "SELECT * FROM usuario WHERE email=? AND senha=?";
                stmt = conexao.prepareStatement(sql);
                stmt.setString(1, email);
                stmt.setString(2, senha);
                rs = stmt.executeQuery();

                // Verifica se o resultado da consulta tem pelo menos uma linha
                if (rs.next()) {
                    // Usuário autenticado, redireciona para a Tela_Principal.html
                    response.sendRedirect("Tela_Principal.html");
                } else {
                    // Usuário não autenticado
                    out.println("<p>Email ou senha incorretos. Tente novamente.</p>");
                }

            } catch (Exception ex) {
                ex.printStackTrace();
                out.println("Erro: " + ex.toString());
            } finally {
                // Certifique-se de fechar a conexão, statement e resultSet no bloco finally para garantir que sejam sempre fechados
                if (rs != null) {
                    try {
                        rs.close();
                    } catch (SQLException e) {
                        e.printStackTrace();
                    }
                }
                if (stmt != null) {
                    try {
                        stmt.close();
                    } catch (SQLException e) {
                        e.printStackTrace();
                    }
                }
                if (conexao != null) {
                    try {
                        conexao.close();
                    } catch (SQLException e) {
                        e.printStackTrace();
                    }
                }
            }
        }
    %>

</body>
</html>
