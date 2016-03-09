<cfinclude template="../queries/qrycompanyinfo.cfm">
<cfinclude template="../queries/qrystyles.cfm">
<h3>Custom Buttons <cfoutput><a href = "#request.AdminPath#helpdocs/custom_buttons.cfm" onclick="NewWindow(this.href,'Help','375','450','yes');return false;")><b><img src = "#request.AdminPath#images/help.gif" border="0" /></b></a></cfoutput></h3>
<cfif NOT qryStyles.themetouse IS 'A_Custom_Theme'>
  You currently have a theme applied to your website.  You cannot change the buttons unless you remove the theme first.  If you want to remvoe the current theme, click on Store Colors from the Setup menu.
  <cfabort>
</cfif>
<strong>Important note:  </strong>You may need clear your browser cache or refresh to see your changes after you have uploaded your new buttons.  Because browsers usually cache the images it might appear as though they did not change, when they have.
<p>
<form method="POST" enctype="multipart/form-data" action="dosetup.cfm">
  <table width="95%" border="1" cellpadding="4" cellspacing="0" bordercolor="#000000">
	<cfoutput>
      <tr> 
        <td colspan="2" valign="top"><p align="left"><strong>Current Add 
            to Cart Button</strong></p>
          <p align="left"><img src="#request.HomeURL##request.addtocart#">          </p>
          <p align="left"> 
            Change: 
            <INPUT NAME = "addtocart" Type = "file" size = "40">
          </p></td>
      </tr>
      <tr>
        <td colspan="2" valign="top">&nbsp;</td>
      </tr>
      <tr> 
        <td colspan="2" valign="top"><p align="left"><strong>Current Search Button</strong></p>
          <p align="left"><img src="#request.HomeURL##request.SearchButton#">          </p>
          <p align="left"> 
            Change: 
            <INPUT NAME = "SearchButton" Type = "file" size = "40">
          </p></td>
      </tr>
      <tr>
        <td colspan="2" valign="top">&nbsp;</td>
      </tr>
      <tr> 
        <td colspan="2" valign="top"><p align="left"><strong>Current Checkout Button</strong></p>
          <p align="left"><img src="#request.HomeURL##request.CheckoutButton#">          </p>
          <p align="left"> 
            Change: 
            <INPUT NAME = "CheckoutButton" Type = "file" size = "40">
          </p></td>
      </tr>
      <tr>
        <td colspan="2" valign="top">&nbsp;</td>
      </tr>
      <tr> 
        <td colspan="2" valign="top"><p align="left"><strong>Current Review Order Button</strong></p>
          <p align="left"><img src="#request.HomeURL##request.ReviewOrder#">          </p>
          <p align="left"> 
            Change: 
            <INPUT NAME = "ReviewOrder" Type = "file" size = "40">
          </p></td>
      </tr>
      <tr>
        <td colspan="2" valign="top">&nbsp;</td>
      </tr>
      <tr> 
        <td colspan="2" valign="top"><p align="left"><strong>Current Process Order Button</strong></p>
          <p align="left"><img src="#request.HomeURL##request.ProcessOrder#">          </p>
          <p align="left"> 
            Change: 
            <INPUT NAME = "ProcessOrder" Type = "file" size = "40">
          </p></td>
      </tr>
      <tr>
        <td colspan="2" valign="top">&nbsp;</td>
      </tr>
      <tr> 
        <td colspan="2" valign="top"><p align="left"><strong>Current Update Cart Button</strong></p>
          <p align="left"><img src="#request.HomeURL##request.UpdateCart#">          </p>
          <p align="left"> 
            Change: 
            <INPUT NAME = "UpdateCart" Type = "file" size = "40">
          </p></td>
      </tr>
      <tr>
        <td colspan="2" valign="top">&nbsp;</td>
      </tr>
      <tr> 
        <td colspan="2" valign="top"><p align="left"><strong>Current Print Button</strong></p>
          <p align="left"><img src="#request.HomeURL##request.PrintButton#">          </p>
          <p align="left"> 
            Change: 
            <INPUT NAME = "PrintButton" Type = "file" size = "40">
          </p></td>
      </tr>
      <tr>
        <td colspan="2" valign="top">&nbsp;</td>
      </tr>
      <tr> 
        <td colspan="2" valign="top"><p align="left"><strong>Current Login Button</strong></p>
          <p align="left"><img src="#request.HomeURL##request.LoginButton#">          </p>
          <p align="left"> 
            Change: 
            <INPUT NAME = "LoginButton" Type = "file" size = "40">
          </p></td>
      </tr>
      <tr>
        <td colspan="2" valign="top">&nbsp;</td>
      </tr>
      <tr> 
        <td colspan="2" valign="top"><p align="left"><strong>Current Continue Shopping Button</strong></p>
          <p align="left"><img src="#request.HomeURL##request.ContinueShopping#">          </p>
          <p align="left"> 
            Change: 
            <INPUT NAME = "ContinueShopping" Type = "file" size = "40">
          </p></td>
      </tr>
      <tr>
        <td colspan="2" valign="top">&nbsp;</td>
      </tr>                                          
    </cfoutput> 
  </table>
  <p align="center">
  	<input type="hidden" name="action" value="UpdateButtons">
    <input type="submit" name="Submit" value="Update Buttons">
  </p>
</form>







