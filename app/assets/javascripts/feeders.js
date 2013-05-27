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
  $(".feeder-row").click(function(){
    var pos = $(this).data().pos;
    fetchFeeder(pos);
  });
});