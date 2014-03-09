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
      var a = $(this);
      $({deg: 0}).animate({deg: 90}, {
          duration: 400,
          step: function(now) {
              // in the step-callback (that is fired each step of the animation),
              // you can use the `now` paramter which contains the current
              // animation-position (`0` up to `angle`)
              a.find("input.submit").css({
                  "transform": 'rotate(' + now + 'deg)',
                  "-webkit-transform": 'rotate(' + now + 'deg)'
              });
          }
      });
      $(".magnet").animate({"opacity": 1}, 200);
      a.find("input.submit").animate({"left": "64%"}, 400, function() {
          a.find("input.othersubmit").slideDown(1000);
      });
  });

  $("form").submit(function() {
    function add(text) {
      $(".whathappeningnow").html($(".whathappeningnow").html() + text + "<br>");
    }
    var form = this;

    $(".btn-modal").click();

    setTimeout(function() {
      add("貴様の個人情報をいろんなサイトからダウンロードしています。。。");
    }, 200);
    setTimeout(function() {
      add("求人情報をYahoo keyword APIでマッチングしています。");
      form.submit();
    }, 2000);
    setTimeout(function() {
      add("Rakuten でおすすめの本をクレジットカードで買ってます。");
    }, 4000);
    setTimeout(function() {
      add("グーグルのトレンディーなグラフを作っています。");
    }, 5500);
    setTimeout(function() {
      add("完了しました！(上は嘘でした）");
    }, 6500);
  });

});

function canShowSubmit() {
  //if($(".box-email input").val().indexOf("@") >= 0) {
  // $(".box-submit").slideDown(500);
  //}
}
