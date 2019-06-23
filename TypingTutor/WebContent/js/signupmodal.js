

var $showmodal = $("#signupBtn");
var $overlay = $("#signupoverlay");
var $modal = $("#signupmodal");
var $close = $(".close");

$(document).ready(function(e){

    $overlay.hide();

});

$showmodal.on('click',function(e){
    e.preventDefault();

    var windowheight = $(window).height();
    var windowwidth = $(window).width();
    var modalwidth = windowwidth/2;

    $overlay.show();
    $modal.css({
        'width':modalwidth,
        'margin-left':-modalwidth/2

    });
});

$overlay.on('click',function(e){
    if(e.target !== this){
        return;
    }
    $overlay.hide();
});

$close.on('click',function(e){
    $overlay.hide();
});
