<cfparam name = "start" default="1">
<cfparam name = "disp" default="15">
<cfparam name = "end" default="999">
<cfparam name = "viewtype" default="All">
<cfparam name = "searchquery" default="">
<cfparam name = "sortoption" default="Featured">

<cfif NOT #ListLen('form.ProductID')# IS 0>
<cfloop Index = "MyCount" From="1" To="#ListLen(form.ProductID)#">
	<cfset ThisItem = #ListGetAT(form.ProductID, MyCount)#>
    <cfset thisformname = "form.UnitsInStock" & #ThisItem#>
    <cfset NewStockVal = Evaluate(thisformname)>
    <cfset thisformname2 = "form.UnitsSold" & #ThisItem#>
    <cfset NewUnitsSoldVal = Evaluate(thisformname2)>
         
    <cfif len(trim(NewStockVal)) LT 1>
        <cfset NewStockVal = 0>
    </cfif>
    <cfif NOT isnumeric(NewStockVal)>
    	<cfset NewStockVal = 0>
    </cfif>
    <cfif NewStockVal LT 0>
        <cfset NewStockVal = 0>
    </cfif>
  
    <cfquery name = "UpdateStock" datasource="#request.dsn#">
    UPDATE products
    SET UnitsInStock = #NewStockVal#,
    UnitsSold = #NewUnitsSoldVal#
    WHERE ItemID = #ThisItem#
    </cfquery>
</cfloop>
</cfif>

<cflocation url="doinventory.cfm?start=#start#&disp=#disp#&viewtype=#viewtype#&sortoption=#sortoption#&searchquery=#searchquery#">