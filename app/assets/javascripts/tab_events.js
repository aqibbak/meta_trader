$(document).ready(function(){
  $("#form-access-modal").bind("ajax:complete",function(){
    $("#modal-1").modal("hide");
  })
  $(".access_row .access-edit").click(function(){
    $("#access_tab_position").val($(this).parent().parent().attr("data-position"));
    $("#access_tab_action").val($(this).parent().parent().attr("data-action"));
    $("#access_tab_from").val($(this).parent().parent().attr("data-from"));
    $("#access_tab_to").val($(this).parent().parent().attr("data-to"));
    $("#access_tab_comment").val($(this).parent().parent().attr("data-comment"));
    $("#access_new_record").val("false");
    $("#modal-1").modal();
    return false;
  });
  $("#new_access").click(function(){
    var last_position = parseInt($(".access_table").find("tr").last().attr("data-position"));
    $("#access_tab_position").val(last_position + 1);
    $("#access_tab_action").val("");
    $("#access_tab_from").val("");
    $("#access_tab_to").val("");
    $("#access_tab_comment").val("");
    $("#access_new_record").val("true");
    $("#modal-1").modal();
    return false;
  });
});

$(document).ready(function(){
  $("#form-data-server-modal").bind("ajax:complete",function(){
    $("#modal-data-server").modal("hide");
  })
  $(".data_server_row .data-server-edit").click(function(){
    $("#data_server_tab_position").val($(this).parent().parent().attr("data-position"));
    $("#data_server_tab_description").val($(this).parent().parent().attr("data-description"));
    $("#data_server_tab_server").val($(this).parent().parent().attr("data-server"));
    $("#data_server_tab_ip_internal").val($(this).parent().parent().attr("data-ipinternal"));
    $("#data_server_tab_priority").val($(this).parent().parent().attr("data-priority"));
    $("#data_server_new_record").val("false");
    $("#modal-data-server").modal();
    return false;
  });
  $("#new_data_server").click(function(){
    var last_position = parseInt($(".data_server_table").find("tr").last().attr("data-position"));
    $("#data_server_tab_position").val(last_position + 1);
    $("#data_server_tab_description").val("");
    $("#data_server_tab_server").val("");
    $("#data_server_tab_ip_internal").val("");
    $("#data_server_tab_priority").val("");
    $("#data_server_new_record").val("true");
    $("#modal-data-server").modal();
    return false;
  });
});

$(document).ready(function(){
  $(".time_switch").click(function(){
    $(this).parent().parent().find("td.time_check div input[type='checkbox']").each(function(ix,el){
      if($(el).prop("checked") == true){
        $(el).prop("checked", false);
        $(el).parent().removeClass("checked")
      }else{
        $(el).prop("checked", true);
        $(el).parent().addClass("checked")
      }
    });
    return false;
  });
});

$(document).ready(function(){
  $("#form-holiday-modal").bind("ajax:complete",function(){
    $("#modal-holiday").modal("hide");
  });
  $('#holiday_tab_yearly_check').change(function () {
    if($(this).prop("checked")){
      $("#holiday_tab_year").val("0").hide();
    }else{
      $("#holiday_tab_year").val("").show();
    }
  });
  $(".holiday-edit").click(function(){
    $("#holiday_tab_position").val($(this).parent().parent().attr("data-position"));
    var enabled = $(this).parent().parent().attr("data-enable") == 1;
    $("input[name='holiday_tab[enable]'][type='checkbox']").prop("checked", enabled);
    $("#holiday_tab_month").val($(this).parent().parent().attr("data-month"));
    $("#holiday_tab_day").val($(this).parent().parent().attr("data-day"));
    var year = $(this).parent().parent().attr("data-year");
    if(year=="0"){
      $("#holiday_tab_yearly_check").prop("checked", true);
      $("#holiday_tab_year").val("0").hide();
    }else{
      $("#holiday_tab_yearly_check").prop("checked", false);
      $("#holiday_tab_year").val(year).show();
    }
    var from = $(this).parent().parent().attr("data-from");
    $("#holiday_tab_from_hour").val(parseInt(from/60));
    $("#holiday_tab_from_minute").val(parseInt(from)-(parseInt(from/60)*60));
    var to = $(this).parent().parent().attr("data-to");
    $("#holiday_tab_to_hour").val(parseInt(to/60));
    $("#holiday_tab_to_minute").val(parseInt(to)-(parseInt(to/60))*60);
    $("#holiday_tab_comment").val($(this).parent().parent().attr("data-comment"));
    $("#holiday_tab_symbol").val($(this).parent().parent().attr("data-symbol"));
    $("#holiday_tab_description").val($(this).parent().parent().attr("data-description"));
    $("#holiday_new_record").val("false");
    $("#modal-holiday").modal();
    return false;
  });
  $("#new_holiday").click(function(){
    $("#holiday_new_record").val("true");
    var last_position = parseInt($(".holiday_table").find("tr").last().attr("data-position"));
    $("#holiday_tab_position").val(last_position + 1);
    $("input[name='holiday_tab[enable]'][type='checkbox']").prop("checked", true);
    $("#holiday_tab_month").val("");
    $("#holiday_tab_day").val("");
    $("#holiday_tab_yearly_check").prop("checked", false);
    $("#holiday_tab_year").val("").show();
    $("#holiday_tab_from_hour").val("");
    $("#holiday_tab_from_minute").val("");
    $("#holiday_tab_to_hour").val("");
    $("#holiday_tab_to_minute").val("");
    $("#holiday_tab_comment").val("");
    $("#holiday_tab_symbol").val("");
    $("#holiday_tab_description").val("");
    $("#modal-holiday").modal();
    return false;
  });
});


$(document).ready(function(){
  $('.symbol_group_field').change(function () {
    console.log($(this).parent().parent().find(".symbol_group_changed").first());
    $(this).parent().parent().find(".symbol_group_changed").first().val(true);
  });
  $('.symbol_group_form').bind("ajax:complete",function(){
    $(".symbol_group_changed").val(false);
  });
});

$(document).ready(function(){
  $('#backup_tab_watch_role').change(function () {
    if($(this).val() == 0){
      $("#backup_tab_watch_password").prop("readonly","readonly");
      $("#backup_tab_watch_opposite").prop("readonly","readonly");
    }else{
      $("#backup_tab_watch_password").prop("readonly","");
      $("#backup_tab_watch_opposite").prop("readonly","");
    }
  });
});