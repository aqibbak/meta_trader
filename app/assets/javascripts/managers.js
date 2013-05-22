function fetchManager(pos){
  $.ajax({
    url: '/fetch_manager',
    data:  { pos: pos },
    dataType: 'script'
  }).success(function(data, status, xhr) {
  });
}

$(document).ready(function(){
  $(".manager-row").click(function(){
    var pos = $(this).data().pos;
    fetchManager(pos);
  });
});