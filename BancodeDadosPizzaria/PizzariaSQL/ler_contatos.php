<?php
include 'functions.php';

// Conectar ao banco de dados
$pdo = pdo_connect_pgsql();

// Obter os contatos do banco de dados
$stmt = $pdo->query('SELECT * FROM contatos');
$contatos = $stmt->fetchAll(PDO::FETCH_ASSOC);
?>

<?=template_header('Visualizar Contatos')?>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Ler Contatos</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            text-align: center;
        }
        h1 {
            margin-top: 20px;
        }
        table {
            margin: 0 auto;
            border-collapse: collapse;
            width: 80%;
        }
        th, td {
            border: 1px solid #dddddd;
            padding: 8px;
        }
        th {
            background-color: #f2f2f2;
        }
        tr:nth-child(even) {
            background-color: #f2f2f2;
        }
        tr:hover {
            background-color: #ddd;
        }
    </style>
</head>
<body>
    <h1>Contatos</h1>
    <table>
        <thead>
            <tr>
                <th>Nome</th>
                <th>Email</th>
            
            </tr>
        </thead>
        <tbody>
            <?php foreach ($contatos as $contato): ?>
            <tr>
                <td><?=$contato['nome']?></td>
                <td><?=$contato['email']?></td>
                
            </tr>
            <?php endforeach; ?>
        </tbody>
    </table>
</body>
</html>
<?=template_footer()?>
