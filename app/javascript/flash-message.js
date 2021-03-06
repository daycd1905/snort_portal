import $ from 'jquery';

$(function() {
  setInterval(function(){
    $('.flash-message').addClass('fade')
  }, 7000);
});