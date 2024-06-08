<?php
include 'functions.php';
$pdo = pdo_connect_pgsql();

// Consulta SQL para selecionar todos os pedidos ordenados pela data de cadastro em ordem decrescente
$stmt = $pdo->query('SELECT * FROM contatos ORDER BY cadastro DESC');
$pedidos = $stmt->fetchAll(PDO::FETCH_ASSOC);
?>

<?= template_header('Todos os Pedidos') ?>

<div class="content read">
    <h2>Todos os Pedidos</h2>
    <table>
        <thead>
            <tr>
                <th>ID</th>
                <th>Nome</th>
                <th>Email</th>
                <th>Celular</th>
                <th>Pizza</th>
                <th>Data do Pedido</th>
            </tr>
        </thead>
        <tbody>
            <?php foreach ($pedidos as $pedido) : ?>
                <tr>
                    <td><?= $pedido['id_contato'] ?></td>
                    <td><?= $pedido['nome'] ?></td>
                    <td><?= $pedido['email'] ?></td>
                    <td><?= $pedido['cel'] ?></td>
                    <td><?= $pedido['pizza'] ?></td>
                    <td><?= date('d/m/Y H:i:s', strtotime($pedido['cadastro'])) ?></td>
                </tr>
            <?php endforeach; ?>
        </tbody>
    </table>
</div>

<?= template_footer() ?>
