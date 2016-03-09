<cfinclude template = "../queries/qrycompanyinfo.cfm"> 
<strong>Payment Gateway Setup <cfoutput><a href = "#request.AdminPath#helpdocs/payment_gateway_setup.cfm" onclick="NewWindow(this.href,'Help','375','450','yes');return false;")><b><img src = "#request.AdminPath#images/help.gif" border="0" /></b></a></cfoutput>
</strong><cfoutput query="qryCompanyInfo"> 
  <p>Choose the gateway that you will use to process credit cards.<br>
  </p>
  <form name="form1" method="post" action="dosetup.cfm">
    <p align="left"><strong>Select How You Will Process Your Payments</strong></p>
    <p align="left"><strong> 
      <input name="PaymentProcessor" type="radio" value="None" checked>
      </strong> <b>None</b>. (Choose this if you manually process cards offline).</p>
    <p> 
      <input type="radio" name="PaymentProcessor" value="AuthorizeNet" <cfif PaymentGateway IS 'Authorizenet'>CHECKED</cfif>>
      <b>Authorize Net/SecureSource </b>(<a href="http://www.authorize.net" target="_blank">Click 
      here</a> to find out more about Authorize.net)</p>
    <p> 
      <input type="radio" name="PaymentProcessor" value="2Checkout" <cfif PaymentGateway IS '2checkout'>CHECKED</cfif>>
      <b> 2Checkout</b>. (<a href="http://www.2checkout.com/cgi-bin/aff.2c?affid=54998" target="_blank">Click 
      here</a> to find out more about 2checkout)</p>
    <p> 
      <input type="radio" name="PaymentProcessor" value="LinkPoint" <cfif PaymentGateway IS 'LinkPoint'>CHECKED</cfif>>
      <b> LinkPoint Connect</b> (<a href="http://www.linkpoint.com" target="_blank">Click 
      here</a> to find out more about LinkPoint)</p>
    <p>
      <input type="radio" name="PaymentProcessor" value="YourPay" <cfif PaymentGateway IS 'YourPay'>CHECKED</cfif>>
      <b> YourPay Connect</b> (<a href="http://www.yourpay.com" target="_blank">Click 
      here</a> to find out more about YourPay)</p>
    <p> 
      <input type="radio" name="PaymentProcessor" value="PayPal" <cfif PaymentGateway IS 'PayPal'>CHECKED</cfif>>
      <b>PayPal IPN or PDT </b>(<a href="https://www.paypal.com/us/mrb/pal=JJ3DHX4NQADWL" target="_blank">Click 
      here</a> to find out more about PayPal)</p>
    <p> 
      <input type="radio" name="PaymentProcessor" value="skipjack" <cfif PaymentGateway IS 'skipjack'>CHECKED</cfif>>
      <b>SkipJack </b>(<a href="http://www.skipjack.com" target="_blank">Click here</a> 
      to find out more about SkipJack)</p>
    <p> 
      <input type="radio" name="PaymentProcessor" value="PayflowLink" <cfif PaymentGateway IS 'PayflowLink'>CHECKED</cfif>>
      <b>Payflow Link </b>(<a href="http://www.verisign.com/products-services/payment-processing/online-payment/payflow-link/" target="_blank">Click 
      here</a> to find out more about Payflow Link)</p>
    <p>
      <input type="radio" name="PaymentProcessor" value="PayflowPro" <cfif PaymentGateway IS 'PayflowPro'>CHECKED</cfif> />
      <b>Payflow Pro </b>(<a href="http://www.verisign.com/products-services/payment-processing/online-payment/payflow-link/" target="_blank">Click 
    here</a> to find out more about Payflow Pro)</p>
    <p>
      <input type="radio" name="PaymentProcessor" value="PsiGate" <cfif PaymentGateway IS 'PsiGate'>CHECKED</cfif>>
      <b>PsiGate</b> (<a href="http://www.psigate.com" target="_blank">Click here</a> 
      to find out more about PsiGate)</p>
    <p>
      <input type="radio" name="PaymentProcessor" value="PayPalPaymentsPro" <cfif PaymentGateway IS 'PayPalPaymentsPro'>CHECKED</cfif>>
      <b>PayPal Payments Pro</b> (<a href="https://www.paypal.com/us/mrb/pal=JJ3DHX4NQADWL" target="_blank">Click here</a> 
      to find out more about PayPal Payments Pro)</p>
    <p>
      <input type="radio" name="PaymentProcessor" value="Optimal" <cfif PaymentGateway IS 'Optimal'>CHECKED</cfif> />
      <b>Optimal Payments</b></p>
    <p>
      <input type="radio" name="PaymentProcessor" value="Moneris" <cfif PaymentGateway IS 'Moneris'>CHECKED</cfif> />
      <b>Moneris</b></p>      
    <p align="center"> 
      <input type="hidden" name="action" value="UpdateCC">
      <input type="submit" name="Submit" value="Continue...">
    </p>
  </form>
</cfoutput> 







