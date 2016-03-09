<cfquery name = "UpdateSale" datasource="#request.dsn#">
UPDATE sales
SET StartDate = '#dateformat(form.startdate, "yyyy-mm-dd")#',
EndDate = '#dateformat(form.enddate, "yyyy-mm-dd")#',
level = #form.level#
WHERE SaleID = #form.SaleID#
</cfquery>

<cflocation url = 'dosales.cfm'>















