<script language="Javascript">
function ShowSymbol() {
if (form1.SaleType.value == 'PercentOff') {
	MoneySign.style.visibility = 'hidden';
	PercentSign.style.visibility = 'visible';
	}
if (form1.SaleType.value == 'AmountOff') {
	MoneySign.style.visibility = 'visible';
	PercentSign.style.visibility = 'hidden';
	}

}
</script>

<cfset TempStartDate = now()>
<cfset TempEndDate = now() + 7>

<cfparam name = "StartDate" default='#Dateformat(TempStartDate, "m/dd/yyyy")#'>
<cfparam name = "EndDate" default='#Dateformat(TempEndDate, "m/dd/yyyy")#'>
<cfparam name = "AmountOff" default="">
<cfparam name = "CategoryID" default="0">
<cfparam name = "SaleType" default="PercentOff">
<cfparam name = "level" default="0">

<cfif ISDEFINED('form.CategoryID')>
	<cfinclude template = "../queries/qryproducts.cfm">
</cfif>

<cfinclude template = "../queries/qrypricinglevels.cfm">

<h2>Schedule a Sale</h2>
<cfoutput>
<cfif NOT ISDEFINED('form.CategoryID')>
<cfform name="form1" method="post" action="dosales.cfm?action=new">
  <table width="100%" border="0" cellspacing="0" cellpadding="1">
    <tr> 
      <td width="22%">Start Date: 
        <cfinput name="StartDate" type="text" id="StartDate" size="10" Value='#StartDate#' required="Yes" message="You must provide a valid start date for this sale"> <a href = "Calendar Control" onClick="JavaScript:window.open('calendar.html?form=form1&field=StartDate&format=S&bgcolor=Yellow&txtcolor=Blue&hdrcolor=CornFlowerBlue&todaycolor=White&offset=0','cal','noresize,width=225,height=160');return false"> 
        <img border="0" src="icons/calendar.gif" width="16" height="16" alt="Select Date from Calendar"></a></td>
      <td width="21%">End Date: 
        <cfinput name="EndDate" type="text" id="EndDate" size="10" Value='#EndDate#' required="Yes" message="You must provide a valid end date for this sale"> <a href = "Calendar Control" onClick="JavaScript:window.open('calendar.html?form=form1&field=EndDate&format=S&bgcolor=Yellow&txtcolor=Blue&hdrcolor=CornFlowerBlue&todaycolor=White&offset=0','cal','noresize,width=225,height=160');return false"><img border="0" src="icons/calendar.gif" width="16" height="16" alt="Select Date from Calendar"></a></td>
      <td width="18%">Type: 
        <select name="SaleType" Onchange="ShowSymbol()">
          <option value="PercentOff" <cfif SaleType IS 'PercentOff'>SELECTED</cfif>>Percent Off</option>
          <option value="AmountOff" <cfif SaleType IS 'AmountOff'>SELECTED</cfif>>Amount Off</option>
        </select></td>
      <td width="20%"><a Name="MoneySign" id="MoneySign" style="visibility: hidden">$</a> 
        <cfinput type = "text" name="AmountOff" size="3" value="#AmountOff#" required="Yes" message="You need to enter an amount off"> <a Name="PercentSign" id="PercentSign" style="visibility: visible">%</a></td>
      <td width="19%">&nbsp;</td>
    </tr>
    <tr> 
      <td>Pricing Level This Applies To:</td>
      <td>
      <select name="level" id="level">
      <option value="0" <cfif qLevels.level IS '0'>selected</cfif>>0</option>
      <cfloop query="qLevels">
        <option value="#level#" <cfif level IS qLevels.level>selected</cfif>>#level#</option>
      </cfloop>
      </select>
	 </td>
      <td>&nbsp;</td>
      <td>&nbsp;</td>
      <td>&nbsp;</td>
    </tr>
    <tr> 
      <td colspan="2" valign="top"><p><strong>Choose a Category to Apply this 
          to:</strong></p>
        <p>
          <cfselect name="CategoryID" size="12" required="Yes" message="Please select a category or choose Entire Catalog" onclick="this.form.submit();">
            <option value = "0">Entire Catalog</option>
            <cf_CategoryTree Directory="/"
				ShowCurrentView="Yes"
				SelectedItem="#CategoryID#"
				Datasource="#request.dsn#"> 
          </cfselect>
        </p></td>
      <td colspan="2" valign="top"><p><strong>Choose a Product to Apply this to:</strong></p>
        <p>
          <select name="ProductID" size="12" <cfif NOT ISDEFINED('form.CategoryID')>disabled</cfif>>
		   <cfif NOT ISDEFINED('form.CategoryID')><option value="0">Choose from box on left</option></cfif>
			<cfif ISDEFINED('form.CategoryID')>
            	<option value = "0" SELECTED>Entire Category</option>
				<cfloop query = 'qryProducts'>
					<option value = '#ItemID#'>#qryProducts.ProductName#</option>
				</cfloop>
			</cfif>
          </select>
        </p></td>
		<td></td>
    </tr>
  </table>
</cfform>

<cfelse>

<cfform name="form1" method="post" action="dosales.cfm">
  <table width="100%" border="0" cellspacing="0" cellpadding="1">
    <tr> 
      <td width="22%">Start Date: 
        <cfinput name="StartDate" type="text" id="StartDate" size="10" Value='#StartDate#' required="Yes" message="You must provide a valid start date for this sale"> <a href = "Calendar Control" onClick="JavaScript:window.open('calendar.html?form=form1&field=StartDate&format=S&bgcolor=Yellow&txtcolor=Blue&hdrcolor=CornFlowerBlue&todaycolor=White&offset=0','cal','noresize,width=225,height=160');return false"> 
        <img border="0" src="icons/calendar.gif" width="16" height="16" alt="Select Date from Calendar"></a></td>
      <td width="21%">End Date: 
        <cfinput name="EndDate" type="text" id="EndDate" size="10" Value='#EndDate#' required="Yes" message="You must provide a valid end date for this sale"> <a href = "Calendar Control" onClick="JavaScript:window.open('calendar.html?form=form1&field=EndDate&format=S&bgcolor=Yellow&txtcolor=Blue&hdrcolor=CornFlowerBlue&todaycolor=White&offset=0','cal','noresize,width=225,height=160');return false"><img border="0" src="icons/calendar.gif" width="16" height="16" alt="Select Date from Calendar"></a></td>
      <td width="18%">Type: 
        <select name="SaleType" Onchange="ShowSymbol()">
          <option value="PercentOff" <cfif SaleType IS 'PercentOff'>SELECTED</cfif>>Percent Off</option>
          <option value="AmountOff" <cfif SaleType IS 'AmountOff'>SELECTED</cfif>>Amount Off</option>
        </select></td>
      <td width="20%"><a Name="MoneySign" id="MoneySign" style="visibility: hidden">$</a> 
        <input type = "text" name="AmountOff" size="3" value="#AmountOff#"> <a Name="PercentSign" id="PercentSign" style="visibility: visible">%</a></td>
      <td width="19%">&nbsp;</td>
    </tr>
    <tr> 
      <td>Pricing Level This Applies To:</td>
      <td>
        <select name="level" id="level">
            <option value="0" <cfif level IS '0'>selected</cfif>>0</option>
            <cfloop query="qLevels">
            <option value="#level#" <cfif level IS qLevels.level>selected</cfif>>#level#</option>
            </cfloop>
        </select>     
      </td>
      <td>&nbsp;</td>
      <td>&nbsp;</td>
      <td>&nbsp;</td>
    </tr>
    <tr> 
      <td colspan="2" valign="top"><p><strong>Choose a Category to Apply this 
          to:</strong></p>
        <p>
          <select name="CategoryID" size="12" disabled>
            <option value = "0" <cfif form.CategoryID IS '0'>SELECTED</cfif>>Entire Catalog</option>
            <cf_CategoryTree Directory="/"
				ShowCurrentView="Yes"
				SelectedItem="#CategoryID#"
				Datasource="#request.dsn#"> 
          </select>
		  <input type = "hidden" Name="CategoryID" Value="#form.categoryID#">
        </p></td>
      <td colspan="2" valign="top"><p><strong>Choose a Product to Apply this to:</strong></p>
        <p>
          <select name="ProductID" size="12" <cfif NOT ISDEFINED('form.CategoryID')>disabled</cfif>>
		   <cfif NOT ISDEFINED('form.CategoryID')><option value="0">Choose from box on left</option></cfif>
			<cfif ISDEFINED('form.CategoryID')>
            	<cfif NOT form.CategoryID IS '0'><option value = "0" SELECTED>Entire Category</option>
					<cfelse><option value = "0" SELECTED>Entire Catalog</option>
				</cfif>
				<cfloop query = 'qryProducts'>
					<option value = '#ItemID#'>#qryProducts.ProductName#</option>
				</cfloop>
			</cfif>
          </select>
        </p></td>
		<td>
		<cfif ISDEFINED('form.categoryID')><input type="hidden" name="action" value="add">
		<input type="submit" value="Create Sale" name="submitbutton"></cfif></td>
    </tr>
  </table>
</cfform>
</cfif>
</cfoutput>
<p><strong></strong></p>
<p>&nbsp;</p>
</body>
</html>
















