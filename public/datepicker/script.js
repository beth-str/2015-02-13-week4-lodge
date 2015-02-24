$(document).ready(function() {
    $("#arrival").datepicker();
    $("#departure").datepicker();
    $("button").click(function() {
        var arrival = $("#arrival").val();
        var departure = $("#departure").val();
    });
});