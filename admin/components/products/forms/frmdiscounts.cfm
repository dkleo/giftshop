<!---This page handles all the volume discount actions--->
<cfset waserror=0>
<div>
<cfif ISDEFINED('url.itemid')>
    <cflock scope="Session" type="Exclusive" Timeout="10">
        <cfset session.EditID = #url.itemid#>
    </cflock>
</cfif>

<cfoutput>
    <cflock scope="Session" type="Readonly" Timeout="10">
        <cfset TempVar.EditID = #Session.EditID#>
    </cflock>
</cfoutput>

<cfinclude template = "../queries/qrydiscounts.cfm">
<cfinclude template = "../queries/qryfindproduct.cfm">
<cfinclude template = "../queries/qrycategories.cfm">
<cfinclude template = "../queries/qryitemcategories.cfm">
<cfinclude template = "../queries/qrypricinglevels.cfm">

<cfoutput query ="qryFindProduct">
	<cfset CategoryList = '#Category#'>
</cfoutput>

<div align="left">
<h2>Volume Discounts</h2>
<p>
<cfoutput query = "qryFindProduct"><b><a href="doproducts.cfm?action=discounts&ItemID=#TempVar.EditID#">Discounts For #ProductName#</a></b></cfoutput>
</div>

<cfparam name="AmountOff" default="0.00">
<cfparam name="MinQ" default="2">

<CFIF IsDefined('form.discounts')>

	<cfif discounts IS 'Delete'>
        <cfquery Name='DeleteDiscount' Datasource = "#request.dsn#">
        DELETE FROM discounts
        WHERE DiscountID = #url.DiscountID#
        </cfquery>
        
        <cflocation url="doproducts.cfm?Action=discounts">
    </cfif>

	<cfif discounts is "Add" OR discounts is "Update">

		<cfif #form.AmountOff# IS ''>
            <font color="FF0000" size="4"><b>ERROR:</b>  You must specify an amount off (either a percentage in decimal format
            or a specific dollar amount off for each discount you add.</font><br>
            <cfset waserror = 1>
        </cfif>
    
        <cfif NOT isnumeric(form.AmountOff)>
            <font color="FF0000" size="4"><b>ERROR:</b>  The value of Amount Off needs to be numeric.  Do not include
            the dollar sign or percent sign.  All percentage MUST be in decimal format!</font><br>
            <cfset waserror = 1>
        </cfif>
    
        <cfif NOT #form.AmountOff# CONTAINS '.' AND #form.DiscountType# IS 'Percent Off'>
            <font color="FF0000" size="4"><b>ERROR:</b>  Percentage must be in decimal format!</font><br>
            <cfset waserror = 1>
        </cfif>
    
        <cfif #form.AmountOff# GT '.99' AND #form.DiscountType# IS 'Percent Off'>
            <font color="FF0000" size="4"><b>ERROR:</b>  Percentage can't be greater than 99%</font><br>
            <cfset waserror = 1>
        </cfif>
        
        <cfif #form.AmountOff# LT '.01' AND #form.DiscountType# IS 'Percent Off'>
            <font color="FF0000" size="4"><b>ERROR:</b>  Percentage can't be less than 1%</font><br>
            <cfset waserror = 1>
        </cfif>
    
        <cfif waserror IS '0'>
        
            <CFIF discounts is "Add">
                <cfquery name="AddDiscount" datasource="#request.dsn#">
                INSERT INTO discounts
                (ItemID, MinQ, AmountOff, DiscountType, level)
                VALUES
                ('#form.ItemID#', #form.MinQ#, '#form.AmountOff#', '#form.DiscountType#', '#form.level#')
                </cfquery>
                <cflocation url = "doproducts.cfm?Action=discounts">
            </cfif>
        
            <CFIF discounts is "Update">
            <!---Updates a Discount--->
                <cfquery name="UpdateDiscount" Datasource="#request.dsn#">
                UPDATE discounts
                SET MinQ = #form.MinQ#,
                AmountOff = '#form.AmountOff#',
                DiscountType= '#form.DiscountType#',
                level = '#form.level#'
                WHERE DiscountID = #form.DiscountID#
                </cfquery>
                <cflocation url = "doproducts.cfm?action=discounts">
            </cfif>
        </cfif>
	</cfif>
</cfif>

<div>
<cfif NOT ISDEFINED('form.discounts')>
    <form method="POST" action="doproducts.cfm?action=discounts" name="form1">
          <table border="0" cellspacing="0" style="border-collapse: collapse" bordercolor="#111111" width="50%" id="AutoNumber1">
            <tr>
              <td width="10%" style="border-style: solid; border-width: 1; padding-left: 4; padding-right: 4" bordercolor="#000000" bgcolor="#000080"><strong><font color="#FFFFFF">Price Level</font></strong></td> 
              <td width="24%" style="border-style: solid; border-width: 1; padding-left: 4; padding-right: 4" bordercolor="#000000" bgcolor="#000080"> 
                <font color="#FFFFFF"><b>Discount Type</b></font></td>
              <td width="18%" align="center" style="border-style: solid; border-width: 1; padding-left: 4; padding-right: 4" bordercolor="#000000" bgcolor="#000080"> 
                <font color="#FFFFFF"><b>Amount*</b></font></td>
              <td width="37%" align="center" style="border-style: solid; border-width: 1; padding-left: 4; padding-right: 4" bordercolor="#000000" bgcolor="#000080"> 
                <font color="#FFFFFF"><b>Minimum Quantity<br>
                To get discount</b></font></td>
            </tr>
            <tr>
              <td width="24%" style="border-style: solid; border-width: 1; padding-left: 4; padding-right: 4" bordercolor="#000000" bgcolor="#0066FF"><select name="level" id="level">
              <option value="0">0</option>
			  <cfoutput query="qLevels">
              	<option value="#level#">#level#</option>
              </cfoutput>
              </select>
              </td> 
              <td width="24%" style="border-style: solid; border-width: 1; padding-left: 4; padding-right: 4" bordercolor="#000000" bgcolor="#0066FF">
                  <select size="1" name="DiscountType">
                  <option>Amount Off</option>
                  <option>Percent Off</option>
                  </select></td>
              <td width="18%" style="border-style: solid; border-width: 1; padding-left: 4; padding-right: 4" bordercolor="#000000" bgcolor="#0066FF"> 
                <p align="center"> 
                  <cfoutput>
              <input type="text" name="AmountOff" size="16" Value="#AmountOff#"></cfoutput>              </td>
              <td width="37%" style="border-style: solid; border-width: 1; padding-left: 4; padding-right: 4" bordercolor="#000000" bgcolor="#0066FF"> 
                <p align="center"><font color="#FFFFFF"> 
                <cfoutput><input type="text" name="MinQ" size="8" Value="#MinQ#"></cfoutput></font></td>
            </tr>
          </table>
    </div>
        <input type="Hidden" Name="discounts" Value="Add">
        <cfoutput><input type = "hidden" value="#TempVar.EditID#" Name="ItemID"></cfoutput>
        <input type="submit" value="Add Discount" name="UpdateRoom" style="float: left">
          <p>&nbsp;</p>
          <p>* If percentage off, value MUST be in decimal format!</div> </p>
      </form>
    <p></p>
      <div align="left"> 
      <cfif NOT qrydiscounts.recordcount IS 0>
          <table border="1" cellpadding="2" cellspacing="0" width="50%" bordercolorlight="#808080" bordercolordark="#808080" bordercolor="#0066FF" style="border-collapse: collapse">
            <tr>
              <td width="10%" bgcolor="#000080"><strong><font color="#FFFFFF">Price Level</font></strong></td> 
              <td width="27%" bgcolor="#000080"> <font color="#FFFFFF"><b>Discount 
              Type</b></font></td>
              <td width="14%" bgcolor="#000080" align="center"> 
              <font color="#FFFFFF"><b>Amount</b></font></td>
              <td width="14%" bgcolor="#000080" align="center"> 
              <font color="#FFFFFF"><b>Min Qty</b></font></td>
              <td width="10%" bgcolor="#000080" align="center"> <b> <font color="#FFFFFF">Delete</font></b></td>
            </tr>
            <cfoutput query = "qrydiscounts"> 
              <tr>
                <td width="27%">#level#</td> 
                <td width="27%"> 
                  <a href="doproducts.cfm?action=discounts&discounts=Edit&DiscountID=#DiscountID#&ItemID=#TempVar.EditID#">
                  #DiscountType#</a></td>
                <td width="14%" align="center">#AmountOff#</td>
                <td width="14%" align="center">#MinQ#</td>
                <td width="10%" align="center">
                <a href="doproducts.cfm?action=deletediscount&DiscountID=#DiscountID#&itemid=#TempVar.EditID#">Delete</a></td>
              </tr>
            </cfoutput> 
          </table>
       </cfif>
      </div>
      <cfif qrydiscounts.recordcount IS 0>
      <b>You do not have any discounts configured for this product.  Use the form above to add a discount for this
      product.</b>
	  </cfif>
</cfif>

  
<cfif ISDEFINED('url.discounts')>
    <cfinclude template = "../queries/qrydiscounts.cfm">
    
    <div align="left">
    <form Method=Post Action="doproducts.cfm?action=discounts">
          <table border="0" cellspacing="0" style="border-collapse: collapse" bordercolor="#111111" width="50%" id="AutoNumber1">
            <tr>
              <td width="10%" style="border-style: solid; border-width: 1; padding-left: 4; padding-right: 4" bordercolor="#000000" bgcolor="#000080"><strong><font color="#FFFFFF">Price Level</font></strong></td> 
              <td width="24%" style="border-style: solid; border-width: 1; padding-left: 4; padding-right: 4" bordercolor="#000000" bgcolor="#000080"> 
                <font color="#FFFFFF"><b>Discount Type</b></font></td>
              <td width="18%" align="center" style="border-style: solid; border-width: 1; padding-left: 4; padding-right: 4" bordercolor="#000000" bgcolor="#000080"> 
                <font color="#FFFFFF"><b>Amount*</b></font></td>
              <td width="37%" align="center" style="border-style: solid; border-width: 1; padding-left: 4; padding-right: 4" bordercolor="#000000" bgcolor="#000080"> 
                <font color="#FFFFFF"><b>Minimum Qty</b></font></td>
            </tr>
    <cfoutput query = "qrydiscounts">
            <tr>
              <td width="24%" style="border-style: solid; border-width: 1; padding-left: 4; padding-right: 4" bordercolor="##000000" bgcolor="##0066FF"><select name="level" id="level">
              <option value="0">0</option>
			  <cfloop query="qLevels">
              	<option value="#qLevels.level#" <cfif qrydiscounts.level IS qLevels.level>selected="selected"</cfif>>#qLevels.level#</option>
              </cfloop>
              </select></td> 
              <td width="24%" style="border-style: solid; border-width: 1; padding-left: 4; padding-right: 4" bordercolor="##000000" bgcolor="##0066FF">
                  <select size="1" name="DiscountType">
                  <option <cfif DiscountType IS 'Amount Off'>SELECTED</cfif>>Amount Off</option>
                  <option <cfif DiscountType IS 'Percent Off'>SELECTED</cfif>>Percent Off</option>
                  </select></td>
              <td width="18%" style="border-style: solid; border-width: 1; padding-left: 4; padding-right: 4" bordercolor="##000000" bgcolor="##0066FF"> 
                <p align="center"> 
                  <input type="text" name="AmountOff" size="16" Value="#AmountOff#">
              </td>
              <td width="37%" style="border-style: solid; border-width: 1; padding-left: 4; padding-right: 4" bordercolor="##000000" bgcolor="##0066FF"> 
                <p align="center"><font color="##FFFFFF"> 
                <input type="text" name="MinQ" size="8" Value = "#MinQ#"> </font></td>
            </tr>
    </cfoutput>
          </table>
      </center>
      <div align="center"> 
        <input type="hidden" value="Update" Name="discounts">
        <cfoutput query = "qrydiscounts">
        <input type="hidden" Value="#DiscountID#" Name="DiscountID">
        </cfoutput>
        <cfif qryDiscounts.recordcount GT 0><input type="submit" value="Update Discount" name="UpdateDiscount" style="float: left"></cfif><p>
        </p>
       </div>
        </form>
    </div>
        <p>&nbsp;<p>  
    
    <cfif NOT ISDEFINED('url.DiscountID')>
          <table border="1" cellpadding="2" cellspacing="0" width="50%" bordercolorlight="#808080" bordercolordark="#808080" bordercolor="#0066FF" style="border-collapse: collapse">
            <tr> 
              <td width="27%" bgcolor="#000080"> <font color="#FFFFFF"><b>Discount 
              Type</b></font></td>
              <td width="14%" bgcolor="#000080" align="center"> 
              <font color="#FFFFFF"><b>Amount</b></font></td>
              <td width="14%" bgcolor="#000080" align="center"> 
              <font color="#FFFFFF"><b>Min Qty</b></font></td>
              <td width="10%" bgcolor="#000080" align="center"> <b> <font color="#FFFFFF">Delete</font></b></td>
            </tr>
            <cfoutput query = "qrydiscounts"> 
              <tr> 
                <td width="27%"> 
                  <a href="doproducts.cfm?action=discounts&discounts=Edit&DiscountID=#DiscountID#&ItemID=#TempVar.EditID#">
                  #DiscountType#</a></td>
                <td width="14%" align="center">#AmountOff#</td>
                <td width="14%" align="center">#MinQ#</td>
                <td width="10%" align="center">
                <a href="doproducts.cfm?action=deletediscount&DiscountID=#DiscountID#&itemid=#TempVar.EditID#">Delete</a></td>
              </tr>
            </cfoutput> 
          </table>
    </cfif>
    </cfif>
    </div>
    <cfif NOT ISDEFINED('url.DiscountID')>
    <cfif NOT qrydiscounts.recordcount IS 0>
    <form method="post" action="doproducts.cfm">
        <input type="checkbox" name="MakeSame" value="ON">
        Make all in 
        <select size="1" name="SameCategory">
          <cfloop query = "qryItemCategories">
           
            <cfquery name = "qryCategory" dbtype="query">
            SELECT * FROM qryCategories
            WHERE categoryid = #qryItemCategories.categoryid#
            </cfquery>
			
			<cfoutput query="qryCategory">		
              <option Value = "#CategoryID#" SELECTED>#CategoryName#</option>
            </cfoutput> 
          </cfloop>
        </select>
        the same as this one</strong>
      <cfoutput> 
        <input type = "hidden" Name="ItemID" Value = "#TempVar.EditID#">
      </cfoutput><input type="hidden" name="action" value="SetSamediscounts"><input type="submit" name="Submit" value="Set Same">
     </form>
    </cfif>
    </cfif>
    <cfif NOT ISDEFINED('url.DiscountID')>
    <p>
    <cfoutput query = "qryFindProduct"><b><a href="doproducts.cfm?Start=1">Click here when finished</a></b></cfoutput></p>
</cfif>
</div>















