<?php
include 'functions.php';

// Verificar se o formulário foi enviado
if ($_SERVER["REQUEST_METHOD"] == "POST") {
    // Conectar ao banco de dados
    $pdo = pdo_connect_pgsql();

    // Preparar a inserção dos dados do horário de funcionamento
    $stmt = $pdo->prepare('INSERT INTO horario_funcionamento (dia_semana, horario_abertura, horario_fechamento) VALUES (:dia_semana, :horario_abertura, :horario_fechamento)');
    $stmt->bindValue(':dia_semana', $_POST['dia_semana'], PDO::PARAM_STR);
    $stmt->bindValue(':horario_abertura', $_POST['horario_abertura'], PDO::PARAM_STR);
    $stmt->bindValue(':horario_fechamento', $_POST['horario_fechamento'], PDO::PARAM_STR);
    $stmt->execute();

    // Redirecionar após a inserção
    header('Location: ler_horario.php');
    exit;
}
?>
<?=template_header('Criar Horário de Funcionamento')?>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Criar Horário de Funcionamento</title>
</head>
<body>
    <h1>Criar Horário de Funcionamento</h1>
    <form method="post">
        <label for="dia_semana">Dia da Semana:</label>
        <input type="text" id="dia_semana" name="dia_semana" required><br>
        <label for="horario_abertura">Horário de Abertura:</label>
        <input type="time" id="horario_abertura" name="horario_abertura" required><br>
        <label for="horario_fechamento">Horário de Fechamento:</label>
        <input type="time" id="horario_fechamento" name="horario_fechamento" required><br>
        <button type="submit">Salvar</button>
    </form>
</body>
</html>
<?=template_footer()?>
