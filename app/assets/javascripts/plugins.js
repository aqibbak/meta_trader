function fetchPlugin(pos){
  $("#loading").show();
  $.ajax({
    url: '/fetch_plugin',
    data:  { pos: pos },
    dataType: 'script'
  }).success(function(data, status, xhr) {
    $("#loading").hide();
  });
}

function setPluginEvents(){
  $("#new-plugin-param").click(function(){
    var last = (parseInt($("#last_param_pos").val())+1).toString();
    $("#plugin-param-table").append('<tr data-pos="'+last+'"><td><input id="plugin_params_'+last+'_name" name="plugin[params]['+last+'][name]" type="text" value="name"/></td><td><input id="plugin_params_'+last+'_value" name="plugin[params]['+last+'][value]" type="text" value="value"></td><td><a class="plugin-param-del" href="#">x</a></td></tr>');
    $("#last_param_pos").val(last);
    return false;
  });
  $("#new-plugin-link").click(function(){
    $.ajax({
      url: '/new_plugin',
      dataType: 'script'
    }).success(function(data, status, xhr) {
    });
    return false;
  });
  $(".plugin-edit").click(function(){
    var pos = $(this).parent().parent().data().pos;
    fetchPlugin(pos);
  });

}

$(document).ready(function(){
  setPluginEvents();
});