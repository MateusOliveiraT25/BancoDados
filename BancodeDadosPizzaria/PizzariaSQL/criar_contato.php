<?php
include 'functions.php';

// Verificar se o formulário foi enviado
if ($_SERVER["REQUEST_METHOD"] == "POST") {
    // Conectar ao banco de dados
    $pdo = pdo_connect_pgsql();

    // Preparar a inserção dos dados do contato
    $stmt = $pdo->prepare('INSERT INTO contatos (nome, email, telefone) VALUES (:nome, :email, :telefone)');
    $stmt->bindValue(':nome', $_POST['nome'], PDO::PARAM_STR);
    $stmt->bindValue(':email', $_POST['email'], PDO::PARAM_STR);
    $stmt->bindValue(':telefone', $_POST['telefone'], PDO::PARAM_STR);
    $stmt->execute();

    // Redirecionar após a inserção
    header('Location: ler_contatos.php');
    exit;
}
?>
<?=template_header('Contatos')?>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Criar Contato</title>
</head>
<body>
    <h1>Criar Contato</h1>
    <form method="post">
        <label for="nome">Nome:</label>
        <input type="text" id="nome" name="nome" required><br>
        <label for="email">Email:</label>
        <input type="email" id="email" name="email" required><br>
        <label for="telefone">Telefone:</label>
        <input type="text" id="telefone" name="telefone" required><br>
        <button type="submit">Salvar</button>
    </form>
</body>
</html>


<?=template_footer()?>