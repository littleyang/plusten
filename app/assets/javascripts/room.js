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
    $.ajax({
      url: "/g/post_multi",
      type: "POST",
      data:{select_num:select_num,thought_time:thought_time,room_id:roomid},
      //success: function(){
      //     $("#multi_result_modal").modal({
      //     backgrop: false,
      //     keyboard: false,
      //     show: true
      //    });
      //  }
    })
  });
  function getUrlParam(name){
    var reg = new RegExp("(^|&)"+ name +"=([^&]*)(&|$)");
    var r = window.location.search.substr(1).match(reg);
    if (r!=null) return unescape(r[2]); return null;
  }

  function realitime_get_room(){
    $.getJSON( "/g/multiuser", function(data){
        $.each(data,function(index,room){
          $('field[name='+index+']').text(room.current_user_num);
          if(room.current_user_num<room.usernum)
            {
              $("field[name='room_info']").eq(index).text("当前房间未满");
            }
          else
            {
              $('a#room'+index).removeAttr('href');
              $("field[name='room_info']").eq(index).text("当前房间已满");
            }
        });
      });
      $.getJSON("/g/showresult",function(data){
        if(data.length < 3){
          $("#process_bar").progressbar({
            max: 3,
            value: data.length
          });
        }else{
          $("#notice_model").modal('hide');
          $("#multi_result_modal").modal({
              backgrop: false,
              keyboard: false,
              show: true
            });
        }
    });
    setTimeout(realitime_get_room,10000);
  }
  realitime_get_room();
  $("#multi_continue_game").click(function(){
    $("#multi_result_modal").modal('hide');
    //$.ajax({
    //  url: "/g/nextgame",
    //  type: "POST",
    //  data:{test:"text"}
    //});
    window.location.reload();
  });
});
