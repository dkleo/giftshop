<h2>Editing a Sale</h2>
<cfinclude template = "../queries/qrysales.cfm">
<cfinclude template = "../queries/qrypricinglevels.cfm">
<p>You can change the start and the end date of a sale. If you want to change 
  which items are on sale, you will need to add a new sale and remove the existing 
  one. Note: You can only change the start date of a future sale.</p>
<cfoutput query = "qrySales">
<cfform name="form1" method="post" action="dosales.cfm">
  <table width="100%" border="0" cellpadding="1" cellspacing="0">
    <tr> 
      <td width="22%">Start Date: 
	  <cfif StartDate GT Now()>
        <cfinput name="StartDate" type="text" id="StartDate" size="10" Value='#dateformat(StartDate, "mm/dd/yyyy")#' required="Yes" message="You must provide a valid start date for this sale">
		<a href = "Calendar Control" onClick="JavaScript:window.open('calendar.html?form=form1&field=StartDate&format=S&bgcolor=Yellow&txtcolor=Blue&hdrcolor=CornFlowerBlue&todaycolor=White&offset=0','cal','noresize,width=225,height=160');return false">        <img border="0" src="icons/calendar.gif" width="16" height="16" alt="Select Date from Calendar"></a> 
	  <cfelse>
	  	#dateformat(StartDate)#<input type = "hidden" name="StartDate" Value='#dateformat(StartDate, "mm/dd/yyyy")#'>
	  </cfif>		</td>
      <td width="21%">End Date: 
        <cfinput name="EndDate" type="text" id="EndDate" size="10" Value='#dateformat(EndDate, "mm/dd/yyyy")#' required="Yes" message="You must provide a valid end date for this sale"> 
        <a href = "Calendar Control" onClick="JavaScript:window.open('calendar.html?form=form1&field=EndDate&format=S&bgcolor=Yellow&txtcolor=Blue&hdrcolor=CornFlowerBlue&todaycolor=White&offset=0','cal','noresize,width=225,height=160');return false"><img border="0" src="icons/calendar.gif" width="16" height="16" alt="Select Date from Calendar"></a></td>
      <td width="19%"><select name="level" id="level">
        <option value="0" <cfif qrySales.level IS '0'>selected</cfif>>0</option>
        <cfloop query="qLevels">
        <option value="#level#" <cfif qrySales.level IS qLevels.level>selected</cfif>>#level#</option>
        </cfloop>
      </select></td>
      <td width="19%"><div align="center">
	  	  <input type="hidden" name="action" value="Update">
		  <input type="hidden" name="saleid" value="#saleid#">
          <input type="submit" name="Submit" value="Update Sale Dates">
        </div></td>
    </tr>
  </table>
  <p>&nbsp;</p>
  </cfform>
</cfoutput>















