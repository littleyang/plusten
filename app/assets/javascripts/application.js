// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
// WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
// GO AFTER THE REQUIRES BELOW.
//
//= require jquery
//= require jquery_ujs
//= require twitter/bootstrap
//= require_tree

$(function(){
  var start_timer = new Date();
  var end_timer;
  var thought_time;
  $("#select_num :input").click(function(){
    $(function(){
      jQuery("#three").attr("disabled",true);
      jQuery("#five").attr("disabled",true);
      jQuery("#seven").attr("disabled",true);
      jQuery("#zero").attr("disabled",true);
    });
  });
  $("#post_button").click(function(){
    end_timer = new Date();
    $("#notice_model").modal({
      backdrop: true,
      keyboard: false,
      show: true
    });
    $("#save_data").button('loading');
    window.setTimeout(show_save_button,5000);
  });

  $("#save_data").click(function(){
    var select_num = jQuery("input[type=checkbox]:checked").val();
    thought_time = (end_timer.getTime())-(start_timer.getTime());
    var type = getUrlParam("type");
    var result_score = caculate_score(select_num,type);
    $.ajax({
      url: "/g/post_single",
      type: "POST",
      data: {select_num:select_num,thought_time:thought_time,score:result_score,type:type},
      success: function(data){
         $("#result_modal").modal({
          backdrop: false,
          keyboard: false,
          show: true
        });
         $("#notice_model").hide();
         $("#result_score").append(result_score);
         $("#result_num").append(select_num);
         $("#result_time").append(thought_time);
      }
    });
  });

  $("#continue_game").click(function(){
    window.location.reload();
  });

  function show_save_button(){
    $("#save_data").button('reset');
  }
  
  function getUrlParam(name){
    var reg = new RegExp("(^|&)"+ name +"=([^&]*)(&|$)");
    var r = window.location.search.substr(1).match(reg);
    if (r!=null) return unescape(r[2]); return null;
  }

  function caculate_score(num,type){
    if(type == 1)
      return(50 - num);
    else if(type == 2)
      return(40 - num);
    else if(type == 3)
      return(35 - num);
    else
      return null;
  }
});

