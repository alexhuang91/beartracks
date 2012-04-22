$(document).ready(function() {
	// Hide the toggle pickup link
	$(".packages-table-cell-pickup").hide();
	
	// Toggle pickup by clicking the table rows
	$("tr[class|='packages-table-info']").children("td.packages-table-cell").click(function() {
		text = $(this).parent().find("td.packages-table-cell-pickup a").attr('href');
		location.href = text;
	});
	
	// Apply a highlight when a row is hovered over
	$("tr[class|='packages-table-info']").hover(function() {
		$(this).toggleClass("highlight");
	});
	
});
