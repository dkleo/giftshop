<cfif #form.Region# IS 'Select Region'>
<font face="Verdana, Arial, Helvetica, sans-serif" size="2">
ERROR:  You did not specify a region! <a href="javascript:history.go(-1);">Click here</a> to go back.</font>
<cfabort>
</cfif>

<cfif #form.Country# IS ''>
<font face="Verdana, Arial, Helvetica, sans-serif" size="2">
ERROR:  You did not specify a country! <a href="javascript:history.go(-1);">Click here</a> to go back.</font>
<cfabort>
</cfif>

<cfif #form.Country# IS 'Select Country'>
<font face="Verdana, Arial, Helvetica, sans-serif" size="2">
ERROR:  You need to specify a State for this country! <a href="javascript:history.go(-1);">Click here</a> to go back.</font>
<cfabort>
</cfif>

<cfif NOT #form.Region# IS 'Other'>
<cfquery name = "AddSurcharge" datasource = "#request.dsn#">
INSERT INTO shippingfreezones
(Region, Country, ZipCode, City)
VALUES
('#form.Region#', '#form.Country#', '#form.ZipCode#', '#form.City#')
</cfquery>
</cfif>

<cfif #form.Region# IS 'Other'>
<cfquery name = "AddTax" datasource = "#request.dsn#">
INSERT INTO shippingsurcharges
(Region, Country, ZipCode, City)
VALUES
('#form.OtherRegion#', '#form.Country#', '#form.ZipCode#', '#form.City#')
</cfquery>
</cfif>

<cflocation URL = "doshipping.cfm?action=freezones">
