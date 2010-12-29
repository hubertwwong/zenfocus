/*
 * countdown_timer.
 *
 * takes the number of seconds to complete a task and just countdown to zero.
 */
function countdown_secs(fsec) {

    // fsec
    amount = fsec;

	// time is already past
	if(amount < 0){
		document.getElementById('countbox').innerHTML="00 : 00";
	}
	// date is still good
	else{
		days=0;
        hours=0;
        mins=0;
        secs=0;
        out="";

        // compute time
        // ============

        // days
		days=Math.floor(amount/86400);
		amount=amount%86400;

        // hours
        hours=Math.floor(amount/3600);
		amount=amount%3600;

        // mins
		mins=Math.floor(amount/60);
		amount=amount%60;

        // seconds
		secs=Math.floor(amount);
        
        // format the time text.
        // ====================================

        //out += "hi " + secs;
        out += countdown_format_text(days, hours, mins, secs);
        
        // override the div to update the display.
		document.getElementById('countbox').innerHTML=out;

        // decrement by one second.
        // some were java script thing where functions wont take parameters.
        fsecMinusOne = fsec - 1;

        // set countdown color text
        document.getElementById("countbox").setAttribute("class", countdown_format_color(days, hours, mins, secs));

        // closure hack to get around setTimeout limiations.
        var getCountProxyFn = function() { countdown_secs(fsecMinusOne) };
		setTimeout(getCountProxyFn, 1000);
	}
}

/*
    countdown_timer

    you specify a target date and it creates a countdown timer.

    quirks.
    hours go in mil time.
    months are zero based. (fixed in the function.)
    closure needed to pass a function to the on load event.
*/
function countdown_timer(fyear, fmonth, fday, fhour, fmin, fsec) {
    // date hack. basically months in JS are 0 index.
    dateFuture = new Date(fyear, fmonth-1, fday, fhour, fmin, fsec, 0);

    //grab current date
	var dateNow = new Date();
    //calc milliseconds between dates
	amount = dateFuture.getTime() - dateNow.getTime();
	delete dateNow;

	// time is already past
	if(amount < 0){
		document.getElementById('countbox').innerHTML="00 : 00";
	}
	// date is still good
	else{
		days=0;
        hours=0;
        mins=0;
        secs=0;
        out="";

        // compute time
        // ============

        // kill the "milliseconds" so just secs
		amount = Math.floor(amount/1000);

        // days
		days=Math.floor(amount/86400);
		amount=amount%86400;

        // hours
        hours=Math.floor(amount/3600);
		amount=amount%3600;

        // mins
		mins=Math.floor(amount/60);
		amount=amount%60;

        // seconds
		secs=Math.floor(amount);

        // format the time text.
        // ====================================
        out += countdown_format_text(days, hours, mins, secs);

        // override the div to update the display.
		document.getElementById('countbox').innerHTML=out;

        // set countdown color text
        document.getElementById("countbox").setAttribute("class", countdown_format_color(days, hours, mins, secs));

        // closure hack to get around setTimeout limiations.
        var getCountProxyFn = function() { countdown_timer(fyear, fmonth, fday, fhour, fmin, fsec) };
		setTimeout(getCountProxyFn, 1000);
	}
}

/*
    determines the text formatting for the countdown timer.
*/
function countdown_format_text(days, hours, mins, secs) {
    result_text = "";

    if(days != 0) {result_text += days +" : ";}
    if(days != 0 || hours != 0){ result_text += pad_zeros(hours,2) +" : ";}
    if(days != 0 || hours != 0 || mins != 0){result_text += pad_zeros(mins,2) +" : ";}
    result_text += pad_zeros(secs,2);

    return result_text;
    //return "hello";
}

/*
    determines the css style to apply to the text.
    returns the actual class id label which you can insert into the css style.
*/
function countdown_format_color(days, hours, mins, secs) {
    var result_color = "green_countdown_text";

    // determine what color is the text.
    if (mins < 5 && days == 0 && hours == 0) {
        result_color = "red_countdown_text";
    }
    else if (mins >= 5 && mins <= 10  && days == 0 && hours == 0) {
        result_color = "yellow_countdown_text";
    }

    return result_color;
}

/*
    pad the left side of the necessary number of extra zeros. (if needed)
*/
function pad_zeros(number, length) {

    var str = '' + number;
    while (str.length < length) {
        str = '0' + str;
    }

    return str;

}
//call when everything has loaded
//window.onload=GetCount;