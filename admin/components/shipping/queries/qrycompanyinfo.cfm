<cfquery name = "qryCompanyInfo" datasource="#request.dsn#">
SELECT *
FROM companyinfo,settings_main,settings_mail,settings_processor 
</cfquery>















