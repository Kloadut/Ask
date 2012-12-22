// Javascript of Ask

$(document).ready(function() {

    // Captcha handling
    function calculate_captcha() {
        if($("#captcha1").length) {
            result = parseInt($("#captcha1").val()) + parseInt($("#captcha2").val())
            $("#captcha1").before('<input type="hidden" name="captcha" value="'+ result.toString() +'">');
            $("#captcha1").remove();
            $("#captcha2").remove();
        }
    }
    calculate_captcha();

    // Load form on index
    $("#ask").click(function() {
        $("#look").removeClass("btn-active");
        $("#ask").addClass("btn-active");
        $("#index_content").load("/"+ $('#lang').val() +"/req/new/raw", function() {
            calculate_captcha();
        });
    });

    // Load list on index
    $("#look").click(function() {
        $("#ask").removeClass("btn-active");
        $("#look").addClass("btn-active");
        $("#index_content").load("/"+ $('#lang').val() +"/req/list/raw?tags="+ $('#tagbar').val() +"&type="+ $('#type').val());
    });

    $('#tagbar').change(function() {
        if($("#look.btn-active").length != 0) {
            $("#index_content").load("/"+ $('#lang').val() +"/req/list/raw?tags="+ $('#tagbar').val() +"&type="+ $('#type').val());
        }
    });

    // Tag autocomplete
    $.getJSON('/'+ $('#lang').val() +'/tags', function(tags) {
        $('#tagbar').tagit({
            availableTags: tags
        });
    });


    $("#type").change(function() {
        $("#look").text($("#look_"+ $("#type").val()).val());
        $("#ask").text($("#ask_"+ $("#type").val()).val());
    });

});
