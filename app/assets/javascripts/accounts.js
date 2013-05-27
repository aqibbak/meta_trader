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

$(document).ready(function(){
  $(".account-row").click(function(){
    var login = $(this).data().login;
    fetchAccount(login);
  });
});