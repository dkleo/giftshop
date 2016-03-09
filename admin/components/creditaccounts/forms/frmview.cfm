<form action="index.cfm?action=process" method="post">
  <h2>Application Needing Approval</h2>
  <table width="84%" border="0" cellspacing="0" cellpadding="4">
    <tr align="center" bgcolor="lightgrey">
      <td colspan="6" nowrap="nowrap"><div align="center"><font size="2"><b><font face="Arial, Helvetica, sans-serif">Company Credit Application </font></b></font></div></td>
    </tr>
    <tr bgcolor="white">
      <td width="14%" nowrap="nowrap"><font size="2" face="Arial, Helvetica, sans-serif">Business Name</font></td>
      <td width="19%"><font size="2" face="Arial, Helvetica, sans-serif">
        <label>
          <input name="businessname" type="text" value="#biz_name#" />
        </label>
      </font></td>
      <td width="9%"><font size="2" face="Arial, Helvetica, sans-serif">&nbsp;</font></td>
      <td width="20%"><font size="2" face="Arial, Helvetica, sans-serif">&nbsp;</font></td>
      <td width="10%"><font size="2" face="Arial, Helvetica, sans-serif">&nbsp;</font></td>
      <td width="28%"><font size="2" face="Arial, Helvetica, sans-serif">&nbsp;</font></td>
    </tr>
    <tr bgcolor="lightgrey">
      <td nowrap="nowrap"><font size="2" face="Arial, Helvetica, sans-serif">Address</font></td>
      <td><font size="2" face="Arial, Helvetica, sans-serif">
        <input name="address" type="text" value="#address#" />
      </font></td>
      <td><font size="2" face="Arial, Helvetica, sans-serif">&nbsp;</font></td>
      <td><font size="2" face="Arial, Helvetica, sans-serif">&nbsp;</font></td>
      <td><font size="2" face="Arial, Helvetica, sans-serif">&nbsp;</font></td>
      <td><font size="2" face="Arial, Helvetica, sans-serif">&nbsp;</font></td>
    </tr>
    <tr bgcolor="white">
      <td nowrap="nowrap"><font size="2" face="Arial, Helvetica, sans-serif">Address 2 </font></td>
      <td><font size="2" face="Arial, Helvetica, sans-serif">
        <input name="address2" type="text" value="#address#" />
      </font></td>
      <td><font size="2" face="Arial, Helvetica, sans-serif">&nbsp;</font></td>
      <td><font size="2" face="Arial, Helvetica, sans-serif">&nbsp;</font></td>
      <td><font size="2" face="Arial, Helvetica, sans-serif">&nbsp;</font></td>
      <td><font size="2" face="Arial, Helvetica, sans-serif">&nbsp;</font></td>
    </tr>
    <tr bgcolor="lightgrey">
      <td nowrap="nowrap"><font size="2" face="Arial, Helvetica, sans-serif">City</font></td>
      <td><font size="2" face="Arial, Helvetica, sans-serif">
        <input name="city" type="text" value="#city#" />
      </font></td>
      <td><font size="2" face="Arial, Helvetica, sans-serif">State</font></td>
      <td><font size="2" face="Arial, Helvetica, sans-serif">
        <input name="state" type="text" value="#state#" size="14" />
      </font></td>
      <td><font size="2" face="Arial, Helvetica, sans-serif">Zip</font></td>
      <td><font size="2" face="Arial, Helvetica, sans-serif">
        <input name="zip" type="text" value="#zip#" size="10" />
      </font></td>
    </tr>
    <tr bgcolor="white">
      <td nowrap="nowrap"><font size="2" face="Arial, Helvetica, sans-serif">&nbsp;</font></td>
      <td><font size="2" face="Arial, Helvetica, sans-serif">&nbsp;</font></td>
      <td><font size="2" face="Arial, Helvetica, sans-serif">&nbsp;</font></td>
      <td><font size="2" face="Arial, Helvetica, sans-serif">&nbsp;</font></td>
      <td><font size="2" face="Arial, Helvetica, sans-serif">&nbsp;</font></td>
      <td><font size="2" face="Arial, Helvetica, sans-serif">&nbsp;</font></td>
    </tr>
    <tr bgcolor="lightgrey">
      <td nowrap="nowrap"><font size="2" face="Arial, Helvetica, sans-serif">&nbsp;</font></td>
      <td><font size="2" face="Arial, Helvetica, sans-serif">&nbsp;</font></td>
      <td><font size="2" face="Arial, Helvetica, sans-serif">&nbsp;</font></td>
      <td><font size="2" face="Arial, Helvetica, sans-serif">&nbsp;</font></td>
      <td><font size="2" face="Arial, Helvetica, sans-serif">&nbsp;</font></td>
      <td><font size="2" face="Arial, Helvetica, sans-serif">&nbsp;</font></td>
    </tr>
    <tr bgcolor="white">
      <td nowrap="nowrap"><font size="2" face="Arial, Helvetica, sans-serif">Owner/Manager</font></td>
      <td><font size="2" face="Arial, Helvetica, sans-serif">
        <input name="owner" type="text" value="#owner#" />
      </font></td>
      <td><font size="2" face="Arial, Helvetica, sans-serif">&nbsp;</font></td>
      <td><font size="2" face="Arial, Helvetica, sans-serif">&nbsp;</font></td>
      <td><font size="2" face="Arial, Helvetica, sans-serif">&nbsp;</font></td>
      <td><font size="2" face="Arial, Helvetica, sans-serif">&nbsp;</font></td>
    </tr>
    <tr bgcolor="lightgrey">
      <td nowrap="nowrap"><font size="2" face="Arial, Helvetica, sans-serif">Work Tel.No.</font></td>
      <td><font size="2" face="Arial, Helvetica, sans-serif">
        <input name="workphone" type="text" value="#work#" />
      </font></td>
      <td><font size="2" face="Arial, Helvetica, sans-serif">&nbsp;</font></td>
      <td><font size="2" face="Arial, Helvetica, sans-serif">&nbsp;</font></td>
      <td><font size="2" face="Arial, Helvetica, sans-serif">&nbsp;</font></td>
      <td><font size="2" face="Arial, Helvetica, sans-serif">&nbsp;</font></td>
    </tr>
    <tr bgcolor="white">
      <td nowrap="nowrap"><font size="2" face="Arial, Helvetica, sans-serif">Cell Phone </font></td>
      <td><font size="2" face="Arial, Helvetica, sans-serif">
        <input name="cellphone" type="text" value="#cell#" />
      </font></td>
      <td><font size="2" face="Arial, Helvetica, sans-serif">&nbsp;</font></td>
      <td><font size="2" face="Arial, Helvetica, sans-serif">&nbsp;</font></td>
      <td><font size="2" face="Arial, Helvetica, sans-serif">&nbsp;</font></td>
      <td><font size="2" face="Arial, Helvetica, sans-serif">&nbsp;</font></td>
    </tr>
    <tr bgcolor="lightgrey">
      <td nowrap="nowrap"><font size="2" face="Arial, Helvetica, sans-serif">How long in business</font></td>
      <td><font size="2" face="Arial, Helvetica, sans-serif">
        <input name="howlong" type="text" value="#howlong#" />
      </font></td>
      <td><font size="2" face="Arial, Helvetica, sans-serif">&nbsp;</font></td>
      <td><font size="2" face="Arial, Helvetica, sans-serif">&nbsp;</font></td>
      <td><font size="2" face="Arial, Helvetica, sans-serif">&nbsp;</font></td>
      <td><font size="2" face="Arial, Helvetica, sans-serif">&nbsp;</font></td>
    </tr>
    <tr bgcolor="white">
      <td nowrap="nowrap"><font size="2" face="Arial, Helvetica, sans-serif">D &amp; B Rate</font></td>
      <td><font size="2" face="Arial, Helvetica, sans-serif">
        <input name="bbrate" type="text" value="#dbrate#" />
      </font></td>
      <td><font size="2" face="Arial, Helvetica, sans-serif">&nbsp;</font></td>
      <td><font size="2" face="Arial, Helvetica, sans-serif">&nbsp;</font></td>
      <td><font size="2" face="Arial, Helvetica, sans-serif">&nbsp;</font></td>
      <td><font size="2" face="Arial, Helvetica, sans-serif">&nbsp;</font></td>
    </tr>
    <tr bgcolor="lightgrey">
      <td nowrap="nowrap"><font size="2" face="Arial, Helvetica, sans-serif">Trade References:</font></td>
      <td><font size="2" face="Arial, Helvetica, sans-serif">&nbsp;</font></td>
      <td><font size="2" face="Arial, Helvetica, sans-serif">&nbsp;</font></td>
      <td><font size="2" face="Arial, Helvetica, sans-serif">&nbsp;</font></td>
      <td><font size="2" face="Arial, Helvetica, sans-serif">&nbsp;</font></td>
      <td><font size="2" face="Arial, Helvetica, sans-serif">&nbsp;</font></td>
    </tr>
    <tr bgcolor="white">
      <td nowrap="nowrap"><font size="2" face="Arial, Helvetica, sans-serif">Name</font></td>
      <td><font size="2" face="Arial, Helvetica, sans-serif">
        <input name="traderef1" type="text" value="#trade_name1#" />
      </font></td>
      <td><font size="2" face="Arial, Helvetica, sans-serif">Telephone</font></td>
      <td><font size="2" face="Arial, Helvetica, sans-serif">
        <input name="tradephone1" type="text" value="#telphone1#" size="12" />
      </font></td>
      <td nowrap="nowrap"><font size="2" face="Arial, Helvetica, sans-serif">Account No.</font></td>
      <td><font size="2" face="Arial, Helvetica, sans-serif">
        <input name="tradeacct1" type="text" value="#account1#" size="14" />
      </font></td>
    </tr>
    <tr bgcolor="lightgrey">
      <td nowrap="nowrap"><font size="2" face="Arial, Helvetica, sans-serif">Name</font></td>
      <td><font size="2" face="Arial, Helvetica, sans-serif">
        <input name="traderef2" type="text" value="#trade_name2#" />
      </font></td>
      <td><font size="2" face="Arial, Helvetica, sans-serif">Telephone</font></td>
      <td><font size="2" face="Arial, Helvetica, sans-serif">
        <input name="tradephone2" type="text" value="#telephone2#" size="12" />
      </font></td>
      <td><font size="2" face="Arial, Helvetica, sans-serif">Account No.</font></td>
      <td><font size="2" face="Arial, Helvetica, sans-serif">
        <input name="tradeacct2" type="text" value="#account2#" size="14" />
      </font></td>
    </tr>
    <tr bgcolor="white">
      <td nowrap="nowrap"><font size="2" face="Arial, Helvetica, sans-serif">Name</font></td>
      <td><font size="2" face="Arial, Helvetica, sans-serif">
        <input name="traderef3" type="text" value="#trade_name3#" />
      </font></td>
      <td><font size="2" face="Arial, Helvetica, sans-serif">Telephone</font></td>
      <td><font size="2" face="Arial, Helvetica, sans-serif">
        <input name="tradephone3" type="text" value="#telephone#" size="12" />
      </font></td>
      <td><font size="2" face="Arial, Helvetica, sans-serif">Account No.</font></td>
      <td><font size="2" face="Arial, Helvetica, sans-serif">
        <input name="tradeacct3" type="text" value="#account3#" size="14" />
      </font></td>
    </tr>
    <tr bgcolor="lightgrey">
      <td nowrap="nowrap"><font size="2" face="Arial, Helvetica, sans-serif">Credit line requested $</font></td>
      <td><font size="2" face="Arial, Helvetica, sans-serif">
        <input name="creditline" type="text" value="#creditline#" size="20" />
      </font></td>
      <td><font size="2" face="Arial, Helvetica, sans-serif">Terms</font></td>
      <td><font size="2" face="Arial, Helvetica, sans-serif">
          <input type="text" size="30" value="#terms#" name="terms">
      </font></td>
      <td><font size="2" face="Arial, Helvetica, sans-serif">&nbsp;</font></td>
      <td><font size="2" face="Arial, Helvetica, sans-serif">&nbsp;</font></td>
    </tr>
  </table>
  <p><font size="2" face="Arial, Helvetica, sans-serif">The undersigned authorizes inquiry as to credit<br />
    information. We further acknowledge that credit privileges, if<br />
    granted, may be withdrawn at any time.<br />
    Please Print your Name:</font><br />
    <br />
    <input name="signature" type="text" id="signature" />
    <br />
    _______________________________</p>
  <p>
    <select name="select" id="select">
      <option <cfif approved IS 'Yes'>selected</cfif>>Approved</option>
      <option <cfif NOT approved IS 'Yes'>selected</cfif>>Rejected</option>
    </select>
  </p>
  <p>If approved, enter the information below:</p>
  <p>Account Number: 
    <input name="account_number" type="text" id="account_number" value="#account_number#">
  </p>
  <p>Credit Line: $
    <input type="text" name="creditline" id="creditline" value="#creditline#">
  </p>
  <p>If Rejected enter a reason:</p>
  <p>
    <textarea name="reason" id="reason" cols="55" rows="8">#reason#</textarea>
  </p>
  <p>
    <input type="submit" name="button" id="button" value="Submit" />
  </p>
</form>




















