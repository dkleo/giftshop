<h2>Coupon Codes</h2>
<table width="100%" border="0">
  <tr>
    <td width="1%"><div align="center"><a href="index.cfm?action=add"><br>
    </a></div></td>
    <td><a href="index.cfm?action=new">Create a Coupon Code </a></td>
    <td><div align="right"></div></td>
  </tr>
</table>
<cfset CurrentDate = now()>

<cfinclude template = '../queries/qrycoupons.cfm'>
<table width="100%" border="0" cellspacing="0" cellpadding="6">
  <tr bgcolor="#0033CC">
    <td bgcolor="#0066CC"><font color="#FFFFFF"><strong>Code</strong></font></td>
    <td bgcolor="#0066CC"><font color="#FFFFFF"><strong>Exp. Date</strong></font></td>
    <td bgcolor="#0066CC"><font color="#FFFFFF"><strong>Status</strong></font></td>
    <td bgcolor="#0066CC"><div align="center"><font color="#FFFFFF"><strong>Amount Off</strong></font></div></td>
    <td bgcolor="#0066CC"><font color="#FFFFFF"><strong>Coupon Code For</strong></font></td>
    <td bgcolor="#0066CC"><font color="#FFFFFF"><strong></strong></font></td>
  </tr>
  <cfloop query = "qryCoupons">
    <tr <cfif qryCoupons.CurrentRow MOD 2>bgcolor="#CCCCCC"</cfif>>
      <td><cfoutput><a href = "index.cfm?action=Edit&promoID=#promoID#">#PromoCode#</a></cfoutput></td>
      <td><cfoutput>#dateformat(ExpiresOn, 
          "mm/dd/yyyy")#</cfoutput></td>
      <td><cfif CurrentDate LTE #ExpiresOn#>
          Active</cfif> <cfif CurrentDate GT #ExpiresOn#>
          Expired</cfif></td>
      <td><cfif PromoType IS 'PercentOff'>
          <cfoutput>
            <div align="center">#AmountOff#%</div>
          </cfoutput></cfif> <cfoutput> 
            <div align="center">
              <cfif PromoType IS 'AmountOff'>
                <cfif request.EnableEuro IS 'Yes'>
                  #lseurocurrencyformat(AmountOff, "Local")# 
                  <cfelse>
                  #lscurrencyformat(AmountOff, "Local")# 
                </cfif>
                </cfif>
                </div>
        </cfoutput></td>
      <td> 
        <!---If the category ID is 0 then it's the entire store--->
        <cfif CategoryID IS '0'>
          Entire Store</cfif> 
        <!---If the category is specified and the productid is 0 then it's all the items in that category--->
        <cfif CategoryID IS '0' AND ProductID IS '0'>
          <cfquery name = "FindCategory" datasource="#request.dsn#">
          SELECT * FROM categories WHERE CategoryID = #CategoryID# 
          </cfquery>
          <cfoutput query = "FindCategory">All in #CategoryName#</cfoutput> </cfif> 
        <cfif NOT CategoryID IS '0' AND ProductID IS '0'>
          <cfquery name = "FindCategory" datasource="#request.dsn#">
          SELECT * FROM categories WHERE CategoryID = #CategoryID# 
          </cfquery>
          <cfoutput query = "FindCategory">All in #CategoryName#</cfoutput> </cfif> 
        <cfif NOT CategoryID IS '0' AND NOT ProductID IS '0'>
          <cfquery name = "FindProduct" datasource="#request.dsn#">
          SELECT * FROM products WHERE ItemID = #ProductID# 
          </cfquery>
          <cfoutput query = "FindProduct">#ProductName#</cfoutput></cfif>
		  <cfif CanBeCombined IS 'No'><superscript>*</superscript></cfif>
		  <cfoutput><cfif NOT cLimit IS 0> limit #cLimit#</cfif></cfoutput></td>
      <td><cfoutput><a href = "index.cfm?action=Delete&promoID=#promoID#"><img src="../../icons/delete.gif" width="16" height="16" border="0"></a></cfoutput></td>
    </tr>
  </cfloop>
</table>
<p>* This coupon code cannot be combined with other coupon codes. This means, 
  if this one is added to their shopping cart, any other coupons entered will 
  be removed.</p>




















