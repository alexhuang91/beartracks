$(document).ready(function() {
	
	//$("#ss-select").hide();
	
	/*
	choose_select_option = function() {
    	if ($("#selector").val() == "building") {
        	$("#ss-text").hide();
        	$("#ss-select").show();
    	} else {
        	$("#ss-select").hide();
        	$("#ss-text").show();
    	}
	}

	choose_select_option();
    */ 
    // Hide one of the search fields based on the selected search option
    $("#selector").change(choose_select_option);
	
	// Hide the package details link
	$(".packages-table-cell-details").hide();
	
	// Toggle pickup by clicking the table rows
	$("tr[class|='packages-table-info']").children("td.packages-table-cell").click(function() {
		text = $(this).parent().find("td.packages-table-cell-details a").attr('href');
		location.href = text;
	});
	
	// Apply a highlight when a row is hovered over
	$("tr[class|='packages-table-info']").hover(function() {
		$(this).toggleClass("highlight");
	});

});
