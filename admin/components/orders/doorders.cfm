<cftry>
<link rel="stylesheet" type="text/css" href="../../controlpanel.css"> 
<table width="100%" border="0" cellspacing="0" cellpadding="0" align="center">
  
  <tr> 
    <td> <cfif NOT ISDEFINED ('url.action') AND NOT ISDEFINED ('form.action')>
        <cfinclude template = "forms/frmorders.cfm">
      </cfif> <cfif ISDEFINED('url.action')>
        <cfif url.action IS 'ViewUnpaid'>
          <cfinclude template='forms/frmUnPaidOrders.cfm'>
        </cfif>
        <cfif url.action IS 'ViewOrders'>
          <cfinclude template='forms/frmorders.cfm'>
        </cfif>
        <cfif url.action IS 'ViewArchives'>
          <cfinclude template='forms/frmarchives.cfm'>
        </cfif>
        <cfif url.action IS 'ViewCustomers'>
          <cfinclude template='forms/frmcustomers.cfm'>
        </cfif>
        <cfif url.action IS 'ViewOrder'>
          <cfinclude template='actions/actvieworder.cfm'>
        </cfif>
        <cfif url.action IS 'EditCustomer'>
          <cfinclude template='forms/frmeditcustomer.cfm'>
        </cfif>
        <cfif url.action IS 'Delete'>
          <cfinclude template='forms/frmdeleteorders.cfm'>
        </cfif>
        <cfif url.action IS 'DeleteCustomer'>
          <cfinclude template='actions/actdeletecustomer.cfm'>
        </cfif>
        <cfif url.action IS 'ViewSales'>
          <cfinclude template='actions/dspsalesreport.cfm'>
        </cfif>
        <cfif url.action is 'Exit'>
          <cflocation URL = '#request.AdminPath#'>
        </cfif>
        <cfif url.action IS 'AddCustomer'>
          <cfinclude template = 'forms/frmAddCustomer.cfm'>
        </cfif>
        <cfif url.action IS 'Download'>
          <cfinclude template = 'forms/frmDownload.cfm'>
        </cfif>
        <cfif url.action IS 'SearchOrders'>
          <cfinclude template = 'forms/frmsearch.cfm'>
        </cfif>
		<cfif url.action IS 'BadOrder'>
			<cfinclude template = 'actions/actdeletebadorder.cfm'>
		</cfif>
		<cfif url.action IS 'NewOrder'>
			<cfinclude template = 'forms/frmSelectproducts.cfm'>
		</cfif>
		<cfif url.action IS 'remove_cardinfo'>
        	<cfinclude template = 'actions/actclearpaymentinfo.cfm'>
        </cfif>
		<cfif url.action IS 'PrintFedexLabel'>
			<cfinclude template = 'actions/actshipfedex.cfm'>
		</cfif>
      </cfif>
	   
	  <cfif ISDEFINED('form.action')>
        <cfif form.action IS 'ViewSales'>
          <cfinclude template='actions/dspSalesReport.cfm'>
        </cfif>
        <cfif form.action IS 'Delete'>
          <cfinclude template='actions/actdeleteorders.cfm'>
        </cfif>
        <cfif form.action IS 'Update'>
          <cfinclude template='actions/actupdateorders.cfm'>
        </cfif>
        <cfif form.action IS 'Update Orders'>
          <cfinclude template='actions/actupdateorders.cfm'>
        </cfif>
        <cfif form.action IS 'Archive Selected'>
          <cfinclude template='actions/actarchiveorders.cfm'>
        </cfif>
        <cfif form.action IS 'ViewArchives'>
          <cfinclude template='forms/frmArchives.cfm'>
        </cfif>
        <cfif form.action IS 'UpdateOrder'>
          <cfinclude template='actions/actupdateorder.cfm'>
        </cfif>
        <cfif form.action IS 'UpdateCustomer'>
          <cfinclude template='actions/actupdatecustomer.cfm'>
        </cfif>
        <cfif form.action IS 'AddCustomer'>
          <cfinclude template='actions/actaddcustomer.cfm'>
        </cfif>
        <cfif form.action IS 'CreateFile'>
          <cfinclude template='actions/actDownload.cfm'>
        </cfif>
        <cfif form.action IS 'SearchOrders'>
          <cfinclude template='actions/dspsearchresults.cfm'>
        </cfif>
        <cfif form.action IS 'SearchCustomers'>
          <cfinclude template='actions/dspSearchCustomers.cfm'>
        </cfif>
        <cfif form.action IS 'RemoveBlankAccounts'>
          <cfinclude template='actions/actremoveblankaccounts.cfm'>
        </cfif>
        <cfif form.action IS 'UpdateArchives'>
          <cfinclude template='actions/actupdatearchives.cfm'>
        </cfif>
      </cfif> </td>
  </tr>
</table>


<cfcatch type = "any">
	<cfinclude template = "../../errorprocess.cfm">
    <cfabort>
</cfcatch>

</cftry>










