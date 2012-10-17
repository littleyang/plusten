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
  $("#zero_0").click(function(){
    $(function(){
      jQuery("#three_3").attr("disabled",true);
      jQuery("#five_5").attr("disabled",true);
      jQuery("#seven_7").attr("disabled",true);
      jQuery("#zero_0").attr("disabled",true);
    });
  });
});
$(function(){
  $("#post_button").click(function(){
    var callback = arguments.callee;
    $("#notice_model").modal({
      backdrop:true,
      keyboard: false,
      show: true
    });
    $("#save_data").button('loading');
    window.setTimeout(show_save_button,5000);
  });
});

function show_save_button(){
  $("#save_data").button('reset');
};

$(function(){
  $("#save_data").click(function(){
   var game = $("#select_num :input").val();
   $this.ajax({
     url: '/g/post_singl',
     type: POST,
     data: game
  }).done(function(){
    alert("message");
  });
});
