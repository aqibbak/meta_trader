function fetchSymbol(pos){
  $.ajax({
    url: '/fetch_symbol',
    data:  { pos: pos },
    dataType: 'script'
  }).success(function(data, status, xhr) {
  });
}

function initSymbolEvents(){
  $(".symbol-row").click(function(){
    var pos = $(this).data().pos;
    fetchSymbol(pos);
  });
  $("#new-symbol-link").click(function(){
    $.ajax({
      url: '/new_symbol',
      dataType: 'script'
    }).success(function(data, status, xhr) {
    });
    return false;
  });
}

$(document).ready(function(){
  initSymbolEvents();
});