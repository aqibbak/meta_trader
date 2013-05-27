function fetchSymbol(pos){
  $.ajax({
    url: '/fetch_symbol',
    data:  { pos: pos },
    dataType: 'script'
  }).success(function(data, status, xhr) {
  });
}

function initSymbolEvents(){
  $(".symbol-edit").click(function(){
    var pos = $(this).parent().parent().data().pos;
    fetchSymbol(pos);
    return false;
  });
  $("#new-symbol-link").click(function(){
    $.ajax({
      url: '/new_symbol',
      dataType: 'script'
    }).success(function(data, status, xhr) {
    });
    return false;
  });
  $("#form-symbol-modal").bind("ajax:complete",function(){
    $("#modal-symbol").modal("hide");
  })
}

$(document).ready(function(){
  initSymbolEvents();
});