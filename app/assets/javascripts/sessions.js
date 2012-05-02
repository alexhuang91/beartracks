$(document).ready(function() {
	
	// When the input box is in focus, clear it if nothing has been entered. Also turns text-field into password-field.
	// When the input box moves out of focus, reset back to the default value if nothing was entered. 
    $(".fancy-input").focus(function() {
        clearfield(this);
    }).blur(function() {
    	resetfield(this);
    })

	// When the input box is in focus, clear it if nothing has been entered. Also turns text-field into password-field.
	// When the input box moves out of focus, reset back to the default value if nothing was entered. 
	//   Also turns password-field back to text-field if nothing was entered.
    $(".fancy-password-input").focus(function() {
        pwclearfield(this);
    }).blur(function() {
    	pwresetfield(this);
    })

});
