$(document).ready(function() {
	
	// display tooltip
	$(function () {
		$('[data-toggle="tooltip"]').tooltip()
	})
	
	// make .social-button-... height
	var height = $(window).height() - $(".social-button-facebook").outerHeight( true );
	$(".login-button-facebook").css("height", height);

	var height = $(window).height() - $(".social-button-twitter").outerHeight( true );
	$(".login-button-twitter").css("height", height);
	
	// check if p has more than 90 characters and leaves only 90
	$( ".cp-2 .cp-text p" ).each(function() {
		if($(this).text().length > 90){
			var str = $(this).text(),
					res = str.substring(0, 89);
			console.log(res);
			$(this).html(res+"...");
		} else {
			$(this).html();
		}
	});
	
		// check if p has more than 200 characters and leaves only 200
	$( ".cp-4 .cp-text p" ).each(function() {
		if($(this).text().length > 200){
			var str = $(this).text(),
					res = str.substring(0, 199);
			console.log(res);
			$(this).html(res+"...");
		} else {
			$(this).html();
		}
	});
	

	
});

	// custom file input 
	/*
	By Osvaldas Valutis, www.osvaldas.info
	Available for use under the MIT License
	*/

'use strict';

;( function ( document, window, index )
{
	var inputs = document.querySelectorAll( '.inputfile' );
	Array.prototype.forEach.call( inputs, function( input )
	{
		var label	 = input.nextElementSibling,
			labelVal = label.innerHTML;

		input.addEventListener( 'change', function( e )
		{
			var fileName = '';
			if( this.files && this.files.length > 1 )
				fileName = ( this.getAttribute( 'data-multiple-caption' ) || '' ).replace( '{count}', this.files.length );
			else
				fileName = e.target.value.split( '\\' ).pop();

			if( fileName )
				label.querySelector( 'span' ).innerHTML = fileName;
			else
				label.innerHTML = labelVal;
		});

		// Firefox bug fix
		input.addEventListener( 'focus', function(){ input.classList.add( 'has-focus' ); });
		input.addEventListener( 'blur', function(){ input.classList.remove( 'has-focus' ); });
	});
}( document, window, 0 ));


// zeroclipboard

var client = new ZeroClipboard( document.getElementById("copy-button") );

client.on( "ready", function( readyEvent ) {
  // alert( "ZeroClipboard SWF is ready!" );

  client.on( "aftercopy", function( event ) {
    // `this` === `client`
    // `event.target` === the element that was clicked
    
//    alert("Copied text to clipboard: " + event.data["text/plain"] );
  } );
} );