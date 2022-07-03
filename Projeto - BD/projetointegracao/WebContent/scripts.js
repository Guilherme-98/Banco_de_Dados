function deleteProduct(e) {
    e.preventDefault();
    $('.link_confirmacao_excluir_iphone').attr('href', $(this).data('href'));
    $('.modal_excluir_iphone').modal();
}


$(document).ready(function () {
    $(document).on('click', '.link_excluir_iphone', deleteProduct);
    $("*[data-toggle='tooltip']").tooltip({
        'container': 'body'
    });
});
