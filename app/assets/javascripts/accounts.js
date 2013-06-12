function fetchAccount(login){
  $("#loading").show();
  $.ajax({
    url: '/fetch_account',
    data:  { login: login },
    dataType: 'script'
  }).success(function(data, status, xhr) {
    $("#loading").hide();
  });
}

function initAccountEvents(){
  $("#new-account-link").click(function(){
    $.ajax({
      url: '/new_account',
      dataType: 'script'
    }).success(function(data, status, xhr) {
    });
    return false;
  });
  $(".data-server-edit").click(function(){
    var login = $(this).parent().parent().data().login;
    fetchAccount(login);
  });
  $("#form-symbol-modal").bind("ajax:complete",function(){
    $("#modal-symbol").modal("hide");
  });
}

$(document).ready(function(){
  initAccountEvents();
});