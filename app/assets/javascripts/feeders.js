function fetchFeeder(pos){
  $("#loading").show();
  $.ajax({
    url: '/fetch_feeder',
    data:  { pos: pos },
    dataType: 'script'
  }).success(function(data, status, xhr) {
    $("#loading").hide();
  });
}

$(document).ready(function(){
  $(".feeder-edit").click(function(){
    var pos = $(this).parent().parent().data().pos;
    fetchFeeder(pos);
  });
});