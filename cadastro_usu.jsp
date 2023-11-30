<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="CulinariaClick.Usu"%>
<%@page import="java.sql.*"%>
<!DOCTYPE html>
<html lang="pt">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Cadastro</title>
    <link rel="stylesheet" href="style.css" />
    <script>
        function validarSenhas() {
            var senha = document.getElementById("senha").value;
            var confirmarSenha = document.getElementById("confirmar-senha").value;
            var avisoSenha = document.getElementById("aviso-senha");

            if (senha !== confirmarSenha) {
                avisoSenha.innerHTML = "As senhas não coincidem. Por favor, verifique.";
            } else {
                avisoSenha.innerHTML = "";
            }
        }
    </script>
</head>
<body class="bg">
    <div class="cadastro-container">
        <h2>Cadastro</h2>
        <form action="cadastro_usu.jsp" method="post" onsubmit="return validarFormulario()">
            <label for="nome">Nome:</label>
            <input type="text" id="nome" name="nome" required />

            <label for="email">E-mail:</label>
            <input type="email" id="email" name="email" required />

            <label for="senha">Senha:</label>
            <input type="password" id="senha" name="senha" required />

            <label for="confirmar-senha">Confirmar Senha:</label>
            <input type="password" id="confirmar-senha" name="confirmar-senha" required oninput="validarSenhas()" />

            <span id="aviso-senha" style="color: red;"></span>

            <button type="submit">Cadastrar</button>
        </form>

        <div class="options">
            <a href="Es_Senha.jsp">Esqueci a senha</a>
            <span class="divider">|</span>
            <a href="login.jsp">Voltar para o Login</a>
        </div>
    </div>
   
    <%
        // Verifica se o formulário foi submetido
        if (request.getMethod().equals("POST")) {
            // Recebendo dados do formulário
            String nome = request.getParameter("nome");
            String email = request.getParameter("email");
            String senha = request.getParameter("senha");

            // objeto Usu com os dados do usuário
            Usu usuario = new Usu();
            usuario.setNome(nome);
            usuario.setEmail(email);
            usuario.setSenha(senha);

            // configurar a conexão com o banco de dados aqui
            try {
                Class.forName("com.mysql.jdbc.Driver");
                Connection conexao = DriverManager.getConnection("jdbc:mysql://localhost:3306/cadastro", "root", "");
                Statement stmt = conexao.createStatement();

                // inserção de dados no banco de dados
                String sql = "INSERT INTO usuario (nome, email, senha) VALUES ('"
                        + usuario.getNome() + "', '"
                        + usuario.getEmail() + "', '"
                        + usuario.getSenha() + "')";

                stmt.executeUpdate(sql);
                conexao.close();

                // Exibir mensagem de sucesso após o cadastro
                out.println("<p>Usuário cadastrado com sucesso! Por favor faça seu login.</p>");
            } catch (Exception ex) {
                ex.printStackTrace();
                out.println("Erro: " + ex.toString());
            }
        }
    %>

</body>
</html>
