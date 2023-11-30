<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>
<!DOCTYPE html>
<html lang="pt">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Atualizar Senha</title>
    <link rel="stylesheet" href="style.css" />
</head>
<body class="bg">

<%
    // Verifica se o formulário foi submetido
    if (request.getMethod().equals("POST")) {
        // Recebendo dados do formulário
        String email = request.getParameter("email");
        String novaSenha = request.getParameter("senha");

        // Configurar a conexão com o banco de dados aqui
        Connection conexao = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        try {
            Class.forName("com.mysql.jdbc.Driver");
            conexao = DriverManager.getConnection("jdbc:mysql://localhost:3306/cadastro", "root", "");

            // Verificar se o e-mail existe no banco
            String verificarEmailSQL = "SELECT * FROM usuario WHERE email=?";
            stmt = conexao.prepareStatement(verificarEmailSQL);
            stmt.setString(1, email);
            rs = stmt.executeQuery();

            if (rs.next()) { // E-mail encontrado, pode prosseguir com a atualização da senha
                // Atualização de senha no banco de dados
                String atualizarSenhaSQL = "UPDATE usuario SET senha=? WHERE email=?";
                stmt = conexao.prepareStatement(atualizarSenhaSQL);
                stmt.setString(1, novaSenha);
                stmt.setString(2, email);
                int rowsAffected = stmt.executeUpdate();

                if (rowsAffected > 0) {
                    out.println("<p>Senha atualizada com sucesso!</p>");
                } else {
                    out.println("<p>Falha ao atualizar a senha. Tente novamente mais tarde.</p>");
                }
            } else { // E-mail não encontrado no banco
                out.println("<p>E-mail não encontrado. Verifique o e-mail informado.</p>");
            }
        } catch (Exception ex) {
            ex.printStackTrace();
            out.println("Erro: " + ex.toString());
        } finally {
            // Certifique-se de fechar a conexão e os statements no bloco finally para garantir que sejam sempre fechados
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

<div class="options">
    <a href="login.jsp">Voltar para o Login</a>
</div>

</body>
</html>
