function fetchSynchronization(pos){
  $("#loading").show();
  $.ajax({
    url: '/fetch_synchronization',
    data:  { pos: pos },
    dataType: 'script'
  }).success(function(data, status, xhr) {
    $("#loading").hide();
  });
}

$(document).ready(function(){
  $(".synchronization-row").click(function(){
    var pos = $(this).data().pos;
    fetchSynchronization(pos);
  });
});