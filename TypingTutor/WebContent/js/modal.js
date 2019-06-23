
var $showmodalin = $("#signinBtn");
var $overlayin = $("#signinoverlay");
var $modalin = $("#signinmodal");
var $closein = $(".inclose");

$(document).ready(function(e){

    $overlayin.hide();
    $overlayup.hide();

});

$showmodalin.on('click',function(e){
    e.preventDefault();

    var windowheight = $(window).height();
    var windowwidth = $(window).width();
    var modalwidth = windowwidth/2;

    $overlayin.show();
    $modalin.css({
        'width':modalwidth,
        'margin-left':-modalwidth/2

    });
});

$overlayin.on('click',function(e){
    if(e.target !== this){
        return;
    }
    $overlayin.hide();
});




var $showmodalup = $("#signupBtn");
var $overlayup = $("#signupoverlay");
var $modalup = $("#signupmodal");
var $closeup = $(".upclose");


$showmodalup.on('click',function(e){
    e.preventDefault();

    var windowheight = $(window).height();
    var windowwidth = $(window).width();
    var modalwidth = windowwidth/2;

    $overlayup.show();
    $modalup.css({
        'width':modalwidth,
        'margin-left':-modalwidth/2

    });
});

$overlayup.on('click',function(e){
    if(e.target !== this){
        return;
    }
    $overlayup.hide();
});






$closeup.on('click',function(e){
    $overlayup.hide();
});




$closein.on('click',function(e){
    $overlayin.hide();
});







