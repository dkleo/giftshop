<cfinclude template = "../queries/qryshoppingcarts.cfm">
<h2>Viewing Shopping Cart</h2>
<span style="font-weight: bold">Below are the details of the items that were in this shopping cart:</span>
<p>
<table width="90%" border="1" cellspacing="0" cellpadding="3" style="border-collapse: collapse" bordercolor="##111111">
          <tr class="TableTitles"> 
            <td width="50%" height="19" style="border-color:##000000; border-width:1; " > 
              <b>Name</b></td>
            <td width="25%" height="19" style="border-color:##000000; border-width:1; " ><p align="center"> 
                <b>Quantity</b></p></td>
            <td width="25%" height="19" align="center" style="border-color:##000000; border-width:1; " > 
              <b>Price</b></td>
          </tr>
<cfoutput query = "qryShoppingCarts">
          <cfloop index="IndexCount" from="1" To="#ListLen(CrtProductID, "^")#">
             <tr> 
                <td width="50%" style="border-color:##000000; border-width:1; " valign="middle">
					#ListGetAt(CrtProductName, IndexCount, "^")#</td>
                <td width="25%" style="border-color:##000000; border-width:1; " valign="middle"> 
                  <p align="center"> #ListGetAt(CrtQuantity, IndexCount, "^")#</p></td>
                <td width="25%" align="right" style="border-color:##000000; border-width:1; "> 
					<cfset TotalOfItems = #ListGetAt(CrtPrice, IndexCount, "^")#>
					<div align="center">
					<cfif request.EnableEuro IS 'Yes'>
                      #lseurocurrencyformat(TotalOfItems, "Local")# 
                      <cfelse>
                      #lscurrencyformat(TotalOfItems, "Local")#
                  </cfif></div></td>
            </tr>
          </cfloop>
</cfoutput>
</table>















