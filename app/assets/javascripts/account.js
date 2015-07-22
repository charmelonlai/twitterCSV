$(document).ready(function() {
	$('.ajax-button').on("click",function() {
		var self = this;
		console.log($(self).closest('form').find('.username').val())
		    $.ajax({
		        type: "GET",
		        url: "/username-available",
		        data: {username: $(self).closest('form').find('.username').val()},
		        success: function (data) { 
		          $(self).text(data.message);
		          console.log(data);
		          if(data.message=="×") {
		          	$(self).removeClass("btn-primary btn-success").addClass("btn-danger");
		          	$(self).closest('form').find('.save').addClass("disabled");
		          }
		          else if(data.message=="✓"){
		          	$(self).removeClass("btn-primary btn-danger").addClass("btn-success");
		          	$(self).closest('form').find('.save').removeClass("disabled");
		          }
		      	}
		    });
		});


	$(".save").on("click",function() {
		var self = this;
		$.ajax({
			type: "POST",
			url: "/accounts",
			dataType: 'script',
			data: { account:{ipaddress: $(self).closest('form').find(".ipaddress").val(),
							dummy: $(self).closest('form').find(".dummy").val(),
							password: $(self).closest('form').find(".password").val(),
							email: $(self).closest('form').find(".email").val(),
							username: $(self).closest('form').find(".username").val(),
							name: $(self).closest('form').find(".name").val(),
							bio: $(self).closest('form').find(".bio").val(),
							location: $(self).closest('form').find(".location").val(),
							website: $(self).closest('form').find(".website").val(),
							profile_img: $(self).closest('form').find(".profile_img").val(),
							header_img: $(self).closest('form').find(".header_img").val()
							}
					},
			success: function(data) {				
				$(self).closest('form').find(".ipaddress").val('');
				$(self).closest('form').find(".dummy").val('');
				$(self).closest('form').find(".password").val('');
				$(self).closest('form').find(".email").val('');
				$(self).closest('form').find(".username").val('');
				$(self).closest('form').find(".name").val('');
				$(self).closest('form').find(".bio").val('');
				$(self).closest('form').find(".location").val('');
				$(self).closest('form').find(".website").val('');
				$(self).closest('form').find(".profile_img").val('');
				$(self).closest('form').find(".header_img").val('');
				$(self).closest('form').find(".ajax-button").text('?').removeClass("btn-success btn-danger").addClass("btn-primary");
			}
		});
	});
	
	$(".image-dropdown").on("click",function() {
		var self = this;
		$.ajax({
			type: "GET",
			url: "/imagesearch",
			dataType: 'JSON',
			data: { username: $(self).closest('form').find(".username").val()
			},
			success: function(data) {
				$(self).closest('form').find('.images').empty();
				$.each(data, function(index, element){
					var $elem = $("<li>").addClass("img_li").html('<img src='+element.url+' style="height:75px;width:75px;margin-bottom:1px;margin-left:5%">');
	  				$(self).closest('form').find('.images').append($elem);
	  				$elem.click(function(){
	  					$(self).closest('form').find(".profile_img").val(element.url);
	  				});
	  				console.log(element.url);
				});
	  		}
		});
	});
});
