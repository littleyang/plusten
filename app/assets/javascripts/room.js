$(function(){
  var start_timer = new Date();
  var save_data = false;
  $("#multi_post_button").click(function(){
    var end_timer = new Date();
    var thought_time = (end_timer.getTime()) - (start_timer.getTime());
    var select_num = jQuery("input[type=checkbox]:checked").val();
    var roomid = getUrlParam("roomid");
    $("#notice_model").modal({
      backdrop: true,
      keyboard: false,
      show: true
    });
    $("#multi_save_data").button('loading');
    //alert(roomid).
    $.ajax({
      url: "/g/post_multi",
      type: "POST",
      data:{select_num:select_num,thought_time:thought_time,room_id:roomid},
      success: function(show_result){
        $("#notice_model").hide();
        if(show_result){
          $("#multi_result_modal").modal({
            backgrop: false,
            keyboard: false,
            show: true
          });
        }
          //$("#multi_continue_game").show();
      }
    })
  });
  
  function getUrlParam(name){
    var reg = new RegExp("(^|&)"+ name +"=([^&]*)(&|$)");
    var r = window.location.search.substr(1).match(reg);
    if (r!=null) return unescape(r[2]); return null;
  }
});
