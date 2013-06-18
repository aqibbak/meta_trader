function fetchGroup(pos){
  $("#loading").show();
  $.ajax({
    url: '/fetch_group',
    data:  { pos: pos },
    dataType: 'script'
  }).success(function(data, status, xhr) {
    $("#loading").hide();
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
  $(".group-edit").click(function(){
    var pos = $(this).parent().parent().data().pos;
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