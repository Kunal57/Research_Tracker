// Watches the projects#show page for added records to update.

$(document).ready(function(){

	$("#new_record").on("submit", function(event, data, status, xhr){
		event.preventDefault();
	}).on("ajax:success", function(event, data, status, xhr) {
		// console.log("WAHOOO!!!")
		$("#list-of-records").append(xhr.responseText);
	});

});