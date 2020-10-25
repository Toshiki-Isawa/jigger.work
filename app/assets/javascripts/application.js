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
//= require rails-ujs
//= require activestorage
//= require turbolinks
//= require jquery3
//= require bootstrap-sprockets
//= require_tree .
//= require cocoon
//= require toastr

//  ヘッダーメニュー
(function($) {
  document.addEventListener('turbolinks:load',function () {
    $('#nav-toggle').on('click', function() {
      $('body').toggleClass('open');
    });
  });
})(jQuery);

(function () {
  document.addEventListener('turbolinks:load', function() {
    const btn = document.getElementById('dropdown__btn');
    if(btn) {
      btn.addEventListener('click', function(){
        this.classList.toggle('is-open');
      });
    }
  });
}());

// Tabbutton
$(document).on('turbolinks:load',function(){
  $('.tab-content>div').hide();
  $('.tab-content>div').first().slideDown();
    $('.tab-buttons span').click(function(){
      var thisclass=$(this).attr('class');
      $('#lamp').removeClass().addClass('#lamp').addClass(thisclass);
      $('.tab-content>div').each(function(){
        if($(this).hasClass(thisclass)){
          $(this).fadeIn(800);
        }
        else{
          $(this).hide();
        }
      });
    });
});

// Page-top button
jQuery(function() {
  var appear = false;
  var pagetop = $('#page_top');
  $(window).scroll(function () {
    if ($(this).scrollTop() > 100) {  //100pxスクロールしたら
      if (appear == false) {
        appear = true;
        pagetop.stop().animate({
          'bottom': '50px' //下から50pxの位置に
        }, 300); //0.3秒かけて現れる
      }
    } else {
      if (appear) {
        appear = false;
        pagetop.stop().animate({
          'bottom': '-50px' //下から-50pxの位置に
        }, 300); //0.3秒かけて隠れる
      }
    }
  });
  pagetop.click(function () {
    $('body, html').animate({ scrollTop: 0 }, 500); //0.5秒かけてトップへ戻る
    return false;
  });
});

// モーダルウィンドウ
$(document).on('turbolinks:load', function(){
  $('.js-modal-open').on('click',function(){
      $('.js-modal').fadeIn();
      return false;
  });
  $('.js-modal-close').on('click',function(){
      $('.js-modal').fadeOut();
      return false;
  });
});

// テーブルのカラムにリンクを設定する
$(document).on('turbolinks:load',function() {
  $(".clickable-row").css("cursor","pointer").click(function() {
      location.href = $(this).data("href");
  });
});

// 無限スクロール
$(document).on('turbolinks:load', function() {
  $(window).on('scroll', function() {
    scrollHeight = $(document).height();
    scrollPosition = $(window).height() + $(window).scrollTop();
    if ( (scrollHeight - scrollPosition) / scrollHeight <= 0.05) {
      $('.jscroll').jscroll({
        autoTrigger: true,
        contentSelector: '.jscroll',
        nextSelector: 'a.next',
        loadingHtml: '読み込み中'
      });
    }
  });
});
