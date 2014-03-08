$(document).ready( function() {
  $(".genres .genre").click(function() {
    if($(this).hasClass("selected")) {
      $(this).removeClass("selected");
    } else {
      $(this).addClass("selected");
    }
  });
});
