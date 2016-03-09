<cfinclude template = "../queries/qrycompanyinfo.cfm">
 <cfoutput Query="qryCompanyInfo"> 
  <form method="POST" action="dosetup.cfm">
    
  <h2 align="left"><strong>Payment Settings</strong> <a href = "#request.AdminPath#helpdocs/payment_methods.cfm" onclick="NewWindow(this.href,'Help','375','450','yes');return false;")><b><img src = "#request.AdminPath#images/help.gif" border="0" /></b></a></h2>
  <p align="left"><strong>Credit Card Types you can accept:</strong></p>
  <blockquote>
  <p align="left"> 
        <input type="checkbox" name="Mastercard" value="ON" <cfif #MasterCard# IS "Yes">checked="checked"</cfif>>
        Master Card<br>
        <input type="checkbox" name="Visa" value="ON" <cfif #Visa# IS "Yes">checked="checked"</cfif>>
        Visa Card<br>
        <input type="checkbox" name="Discover" value="ON" <cfif #Discover# IS "Yes">checked="checked"</cfif>>
        Discover Card<br>
        <input type="checkbox" name="Amex" value="ON" <cfif #Amex# IS "Yes">checked="checked"</cfif>>
        American Express<br>
        <input type="checkbox" name="JCB" value="ON" <cfif #JCB# IS "Yes">checked="checked"</cfif>>
        JCB<br>
        <input type="checkbox" name="ACH" value="ON" <cfif #ACH# IS "Yes">checked="checked"</cfif>>
        Diners Club</p>
    </blockquote>
</cfoutput><p align="center"><input type="hidden" value="SetPaymentMethods" name= "action">
      <input type="submit" value="Update Settings" name="B1">
    </p>
</form>
  </center>









