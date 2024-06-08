<?php
include 'functions.php';

// Conectar ao banco de dados
$pdo = pdo_connect_pgsql();

// Obter os horários de funcionamento do banco de dados
$stmt = $pdo->query('SELECT * FROM horario_funcionamento');
$horarios = $stmt->fetchAll(PDO::FETCH_ASSOC);
?>

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
<?=template_header('Horários de Funcionamento')?>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Ler Horários de Funcionamento</title>
</head>
<body>
    <h1>Horários de Funcionamento</h1>
    <table>
        <thead>
            <tr>
                <th>Dia da Semana</th>
                <th>Horário de Abertura</th>
                <th>Horário de Fechamento</th>
            </tr>
        </thead>
        <tbody>
            <?php foreach ($horarios as $horario): ?>
            <tr>
                <td><?=$horario['dia_semana']?></td>
                <td><?=$horario['horario_abertura']?></td>
                <td><?=$horario['horario_fechamento']?></td>
            </tr>
            <?php endforeach; ?>
        </tbody>
    </table>
</body>
</html>
<?=template_footer()?>
