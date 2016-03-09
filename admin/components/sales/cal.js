//Calendar control by Bart E Stough - bart@cjems.com
//The calendar control provides a pop-up calendar that can be used stand-alone to view dates 
//or as a control to return a formatted date string to a text field
//The calendar control will accept the following parameters via the URL
//None of the parameters are required
//	form=[name of form text field resides on]
//	field=[name of text field residing in form]
//		To use standalone do not pass a form or field paramater
//	offset=[a positive or negative number that relates desired display month with current month
//				ie: current month is October - offset=-1 would return September]
//	txtcolor=[color of text] - default is Blue
//	bgcolor=[background color of calendar - default is White
//	hdrcolor=[color of header - default is Silver
//	todaycolor=[color to highlight current date - default is CornFlowerBlue
// Control the window size via the window.open function
// Example
//	<a href = "Calendar Control" onClick="JavaScript:window.open('calendar.html? _
//				form=form1&field=text1&bgcolor=Yellow&txtcolor=Blue&hdrcolor=Red& _
//				todaycolor=Orange&offset=-5','cal','noresize,width=225,height=160');return false"> _
//				<font size="2">Open Calendar</font></a>


//Function acquired from inquiry.com to parse out url parameters

/*******************************************************************************

'args.js', written by Charlton D. Rose for Inquiry.Com

Permission is granted to use and modify this script for any purpose,
provided that this credit header is retained, unmodified, in the script.

*******************************************************************************/


// This function is included to overcome a bug in Netscape's implementation
// of the escape () function:

function myunescape (str)
{
        str = '' + str;
        while (true)
        {
                var i = str . indexOf ('+');
                if (i < 0)
                        break;
                str = str . substring (0, i) + ' ' + str . substring (i + 1, str . length);
        }
        return unescape (str);
}



// This function creates the args [] array and populates it with data
// found in the URL's search string:

function args_init ()
{
        args = new Array ();
        var argstring = window . location . search;
        if (argstring . charAt (0) != '?')
                return;
        argstring = argstring . substring (1, argstring . length);
        var argarray = argstring . split ('&');
        var i;
        var singlearg;
        for (i = 0; i < argarray . length; ++ i)
        {
                singlearg = argarray [i] . split ('=');
                if (singlearg . length != 2)
                        continue;
                var key = myunescape (singlearg [0]);
                var value = myunescape (singlearg [1]);
                args [key] = value;
        }
}



// Call the args_init () function to set up the args [] array:

args_init ();

//START MY CODE

//Establish variables to account for milliseconds in time
var oneMinute = 60 * 1000
var oneHour = oneMinute * 60
var oneDay = oneHour * 24
var oneWeek = oneDay * 7
//Set Current_Month_Offset
Current_Month_Offset = 0;
if ( args["offset"]){
	Current_Month_Offset = eval(args["offset"]);
	}
//Define Day Array for Date object
var day_array = new Array("Sunday","Monday","Tuesday","Wednesday","Thursday","Friday","Saturday");

//Define month Array for Date Object
var month_array = new Array("January","February","March","April","May","June","July","August","September","October","November","December");

//Define color of text
if(args["txtcolor"]){
var txtcolor = args["txtcolor"];
}
else
{
var txtcolor = "Blue";
}

//Define background color
if(args["bgcolor"]){
var bgcolor = args["bgcolor"];
}
else
{
var bgcolor = "White";
}

//Define text color
if(args["txtcolor"]){
var txtcolor = args["txtcolor"];
}
else
{
var txtcolor = "Blue";
}

//Define header color
if(args["hdrcolor"]){
var hdrcolor = args["hdrcolor"];
}
else
{
var hdrcolor = "Silver";
}

//Define current date color
if(args["todaycolor"]){
var todaycolor = args["todaycolor"];
}
else
{
var todaycolor = "CornFlowerBlue";
}

//Define format
if(args["format"]){
var format = args["format"].toUpperCase();
}
else
{
var format = "L";
}




//Check for form and field name
if(args["form"] && args["field"]){
	formname = args["form"];
	fieldname = args["field"];
	}
	else
	{
	formname = "";
	fieldname = "";
	}

//function to test date object validity
function show_date(date){
alert(day_array[date.getDay()]+" "+month_array[date.getMonth()]+" "+date.getDate()+","+date.getFullYear())
}

//Determine current date
var objcurrentDate = new Date();
var current_date = objcurrentDate.getDate();
var current_year = objcurrentDate.getFullYear();
var current_month = objcurrentDate.getMonth();


//Function to return correct month given offset
function offset_month(offset,curmonth){
for (var i=0;i < Math.abs(offset);i++){
if (offset < 0){
	curmonth = curmonth-1;
		if(curmonth < 0){
			curmonth = 11;
		}
	}
	else
	if (offset > 0){
	curmonth = curmonth+1;
		if(curmonth > 11){
			curmonth = 0;
		}
	}
}
return curmonth;
}
//Function to return correct year given month offset
function offset_year(offset,curmonth,curyear){
for (var i=0;i < Math.abs(offset);i++){
if (offset < 0){
	curmonth = curmonth-1;
		if(curmonth < 0){
			curmonth = 11;
			curyear = curyear - 1;
		}
	}
	else
	if (offset > 0){
	curmonth = curmonth+1;
		if(curmonth > 11){
			curmonth = 0;
			curyear = curyear + 1;
		}
	}
}
return curyear;
}


//Function to return number of days in month
//Takes one parameter, a date object residing in the month in question
function days_in_month(tmpDate){
	//Determine number of days in month
var comparemonth = tmpDate.getMonth();
var compareyear = tmpDate.getFullYear();
//Make date object for first of month
var objOriginalDate = new Date(month_array[comparemonth] + " 01, " + compareyear + " 00:00:00");
//Make object for first of next month
comparemonth = comparemonth + 1;
if (comparemonth > 11){
	comparemonth = 0;
	compareyear = compareyear + 1;
	}
var objCompareDate = new Date(month_array[comparemonth] + " 01, " + compareyear + " 00:00:00");
//show_date(objCompareDate);
return (parseInt(((objCompareDate - objOriginalDate) / oneDay) + 0.5));
//return (parseInt((objCompareDate - objOriginalDate) / oneDay));
//alert(Days_in_Month);
}

//Function to return first day of month as numeric day.  Use to get day from day_array
function what_day_first(tmpDate){
var comparemonth = tmpDate.getMonth();
var compareyear = tmpDate.getFullYear();
//Make date object for first of month
var objOriginalDate = new Date(month_array[comparemonth] + " 01, " + compareyear + " 00:00:00");
return objOriginalDate.getDay();
}

//Function to return date
function put_back(datestring){
//Define field name
callerform = args["form"];
callerfield = args["field"];
//Create new date object to format from
var tmpDate = new Date(datestring);



switch(format){
	case "L":
//Format to Long Format
var returndate = day_array[tmpDate.getDay()] + " " + month_array[tmpDate.getMonth()] + " " + tmpDate.getDate() + ", " + tmpDate.getFullYear();
break;
	case "S":
//Format to Short Format
var returndate = (tmpDate.getMonth() + 1) + "/" + tmpDate.getDate() + "/" + tmpDate.getFullYear();
break;
	case "M":
//Format to Medium Format
var returndate = month_array[tmpDate.getMonth()] + " " + tmpDate.getDate() + ", " + tmpDate.getFullYear();
break;
}
//Send date back to calling field
opener.document.forms[callerform].elements[callerfield].value = returndate;

//Close window, you are done
self.close();

}


//Set variables to write table


//Create working date object offset from present date
var tempobjDate = new Date();
var objDate = new Date(month_array[offset_month(Current_Month_Offset,tempobjDate.getMonth())] + " "  + tempobjDate.getDate() + ", " +offset_year(Current_Month_Offset,tempobjDate.getMonth(),tempobjDate.getFullYear()) + " 00:00:00");
//alert((month_array[offset_month(Current_Month_Offset,tempobjDate.getMonth())] + " "  + tempobjDate.getDate() + ", " +offset_year(Current_Month_Offset,tempobjDate.getMonth(),tempobjDate.getFullYear()) + " 00:00:00"));



//Determine current day
//var current_day = objDate.getDay();

//Determine where 1st falls on
var first_day = what_day_first(objDate);

//Counter for days
var daycounter = 1;

//Determines days in month
Days_in_Month = days_in_month(objDate);





