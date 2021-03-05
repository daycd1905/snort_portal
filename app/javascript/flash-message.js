import $ from 'jquery';

$(function() {
  setInterval(function(){
    $('.flash-message').addClass('fade')
  }, 5000);
});