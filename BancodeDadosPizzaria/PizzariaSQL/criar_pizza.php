<?php
include 'functions.php';

if ($_SERVER["REQUEST_METHOD"] == "POST") {
    // Verificar se o formulário foi enviado
    if(isset($_POST['submit'])) {
        // Conectar ao banco de dados PostgreSQL
        $pdo = pdo_connect_pgsql();

        // Inserir nova pizza na tabela
        $stmt = $pdo->prepare('INSERT INTO pizzas (sabor) VALUES (:sabor)');
        $stmt->bindValue(':sabor', $_POST['sabor']);
        $stmt->execute();

        // Redirecionar para a página de visualização de pizzas
        header("Location: ler_pizza.php");
        exit;
    }
}
?>

<?=template_header('Criar Pizza')?>

<div class="content update">
    <h2>Criar Pizza</h2>
    <form action="" method="post">
        <label for="sabor">Sabor:</label>
        <input type="text" name="sabor" id="sabor" required>
        <input type="submit" value="Criar" name="submit">
    </form>
</div>

<?=template_footer()?>
