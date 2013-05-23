function fetchAccount(login){
  $.ajax({
    url: '/fetch_account',
    data:  { login: login },
    dataType: 'script'
  }).success(function(data, status, xhr) {
  });
}

$(document).ready(function(){
  $(".account-row").click(function(){
    var login = $(this).data().login;
    fetchAccount(login);
  });
});