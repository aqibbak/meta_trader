function fetchOrder(order){
  $.ajax({
    url: '/fetch_order',
    data:  { order: order },
    dataType: 'script'
  }).success(function(data, status, xhr) {
  });
}

$(document).ready(function(){
  $(".order-row").click(function(){
    var order = $(this).data().order;
    fetchOrder(order);
  });
});