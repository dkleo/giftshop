<cfinclude template = "../queries/qryupssettings.cfm">
<cfinclude template = "../queries/qrysellingareas.cfm">

<cfform name="form1" method="post" action="doshipping.cfm">
  <p><strong>UPS Shipping Setup:</strong></p>
  <p>Select which types of UPS shipping services you will provide:</p>
  <p> 
    <input name="ShipCodes" type="checkbox"  value="01" <cfif qryUPSSettings.ServiceCodes CONTAINS '01'>CHECKED</cfif>>
    UPS Next Day Air 
    <input name="ShipCodes" type="checkbox"  value="02" <cfif qryUPSSettings.ServiceCodes CONTAINS '02'>CHECKED</cfif>>
    UPS 2nd Day Air 
    <input name="ShipCodes" type="checkbox"  value="12" <cfif qryUPSSettings.ServiceCodes CONTAINS '12'>CHECKED</cfif>>
    UPS 3-Day Select 
    <input name="ShipCodes" type="checkbox"  value="03" CHECKED>
UPS Ground <br />
<input name="ShipCodes" type="checkbox"  value="07" <cfif qryUPSSettings.ServiceCodes CONTAINS '07'>CHECKED</cfif>>
    UPS Worldwide Express 
    <input name="ShipCodes" type="checkbox"  value="08" <cfif qryUPSSettings.ServiceCodes CONTAINS '08'>CHECKED</cfif>>
	UPS Worldwide Expedited
    <input name="ShipCodes" type="checkbox"  value="13" <cfif qryUPSSettings.ServiceCodes CONTAINS '13'>CHECKED</cfif>>
UPS Next Day Air Saver <br />
<input name="ShipCodes" type="checkbox"  value="11" CHECKED>
	UPS Standard (To Canada)
  <p><strong>Do you ship from multiple points (for US/Canada Only)? 
    <select name="MultipleShippingPoints" id="MultipleShippingPoints">
      <option <cfif qryUPSSettings.MultipleShippingPoints IS 'Yes'>SELECTED</cfif>>Yes</option>
      <option <cfif NOT qryUPSSettings.MultipleShippingPoints IS 'Yes'>SELECTED</cfif>>No</option>
    </select>
    </strong>
  <p><strong>If you do not ship from multiple points (or are outside the US), 
    do you ship from a location other than the<br>
    address</strong> <strong>of your business? 
    <select name="ShipFromOtherLocation" id="ShipFromOtherLocation">
      <option <cfif qryUPSSettings.ShipFromOtherLocation IS 'Yes'>SELECTED</cfif>>Yes</option>
      <option <cfif NOT qryUPSSettings.ShipFromOtherLocation IS 'Yes'>SELECTED</cfif>>No</option>
    </select>
    </strong>
  <p>Fallback Method:   
  <select name="fallbackmethod" id="fallbackmethod">
      <option value="1" <cfif qryUPSSettings.fallbackmethod IS '1'>selected="selected"</cfif>>No Fall Back Method</option>
      <option value="2" <cfif qryUPSSettings.fallbackmethod IS '2'>selected="selected"</cfif>>Based on Total Amount of Order</option>
      <option value="3" <cfif qryUPSSettings.fallbackmethod IS '3'>selected="selected"</cfif>>Based on Percentage of Order</option>
      <option value="5" <cfif qryUPSSettings.fallbackmethod IS '5'>selected="selected"</cfif>>Based on Total Weight</option>
      <option value="6" <cfif qryUPSSettings.fallbackmethod IS '6'>selected="selected"</cfif>>Based on Quantity of Items Ordered</option>
      <option value="8" <cfif qryUPSSettings.fallbackmethod IS '8'>selected="selected"</cfif>>Flat Rate For Each Item</option>
    </select>
  <cfoutput query = "qryUPSSettings">
  <p>UPS Server Access Key: 
    <cfinput name="AccessKey" type="text" id="AccessKey" value="#AccessKey#" required="Yes" message="You must enter your UPS Access Key">
  <p> UPS Server Username: 
    <cfinput name="UPSUsername" type="text" value="#UserName#" message="You must enter your UPS Username">
  <p>UPS Server password: 
    <cfinput name="UPSPassword" type="text" value="#password#" message="You must enter your UPS password">
  <p>
</cfoutput>
<p>
The UPS Accesskey, Username, and password information has been hidden by the administrator of this site.<br>
If you need to modify this information, please contact the administrator.
<p>
<cfif LEN(qryUPSSettings.AccessKey) GT 0>
<p>
You can test your UPS settings by <a href="doshipping.cfm?action=testups">clicking here</a>.</p>
<p>&nbsp; </p>
</cfif>
    <input type="hidden" Name="Action" Value="UpdateUPSSettings">
    <input type="submit" name="Submit" value="Continue --&gt;">
</cfform>
<cfif qryUPSSettings.AccessKey IS ''>
<p><strong>How to setup UPS:</strong></p>
<p>To use the built in UPS XML Custom Tag you will need to complete the following 
  steps with UPS, once complete you will have the UPSUserID (Registered username), 
  UPSPassword (Registered password) and UPSAccessKey (UPS XML Access Key) needed 
  for the above form.</p>
<p>1. Register with UPS, link to do this can be found <a href="https://www.ups.com/servlet/registration?loc=en_US_EC&returnto=http://www.ec.ups.com/ecommerce/techdocs/online_tools.html" target="_blank">here</a></p>
<p>2. You will need to request a developers key, but in order to do that you need to setup an account with UPS (this means you must provide a credit card to UPS to bill your shipments to if you do not have a high volume of shipments each week). Once you have an account setup, <a href="http://www.ups.com/e_comm_access/laServ?loc=en_US">click here</a>. Then scroll down and click on the UPS Tracking link. If you are presented with a form, you need to request the developers key, fill it out making sure to enter your UPS account number. The key will be emailed to you.</p>
<p>3. Next you need the XML Access Key and you can get that <a href="https://www.ups.com/e_comm_access/laServ?CURRENT_PAGE=GET_ACCESS_KEY&amp;START_PAGE=WELCOME&amp;OPTION=ACCESS_LIC_XML&amp;loc=en_US" target="_blank">here</a></p>
<p>4. Copy and paste the Developer key you received from step 2 and click on submit.</p>
<p>5. UPS will display your new access key and inform you that you have access to tracking info, etc. Copy and past your new key into the form above along with your username and password.</p>
</cfif>
