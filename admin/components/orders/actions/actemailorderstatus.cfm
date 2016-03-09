<cfset messagebody = "This email is to inform you that the status of the order you placed with #request.companyname# as been updated.  
You may view the details of your order by visiting #request.HomeURL#/index.cfm?action=myaccount">

<cfif request.UseMailServer IS 'Yes'>

	<cfif request.UseMailLogin IS 'Yes'>
        <cfmail server="#request.MailServer#"
        username="#request.mailuser#"
        Password="#request.mailpassword#"
        From="#request.EmailAddress#"
        TO="#ThisCustEmail#"
        SUBJECT="Your order number #ThisOrderNumber# was updated!"
        type="html">
        #messagebody#
        </cfmail>
      <cfelse>
        <cfmail server="#request.MailServer#"
        From="#request.EmailAddress#"
        TO="#ThisCustEmail#"
        SUBJECT="Your order number #ThisOrderNumber# was updated!"
        type="html">
        #messagebody#
        </cfmail>       
    </cfif>

<cfelse>

	<cfif request.UseMailLogin IS 'Yes'>
        <cfmail username="#request.mailuser#"
        Password="#request.mailpassword#"
        From="#request.EmailAddress#"
        TO="#ThisCustEmail#"
        SUBJECT="Your order number #ThisOrderNumber# was updated!"
        type="html">
        #messagebody#
        </cfmail>
      <cfelse>
        <cfmail From="#request.EmailAddress#"
        TO="#ThisCustEmail#"
        SUBJECT="Your order number #ThisOrderNumber# was updated!"
        type="html">
        #messagebody#
        </cfmail>       
    </cfif>

</cfif>



















