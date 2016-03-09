<h2>Sales</h2>
<table width="100%" border="0" cellspacing="0" cellpadding="2">
  <tr>
    <td valign="middle"><a href="dosales.cfm?action=new">Schedule a Sale</a></td>
  </tr>
</table>
<cfset CurrentDate = now()>
<cfinclude template = '../queries/qrysales.cfm'>
<table width="100%" border="0" cellspacing="0" cellpadding="6">
  <tr bgcolor="#0033CC"> 
    <td bgcolor="#006633"><font color="#FFFFFF"><strong>Start Date</strong></font></td>
    <td bgcolor="#006633"><font color="#FFFFFF"><strong>End Date</strong></font></td>
    <td bgcolor="#006633"><font color="#FFFFFF"><strong>Status</strong></font></td>
    <td bgcolor="#006633"><div align="center"><font color="#FFFFFF"><strong>Amount Off</strong></font></div></td>
    <td bgcolor="#006633"><font color="#FFFFFF"><strong>Sale on</strong></font></td>
	<td bgcolor="#006633"><strong><font color="#FFFFFF">Level</font></strong></td>
	<td bgcolor="#006633"><font color="#FFFFFF"><strong></strong></font></td>
  </tr>
  <cfloop query = "qrySales">
    <tr <cfif qrySales.CurrentRow MOD 2>bgcolor="#CCCCCC"</cfif>> 
      <td><cfoutput><a href = "dosales.cfm?action=Edit&saleid=#saleid#">#dateformat(StartDate, "mm/dd/yyyy")#</cfoutput></a></td>
      <td><cfoutput><a href = "dosales.cfm?action=Edit&saleid=#saleid#">#dateformat(EndDate, "mm/dd/yyyy")#</a></cfoutput></td>
      <td><cfif CurrentDate GTE #StartDate# AND CurrentDate LTE #EndDate#>Active</cfif>
	  	  <cfif CurrentDate GT #EndDate#>Ended</cfif>
		  <cfif CurrentDate LT #StartDate#>Scheduled</cfif>	  </td>
      <td><cfif SaleType IS 'PercentOff'>
          <cfoutput>#AmountOff#%</cfoutput></cfif> <cfoutput> 
          <cfif SaleType IS 'AmountOff'>
            <cfif request.EnableEuro IS 'Yes'>
              <div align="center">#lseurocurrencyformat(AmountOff, "Local")# 
                <cfelse>
              #lscurrencyformat(AmountOff, "Local")#                </div>
            </cfif>
          </cfif>
        </cfoutput></td>
      <td> 
        <!---If the category ID is 0 then it's the entire store--->
        <cfif CategoryID IS '0'>
          Entire Store</cfif> 
        <!---If the category is specified and the productid is 0 then it's all the items in that category--->
        <cfif NOT CategoryID IS '0' AND ProductID IS '0'>
          <cfquery name = "FindCategory" datasource="#request.dsn#">
          SELECT * FROM categories WHERE CategoryID = #CategoryID# 
          </cfquery>
          <cfoutput query = "FindCategory">All 
        in #CategoryName#</cfoutput> </cfif> <cfif NOT CategoryID IS '0' AND ProductID IS '0'>
          <cfquery name = "FindCategory" datasource="#request.dsn#">
          SELECT * FROM categories WHERE CategoryID = #CategoryID# 
          </cfquery>
          <cfoutput query = "FindCategory">All 
          in #CategoryName#</cfoutput> </cfif> <cfif NOT CategoryID IS '0' AND NOT ProductID IS '0'>
          <cfquery name = "FindProduct" datasource="#request.dsn#">
          SELECT * FROM products WHERE ItemID = #ProductID# 
          </cfquery>
          <cfoutput query = "FindProduct">#ProductName#</cfoutput></cfif></td>
		  <td><div align="center"><cfoutput>#level#</cfoutput></div></td>
		  <td><cfoutput><a href = "dosales.cfm?action=Delete&saleid=#saleid#"><img src="../../icons/delete.gif" width="16" height="16" border="0"></a></cfoutput></td>
    </tr>
  </cfloop>
</table>
