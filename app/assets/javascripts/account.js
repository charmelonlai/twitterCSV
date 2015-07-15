	$(document).on("click",'#ajax-button',function() {
	    $.ajax({
	        type: "GET",
	        url: "/username-available",
	        data: {username: $("#username").val()},
	        success: function (data) { 
	          // append data to your page
	          $("#ajax-button").text(data.message);
	          console.log(data);
	          if(data.message=="×") {
	          	$("#ajax-button").removeClass("btn-primary btn-success").addClass("btn-danger");
	          	$("#save").addClass("disabled");
	          }
	          else if(data.message=="✓"){
	          	$("#ajax-button").removeClass("btn-primary btn-danger").addClass("btn-success");
	          	$("#save").removeClass("disabled");
	          }
	      	}
	    });
	});
	$(document).on("click",'#edit-ajax-button',function() {
	    $.ajax({
	        type: "GET",
	        url: "/username-available",
	        data: {username: $("#edit-username").val()},
	        success: function (data) { 
	          // append data to your page
	          $("#edit-ajax-button").text(data.message);
	          console.log(data);
	          if(data.message=="×") {
	          	$("#edit-ajax-button").removeClass("btn-primary btn-success").addClass("btn-danger");
	          	$("#submit").addClass("disabled");
	          }
	          else if(data.message=="✓"){
	          	$("#edit-ajax-button").removeClass("btn-primary btn-danger").addClass("btn-success");
	          	$("#submit").removeClass("disabled");
	          }
	      	}
	    });
	});
	$(document).on("click","#edit-ajax-button",function() {
	    $.ajax({
	        type: "GET",
	        url: "/underscorifier",
	        data: {username: $("#edit-username").val()},
	        success: function (data) {
	        	$("#underscore-ajax").append(data.message); 
	        }
	  	});
	});

	$(document).on("click","#save",function() {
		$.ajax({
			type: "POST",
			url: "/accounts",
			dataType: 'script',
			data: { account:{ipaddress: $("#ipaddress").val(),
							dummy: $("#dummy").val(),
							password: $("#password").val(),
							email: $("#email").val(),
							username: $("#username").val(),
							name: $("#name").val(),
							bio: $("#bio").val(),
							location: $("#location").val(),
							website: $("#website").val(),
							profile_img: $("#profile_img").val(),
							header_img: $("#header_img").val()
							}
					},
			success: function(data) {				
				$("#ipaddress").val('');
				$("#dummy").val('');
				$("#password").val('');
				$("#email").val('');
				$("#username").val('');
				$("#name").val('');
				$("#bio").val('');
				$("#location").val('');
				$("#website").val('');
				$("#profile_img").val('');
				$("#header_img").val('');
			}
		});
	});
	
	$(document).on("click","#ajax-button",function() {
		$.ajax({
			type: "GET",
			url: "/imagesearch",
			dataType: 'JSON',
			data: { username: $("#username").val()
			},
			success: function(data) {
				$('#images').empty();
				$.each(data, function(index, element){
	  				$('#images').append('<li class = "img_li"><img src='+element.url+' style="height:75px;width:75px;margin-bottom:1px;margin-left:5%"></li>');
	  				$('.img_li').click(function(){
	  					$("#profile_img").val(element.url);
	  				});
	  				console.log(element.url);
				});
	  		}
		});
	});

