<cfquery name = "AddSale" datasource="#request.dsn#">
INSERT INTO sales
(StartDate, EndDate, SaleType, AmountOff, CategoryID, ProductID, level)
VALUES
('#dateformat(form.startdate, "yyyy-mm-dd")#', '#dateformat(form.EndDate, "yyyy-mm-dd")#', '#form.SaleType#', '#form.AmountOff#', '#form.CategoryID#', '#form.ProductID#', #form.level#)
</cfquery>

<cflocation url = "dosales.cfm">


















