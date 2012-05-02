$(document).ready(function() {
  // Hide one of the search fields based on the selected search option
  $("#selector").change(function(){
    $(".selecting").hide();
    if ($(this).val() == "building") {
      $("#ss-select").show();
    } else {
      $("#ss-text").show();
    }
  });

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
