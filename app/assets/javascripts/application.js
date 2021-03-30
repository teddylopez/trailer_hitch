// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require_tree .

$(document).ready(function () {
  updateCountDowns();
  styleNoReserve();
  autoSubmit();
});

function updateCountDowns() {
  var $cards = $("div.vehicle-card");
  $.each($cards, function (index, value) {
    var $card = $(this);
    var $span = $card.find("span.countdown");

    // Set the date we're counting down to:
    var countDownDate = new Date(
      $span[0].dataset["timestamp"] * 1000
    ).getTime();

    // Update the count down every 1 second
    var x = setInterval(function () {
      // Get today's date and time
      var now = new Date().getTime();

      // Find the distance between now and the count down date
      var distance = countDownDate - now;

      // Time calculations for days, hours, minutes and seconds
      var days = Math.floor(distance / (1000 * 60 * 60 * 24));
      var hours = Math.floor(
        (distance % (1000 * 60 * 60 * 24)) / (1000 * 60 * 60)
      );
      var minutes = Math.floor((distance % (1000 * 60 * 60)) / (1000 * 60));
      var seconds = Math.floor((distance % (1000 * 60)) / 1000);

      // Display the result
      $span.text(hours + "h " + minutes + "m " + seconds + "s ");

      // If the count down is finished, write some text
      if (distance < 0) {
        clearInterval(x);
        $span.text("EXPIRED");
      }
    }, 1000);
  });
}

function styleNoReserve() {
  var $cards = $("div.vehicle-card");
  $.each($cards, function (index, value) {
    var $card = $(this);
    var $cardTitle = $card.find("h3");
    if ($($cardTitle).is(':contains("No Reserve")')) {
      $card.css({ backgroundColor: "rgba(255, 235, 59, 0.3)" });
    }
  });
}

function autoSubmit() {
  $("form.autosubmit :input").change(function () {
    $(this).closest("form").submit();
  });
}
