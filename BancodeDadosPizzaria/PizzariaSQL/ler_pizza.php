<?php
include 'functions.php';

// Conectar ao banco de dados PostgreSQL
$pdo = pdo_connect_pgsql();

// Obter os sabores das pizzas
$stmt = $pdo->query('SELECT * FROM pizzas');
$pizzas = $stmt->fetchAll(PDO::FETCH_ASSOC);
?>

<?=template_header('Lista de Pizzas')?>

<div class="content read">
    <h2>Lista de Pizzas</h2>
    <table>
        <thead>
            <tr>
                <th>ID</th>
                <th>Nome</th>
                <th>Preço</th>
                <th>Ingredientes</th>
            </tr>
        </thead>
        <tbody>
            <?php foreach ($pizzas as $pizza): ?>
            <tr>
                <td><?=$pizza['id_pizza']?></td>
                <td><?=$pizza['nome']?></td>
                <td><?=$pizza['preco']?></td>
                <td><?=$pizza['ingredientes']?></td>
            </tr>
            <?php endforeach; ?>
        </tbody>
    </table>
</div>

<?=template_footer()?>
