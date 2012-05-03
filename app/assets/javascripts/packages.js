$(document).ready(function() {

  // Function to remove all buildings and then add back the current unit's buildings
  add_and_remove_buildings_options = function() {
    var unit = $(".unit_select").children().val();
    var array = buildings[unit];
    $(".building_select").children().children().remove();
    for (var i = 0; i < array.length; i++) {
      var element = document.createElement('option');
      element.text = array[i];
      element.value = array[i];
      $(".building_select").children().append(element);
    }
  }

  // When the page loads, start playing with the buildings appropriately
  if (window.onload) {
    window.onload();
  }
    $(".unit_select").children().change(add_and_remove_buildings_options);
	
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
	
	// Put categories for the Units in the building select menu
	$("option[value^='--']").each(function() { 
		$(this).attr("disabled", "disabled");
	});
	
	// In the building select menu, default to Channing Bowditch since it's the first option
	$("option[value^='Channing Bowditch']").attr("selected", "selected");
	
});
