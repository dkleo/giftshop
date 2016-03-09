<cfif NOT #ListLen('form.ProductID')# IS 0>
<cfloop Index = "MyCount" From="1" To="#ListLen(form.ProductID)#">
	<cfset ThisItem = #ListGetAT(form.ProductID, MyCount)#>
    <cfset thisformname = "form.price_" & #ThisItem#>
    <cfset NewPrice = Evaluate(thisformname)>
         
    <cfif len(trim(NewPrice)) LT 0.00>
        <cfset NewPrice = 0.00>
    </cfif>
    <cfif NOT isnumeric(NewPrice)>
    	<cfset NewPrice = 0.00>
    </cfif>
    <cfif NewPrice LT 0.00>
        <cfset NewPrice = 0.00>
    </cfif>
       
    <cfquery name = "UpdateStock" datasource="#request.dsn#">
    UPDATE products
    SET price = #NewPrice#
    WHERE ItemID = #ThisItem#
    </cfquery>
</cfloop>
</cfif>

<cflocation url="doproducts.cfm?action=pricing&wasupdate=true">















