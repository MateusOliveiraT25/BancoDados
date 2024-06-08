<?php
include 'functions.php';
$pdo = pdo_connect_pgsql();
$msg = '';
// Verifica se o ID do contato existe, por exemplo, update.php?id=1 irá obter o contato com o id 1
if (isset($_GET['id'])) {
    if (!empty($_POST)) {
        // Esta parte é semelhante ao create.php, mas aqui estamos atualizando um registro e não inserindo
        $id_contato = $_GET['id'];
        $nome = isset($_POST['nome']) ? $_POST['nome'] : '';
        $email = isset($_POST['email']) ? $_POST['email'] : '';
        $cel = isset($_POST['cel']) ? $_POST['cel'] : '';
        $pizza = isset($_POST['pizza']) ? $_POST['pizza'] : '';
        $cadastro = isset($_POST['cadastro']) ? $_POST['cadastro'] : date('Y-m-d H:i:s');
        // Atualiza o registro
        $stmt = $pdo->prepare('UPDATE contatos SET nome = ?, email = ?, cel = ?, pizza = ?, cadastro = ? WHERE id_contato = ?');
        $stmt->execute([$nome, $email, $cel, $pizza, $cadastro, $id_contato]);
        $msg = 'Atualização Realizada com Sucesso!';
    }
    // Obter o contato da tabela contatos
    $stmt = $pdo->prepare('SELECT * FROM contatos WHERE id_contato = ?');
    $stmt->execute([$_GET['id']]);
    $contato = $stmt->fetch(PDO::FETCH_ASSOC);
    if (!$contato) {
        exit('Pedido Não Localizado!');
    }
} else {
    exit('Nenhum Pedido Especificado!');
}
?>


<?=template_header('Atualizar/Alterar Pedido - '.$contato['nome'])?>

<div class="content update">
	<h2>Atualizar Pedido - <?=$contato['nome']?></h2>
    <form action="update.php?id=<?=$contato['id_contato']?>" method="post">
        <label for="nome">Nome</label>
        <input type="text" name="nome" placeholder="Seu Nome" value="<?=$contato['nome']?>" id="nome">
        <label for="email">Email</label>
        <input type="email" name="email" placeholder="seuemail@seuprovedor.com.br" value="<?=$contato['email']?>" id="email">
        <label for="cel">Celular</label>
        <input type="text" name="cel" placeholder="(XX) X.XXXX-XXXX" value="<?=$contato['cel']?>" id="cel">
        <label for="pizza">Pizza</label>
        <input type="text" name="pizza" placeholder="Pizza" value="<?=$contato['pizza']?>" id="pizza">
        <label for="cadastro">Data do Pedido</label>
        <input type="datetime-local" name="cadastro" value="<?=date('Y-m-d\TH:i', strtotime($contato['cadastro']))?>" id="cadastro">
        <input type="submit" value="Atualizar">
    </form>
    <?php if ($msg): ?>
    <p><?=$msg?></p>
    <?php endif; ?>
</div>

<?=template_footer()?> 
