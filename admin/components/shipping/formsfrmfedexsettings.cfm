<cfinclude template = "../queries/qryfedexsettings.cfm">
<cfinclude template = "../queries/qrysellingareas.cfm">

<cfform name="form1" method="post" action="doshipping.cfm">
  <p><strong>Fedex Shipping Setup:</strong></p>
  <p>Select which types of Fedex shipping services you will provide:</p>
  <p> 
    <input name="ShipCodes" type="checkbox"  value="STANDARDOVERNIGHT" <cfif qryFEDEXSettings.ServiceCodes CONTAINS 'STANDARDOVERNIGHT'>CHECKED</cfif>>
    Standard Overnight
    <input name="ShipCodes" type="checkbox"  value="PRIORITYOVERNIGHT" <cfif qryFEDEXSettings.ServiceCodes CONTAINS 'PRIORITYOVERNIGHT'>CHECKED</cfif>>
    Priority Overnight
    <input name="ShipCodes" type="checkbox"  value="FEDEXEXPRESSSAVER" <cfif qryFEDEXSettings.ServiceCodes CONTAINS 'FEDEXEXPRESSSAVER'>CHECKED</cfif> />
Fedex Express Saver
    <input name="ShipCodes" type="checkbox"  value="FEDEXGROUND" <cfif qryFEDEXSettings.ServiceCodes CONTAINS 'FEDEXGROUND'>CHECKED</cfif>>
    Fedex Ground 
    <br />
    <input name="ShipCodes" type="checkbox"  value="INTERNATIONALPRIORITY" <cfif qryFEDEXSettings.ServiceCodes CONTAINS 'INTERNATIONALPRIORITY'>CHECKED</cfif>>
    International Priority
    <input name="ShipCodes" type="checkbox"  value="INTERNATIONALECONOMY" <cfif qryFEDEXSettings.ServiceCodes CONTAINS 'INTERNATIONALECONOMY'>CHECKED</cfif>>
    International Economy 
    <input name="ShipCodes" type="checkbox"  value="INTERNATIONALFIRST" <cfif qryFEDEXSettings.ServiceCodes CONTAINS 'INTERNATIONALFIRST'>CHECKED</cfif> />
International First
  <p>Do you ship from multiple points (for US/Canada Only)?<strong> 
    <select name="MultipleShippingPoints" id="MultipleShippingPoints">
      <option <cfif qryFEDEXSettings.MultipleShippingPoints IS 'Yes'>SELECTED</cfif>>Yes</option>
      <option <cfif NOT qryFEDEXSettings.MultipleShippingPoints IS 'Yes'>SELECTED</cfif>>No</option>
    </select>
  </strong>
  <p>If you do not ship from multiple points (or are outside the US), 
    do you ship from a location other than the<br>
    address of your business?<strong> 
    <select name="ShipFromOtherLocation" id="ShipFromOtherLocation">
      <option <cfif qryFEDEXSettings.ShipFromOtherLocation IS 'Yes'>SELECTED</cfif>>Yes</option>
      <option <cfif NOT qryFEDEXSettings.ShipFromOtherLocation IS 'Yes'>SELECTED</cfif>>No</option>
    </select>
    </strong>
  <p>Fall Back Method: 
  <select name="fallbackmethod" id="fallbackmethod">
      <option value="1" <cfif qryFedexSettings.fallbackmethod IS '1'>selected="selected"</cfif>>No Fall Back Method</option>
      <option value="2" <cfif qryFedexSettings.fallbackmethod IS '2'>selected="selected"</cfif>>Based on Total Amount of Order</option>
      <option value="3" <cfif qryFedexSettings.fallbackmethod IS '3'>selected="selected"</cfif>>Based on Percentage of Order</option>
      <option value="5" <cfif qryFedexSettings.fallbackmethod IS '5'>selected="selected"</cfif>>Based on Total Weight</option>
      <option value="6" <cfif qryFedexSettings.fallbackmethod IS '6'>selected="selected"</cfif>>Based on Quantity of Items Ordered</option>
      <option value="8" <cfif qryFedexSettings.fallbackmethod IS '8'>selected="selected"</cfif>>Flat Rate For Each Item</option>
    </select>
  <cfoutput query = "qryFedexSettings">
  <p>Your Fedex Account Number: 
    <cfinput name="accountnumber" type="text" id="accountnumber" value="#accountnumber#" required="Yes" message="You must enter your Fedex Account Number">
  <p>Your Fedex Meter Number: 
    <cfinput name="metercode" type="text" value="#metercode#" message="You must enter your Fedex Meter Number">
  <p>Note: These values must be correct in order for this to work.  <a href = "doshipping.cfm?action=testfedex">Click here to test Fedex</a>
  <p>
</cfoutput>
    <input type="hidden" Name="Action" Value="UpdateFedexSettings">
    <input type="submit" name="Submit" value="Continue --&gt;">
</cfform>
<cfif qryFedexSettings.AccountNumber IS ''>
<p><strong>How to setup Fedex:</strong></p>
<p>To use the integrated Fedex shipping quotes you will need to complete the following 
  steps with Fedex (Note: You must have a valid Fedex Account Number): </p>
<p>1. Register for access to the Fedex XML API at the following address: <a href="https://www.fedex.com/cgi-bin/shipapiDownload.cgi?link=4&amp;first=y" target="_blank">https://www.fedex.com/cgi-bin/shipapiDownload.cgi?link=4&amp;first=y</a> (select XML Tools for &quot;Type of business and intended use&quot;). You will receive a confirmation email from fedex  with documentation and setup guide.</p>
<p><strong>2.</strong> Send an email to websupport@fedex.com requesting to have your  Express and/or Ground account number setup in the FedEx test environment and  request the gateway address your account requires to access the Fedex Servers.  You can also call their support line, which is very helpful and will usually  assist you with this information over the phone (1-800-810-9073)3. Select the &quot;Get XML Access Key option&quot;</p>
<p>3. <a href="doshipping.cfm?action=fedexregister">Click here</a> to perform a register request to obtain a valid meter number.</p>
</cfif>

