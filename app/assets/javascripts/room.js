$(function(){
  var start_timer = new Date();
  var ready_num = 0;
  var save_data = false;
  $("#multi_post_button").click(function(){
    ready_num = ready_num +1;
    $("#notice_model").modal({
      backdrop: true,
      keyboard: false,
      show: true
    });
    $("#save_data").button('loading');
    $.ajax({
    url: "/g/get_room_user_num",
    success: function(data){
        if(ready_num<data.usernum)
          save_data = false;
        else
          save_data = true;
        alert(save_data);
        alert(ready_num);
    }
  })
  });
});
