$(document).ready(function() {
	$("tr[data-link]").click(function() {
  		window.location = $(this).data("link")
	});
    $("#add").click(function() {
      $('#table tbody>tr:last').clone(true).insertAfter('#table tbody>tr:last');
      return false;
    });
	$("#ajax-button").click(function() {
	    $.ajax({
	        type: "GET",
	        url: "/username-available",
	        data: {username: $("#username").val()},
	        success: function (data) { 
	          // append data to your page
	          $("#ajax-button").text(data.message);
	          console.log(data);
	          if(data.message=="× NOT AVAILABLE") {
	          	$("#ajax-button").removeClass("btn-primary btn-success").addClass("btn-danger");
	          }
	          else if(data.message=="✓ AVAILABLE"){
	          	$("#ajax-button").removeClass("btn-primary btn-danger").addClass("btn-success");
	          }
	      	}
	  	});
	});
	$("#ajax-button").click(function() {
	    $.ajax({
	        type: "GET",
	        url: "/underscorifier",
	        data: {username: $("#username").val()},
	        success: function (data) {
	        	$("#underscore-ajax").text(data.message); 
	        }
	  	});
	});
});