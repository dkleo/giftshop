<cfif form.adjust_items IS 'shown'>
	<!---only change the items in the current view--->
    <cfinclude template = "../queries/qrycatalog.cfm">
</cfif>

<!---update all items--->
<cfif form.adjust_items IS 'AllCatalog'>
	<cfquery name = "qryCatalog" datasource="#request.dsn#">
    SELECT * FROM products
  	</cfquery>   
</cfif>

<cfif qryCatalog.recordcount GT 0>    
    <cfloop query = "qryCatalog">
        <cfset newprice = qryCatalog.price>
        <!---if by amount then just add/subtract the amount from the price of this item.--->
        <cfif form.adjust_type IS 'Amount'>
            <cfif form.adjust_op IS 'Add'>
                <cfset newprice = newprice + form.adjust_amount>
            </cfif>
            <cfif form.adjust_op IS 'Subtract'>
                <cfset newprice = newprice - form.adjust_amount>
            </cfif>
        </cfif>
        <cfif form.adjust_type IS 'percent'>
                <!---if the amount field doesn't have a decimal point in it then convert it to decimal format--->
                <cfif NOT form.adjust_amount CONTAINS '.'>
                    <cfset theamount = form.adjust_amount / 100>
                <cfelse>
                    <cfset theamount = form.adjust_amount>
                </cfif>
                
                <!---get percentage of current price and set a variable for what to add/subtract from the price.--->
                <cfset adjustby = newprice * theamount>
    
                <!---add subtract depending on what they chose--->
                <cfif form.adjust_op IS 'Add'>
                    <cfset newprice = newprice + adjustby>
                </cfif>
                <cfif form.adjust_op IS 'Subtract'>
                    <cfset newprice = newprice - adjustby>
                </cfif>            
          </cfif>
          <!---if the new price falls below .01, then set the new price to the current price (do not adjust it)--->
          <cfif newprice LT 0.01>
             <cfset newprice = qryCatalog.price>
          </cfif> 
          
          <!---update database with new price--->
          <cfquery name = "qryUpdatePrice" datasource="#request.dsn#">
          UPDATE products
          SET price = #newprice#
          WHERE itemid = #qryCatalog.itemid#
          </cfquery>            
    </cfloop>
</cfif>

<cflocation url="doproducts.cfm?action=pricing&wasupdate=true">
















