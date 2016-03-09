<h2>Editing Coupons Code</h2>
<cfinclude template = "../queries/qrycoupons.cfm">
<p>Use the form below to change the expiration date, code, and the number of times 
  a coupon code can be used. </p>
<cfoutput query = "qryCoupons">
<cfform name="form1" method="post" action="index.cfm">
    <table width="100%" border="0" cellpadding="1" cellspacing="0">
      <tr> 
        <td>Code: 
          <cfinput name="PromoCode" type="text" id="PromoCode" value="#PromoCode#" size="30" required="Yes" message="You must create a code to represent this coupon"></td>
        <td>&nbsp;</td>
        <td>&nbsp;</td>
      </tr>
      <tr> 
        <td width="22%">Expiration Date: 
          <cfinput name="ExpiresOn" type="text" id="ExpiresOn" size="10" value='#dateformat(ExpiresOn, "mm/dd/yyyy")#' required="Yes" message="You must provide a valid end date for this sale"> 
          <a href = "Calendar Control" onClick="JavaScript:window.open('calendar.html?form=form1&field=ExpiresOn&format=S&bgcolor=Yellow&txtcolor=Blue&hdrcolor=CornFlowerBlue&todaycolor=White&offset=0','cal','noresize,width=225,height=160');return false"><img border="0" src="icons/calendar.gif" width="16" height="16" alt="Select Date from Calendar"></a></td>
        <td width="21%"> Times this can be used: 
          <cfinput name="timesallowed" type="text" value="#TimesAllowed#" size="3" required="Yes" message="You must enter a value for the Times Allowed"></td>
        <td width="19%"> <div align="left">Limit: 
            <input name="cLimit" type="text" id="cLimit" value="#cLimit#" size="5">
            <font size="1"> (enter 0 for no limit)</font> </div></td>
      </tr>
      <tr> 
        <td valign="top"><p>Can this coupon code be combined with other coupon 
            codes?</p>
          <p><font size="1">NOTE: (select 'No' if you don't want your customers 
            using other coupons with this one to get a bigger discount on the 
            specified item or category.</font></p></td>
        <td valign="top"><select name="CanBeCombined">
            <option <cfif CanBeCombined IS 'Yes'>SELECTED</cfif>>Yes</option>
            <option <cfif CanBeCombined IS 'No'>SELECTED</cfif>>No</option>
          </select></td>
        <td align="center" valign="middle"> <input type="hidden" name="action" value="Update"> <input type="hidden" name="promoid" value="#promoID#"> 
          <input type="submit" name="Submit" value="Update Coupon Code"></td>
      </tr>
    </table>
  <p>&nbsp;</p>
  </cfform>
</cfoutput>



















