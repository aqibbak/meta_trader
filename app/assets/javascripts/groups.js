function fetchGroup(pos){
  $.ajax({
    url: '/fetch_group',
    data:  { pos: pos },
    dataType: 'script'
  }).success(function(data, status, xhr) {
  });
}

function secgroupEvents(){
  $(".secgroup-row").click(function(){
    var pos = $(this).data().pos;
    $(".secgroup-div").hide();
    $("#secgroup" + pos).show();
  });
}

function initGroupEvents(){
  $(".group-row").click(function(){
    var pos = $(this).data().pos;
    fetchGroup(pos);
  });
  secgroupEvents();
}

$(document).ready(function(){
  $("#new-group-link").click(function(){
    $("#modal-group2").modal("show");
    return false;
  });
  initGroupEvents();
});