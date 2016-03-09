
<cfif #form.SurCharge# is '' OR #form.SurCharge# IS '.00'>
<font face="Verdana, Arial, Helvetica, sans-serif" size="2">
ERROR:  You have to supply an amount for this area.  You cannot set the tax rate to null or 
zero.  Please specify an amount in decimal format (i.e. 7% = .07) 
<a href="javascript:history.go(-1);">Click here</a> to go back.</font>
<cfabort>
</cfif>

<cfif #form.SurCharge# CONTAINS '%'>
<font face="Verdana, Arial, Helvetica, sans-serif" size="2">
ERROR:  You have to supply an amount in decimal format(i.e. 7% = .07) 
<a href="javascript:history.go(-1);">Click here</a> to go back.</font>
<cfabort>
</cfif>

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
INSERT INTO shippingsurcharges
(Region, Country, SurCharge)
VALUES
('#form.Region#', '#form.Country#', '#form.SurCharge#')
</cfquery>
</cfif>

<cfif #form.Region# IS 'Other'>
<cfquery name = "AddTax" datasource = "#request.dsn#">
INSERT INTO shippingsurcharges
(Region, Country, SurCharge)
VALUES
('#form.OtherRegion#', '#form.Country#', '#form.TaxRate#')
</cfquery>
</cfif>

<cflocation URL = "doshipping.cfm?action=surcharge">
