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
  $(".account-row").click(function(){
    var login = $(this).data().login;
    fetchAccount(login);
  });
}

$(document).ready(function(){
  initAccountEvents();
});