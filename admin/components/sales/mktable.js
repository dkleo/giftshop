//Begin compilation of calendar
//Create Header Table
document.write("<table width = '100%'>");
document.write("<tr>");
	document.write("<td><a href = 'calendar.html?offset="+eval(Current_Month_Offset-1)+"&form="+formname+"&field="+fieldname+"&bgcolor="+bgcolor+"&txtcolor="+txtcolor+"&hdrcolor="+hdrcolor+"&todaycolor="+todaycolor+"&format="+format+"'><font size='-6' color = '"+txtcolor+"'>Previous</font></a></td>");
	document.write("<td><div align='center' ID = 'display_month'>");
	document.write("<font size='-1' color='"+txtcolor+"'>");
	document.write(month_array[objDate.getMonth()]+"   "+objDate.getFullYear());  
	document.write("</font>");
	document.write("</div>");
	document.write("</td>");
	document.write("<td align='right'><a href = 'calendar.html?offset="+eval(Current_Month_Offset+1)+"&form="+formname+"&field="+fieldname+"&bgcolor="+bgcolor+"&txtcolor="+txtcolor+"&hdrcolor="+hdrcolor+"&todaycolor="+todaycolor+"&format="+format+"'><font size='-6' color = '"+txtcolor+"'>Next</font></a></td>");
	document.write("</tr>");
	document.write("</table>");

//Start table


document.write("<table width='100%' border='0'>");

for(var i=0;i<7;i++){
document.write("<th bgcolor='"+hdrcolor+"'><font size='-6' color = '"+txtcolor+"'>" + day_array[i].substring(0,3) + "</font></th>")
}

//Set firstrow variable to determine where to insert first
var firstrow = 1;
//j=rows
for(var j=0;j<6;j++){
	document.write("<tr>");
	//k=columns
		for(var k=0;k<7;k++){
		//Make sure firstrow occurs once
		if (first_day == k){
		firstrow = 0
		}
		if ((k < first_day && firstrow == 1) || (Days_in_Month < daycounter )){
		document.write("<td bgcolor='"+bgcolor+"'><div align='center'><font size='-6' color = '"+txtcolor+"'></font></div></td>");			
		}
		else
		{
			if (daycounter == current_date && objDate.getMonth() == current_month && objDate.getFullYear() == current_year){
				
				if(args["form"] && args["field"]){
				document.write("<td bgcolor='"+todaycolor+"'><div align='center'><a href='JavaScript:put_back(\""+(objDate.getMonth()+1)+"/"+daycounter+"/"+objDate.getFullYear()+"\")'><font size='-6' color = '"+txtcolor+"'>"+daycounter+"</font></a></div></td>");		
				}
				else
				{
				document.write("<td bgcolor='"+todaycolor+"'><div align='center'><font size='-6' color = '"+txtcolor+"'>"+daycounter+"</font></div></td>");			
				}
			}
			else
			{
			if(args["form"] && args["field"]){
				document.write("<td bgcolor='"+bgcolor+"'><div align='center'><a href='JavaScript:put_back(\""+(objDate.getMonth()+1)+"/"+daycounter+"/"+objDate.getFullYear()+"\")'><font size='-6' color = '"+txtcolor+"'>"+daycounter+"</font></a></div></td>");			
				}
				else
				{
				document.write("<td bgcolor='"+bgcolor+"'><div align='center'><font size='-6' color = '"+txtcolor+"'>"+daycounter+"</font></div></td>");			
				}
			}
		daycounter ++;
		}
		}
	document.write("</tr>");
}	

//Finish table
document.write("</table>");

