$(document).ready(function() {
	
    // Function to hide one of the search fields based on the selected search option
	choose_select_option = function() {
    	if ($("#search-type").val() == "building") {
        	$("#search-text").hide();
        	$("#search-select").show();
    	} else {
        	$("#search-select").hide();
        	$("#search-text").show();
    	}
	}

	// When the page loads and when the search option changes, hide the correct field
	choose_select_option();
    $("#search-type").change(choose_select_option);
	
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
