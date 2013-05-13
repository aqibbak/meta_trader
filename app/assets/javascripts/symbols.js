function fetchSymbol(pos){
  $.ajax({
    url: '/fetch_symbol',
    data:  { pos: pos },
    dataType: 'script'
  }).success(function(data, status, xhr) {
  });
}

$(document).ready(function(){
  $(".symbol-row").click(function(){
    var pos = $(this).data().pos;
    fetchSymbol(pos);
  });
});