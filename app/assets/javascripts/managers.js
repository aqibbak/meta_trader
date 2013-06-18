function fetchManager(pos){
  $("#loading").show();
  $.ajax({
    url: '/fetch_manager',
    data:  { pos: pos },
    dataType: 'script'
  }).success(function(data, status, xhr) {
    $("#loading").hide();
  });
}

$(document).ready(function(){
  $(".manager-edit").click(function(){
    var pos = $(this).parent().parent().data().pos;
    fetchManager(pos);
  });
});