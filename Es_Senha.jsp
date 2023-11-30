<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>
<!DOCTYPE html>
<html lang="pt">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Recuperação de Senha</title>
    <link rel="stylesheet" href="style.css" />
</head>
<body class="bg">
    <div class="es-senha-container">
        <h2>Recuperação de Senha</h2>
        <form action="atualizarSenha.jsp" method="post" id="recuperarSenhaForm">
            <label for="email">E-mail:</label>
            <input type="email" id="email" name="email" required />

            <label for="senha">Nova Senha:</label>
            <input type="password" id="senha" name="senha" required />

            <label for="confirmar-senha">Confirmar Nova Senha:</label>
            <input type="password" id="confirmar-senha" name="confirmar-senha" required />

            <button type="button" onclick="validarRecuperacaoSenha()">Recuperar Senha</button>
        </form>

        <div class="options">
            <a href="login.jsp">Voltar para o Login</a>
        </div>
    </div>

    <script>
        function validarRecuperacaoSenha() {
            var novaSenha = document.getElementById("senha").value;
            var confirmarNovaSenha = document.getElementById("confirmar-senha").value;

            if (novaSenha !== confirmarNovaSenha) {
                alert("As senhas não coincidem. Por favor, verifique.");
            } else {
                document.getElementById("recuperarSenhaForm").submit();
            }
        }
    </script>
</body>
</html>
