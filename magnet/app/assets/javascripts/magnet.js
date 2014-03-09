$(document).ready( function() {

  $(".genres .genre").click(function() {
    if($(this).hasClass("selected")) {
      $(this).removeClass("selected");
    } else {
      $(this).addClass("selected");
    }

    if($(".genre.selected").length > 0) {
      $(".box-email").slideDown(500);
      $(".box-submit").slideDown(500);
    }
  });

  $("form").on("submit", function() {
    var genres=[];
    $(".genre.selected").each(function() {
      genres.push($(this).data("genre"));
    });
    $("input#genres").val(JSON.stringify(genres));
  });

  $(".mousehover-area").mouseover(function() {
      $(".magnet").animate({"opacity": 1}, 200)
      a = $(this);
      $(this).find("input.submit").animate({"left": "80%"}, 300, function() {
          a.find("input.othersubmit").slideDown(1000);
      });
  });
});

function canShowSubmit() {
  //if($(".box-email input").val().indexOf("@") >= 0) {
  // $(".box-submit").slideDown(500);
  //}
}
