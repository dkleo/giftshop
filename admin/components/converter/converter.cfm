<p><strong><font size="2" face="Verdana, Arial, Helvetica, sans-serif">Weight Measure Conversion</font></strong></p>
<cfform name="form1" method="post" action="converter.cfm">
  <p><font size="2" face="Verdana, Arial, Helvetica, sans-serif">Weight 
    <cfinput name="FromWeight" type="text" id="FromWeight" size="5" required="yes" Message="Please supply a weight">
    in 
    <select name="FromUnit" id="FromUnit">
      <option <cfif NOT ISDEFINED('form.fromUnit')>SELECTED</cfif><cfif ISDEFINED('form.FromUnit') AND form.FromUnit IS 'Ounces'>selected</cfif>>Ounces</option>
      <option <cfif ISDEFINED('form.FromUnit') AND form.FromUnit IS 'Pounds'>selected</cfif>>Pounds</option>
      <option <cfif ISDEFINED('form.FromUnit') AND form.FromUnit IS 'Grams'>selected</cfif>>Grams</option>
      <option <cfif ISDEFINED('form.FromUnit') AND form.FromUnit IS 'Kilograms'>selected</cfif>>Kilograms</option>
    </select>
    to: 
    <select name="ToUnit" id="ToUnit">
      <option <cfif ISDEFINED('form.ToUnit') AND form.ToUnit IS 'Ounces'>selected</cfif>>Ounces</option>
      <option <cfif NOT ISDEFINED('form.ToUnit')>SELECTED</cfif><cfif ISDEFINED('form.ToUnit') AND form.ToUnit IS 'Pounds'>selected</cfif>>Pounds</option>
      <option <cfif ISDEFINED('form.ToUnit') AND form.ToUnit IS 'Grams'>selected</cfif>>Grams</option>
      <option <cfif ISDEFINED('form.ToUnit') AND form.ToUnit IS 'Kilograms'>selected</cfif>>Kilograms</option>
    </select>
    </font></p>
  <p> <font size="2" face="Verdana, Arial, Helvetica, sans-serif">
    <input name="Submit" type="submit" id="Submit" value="Convert Weight">
    </font></p>
</cfform>
<font size="2" face="Verdana, Arial, Helvetica, sans-serif">
<cfif ISDEFINED('form.FromWeight')>

<cfif NOT form.FromWeight IS '0'>
<cfset FinalFigure = #form.FromWeight#>

<b>Results:</b> 
</cfif>
</font>
<font face="Verdana, Arial, Helvetica, sans-serif"><cfif ISDEFINED('form.FromWeight')>
  </cfif></font><cfif ISDEFINED('form.FromWeight')><p> <font size="2" face="Verdana, Arial, Helvetica, sans-serif">
    <!---Ounces to something--->
    <cfif form.FromUnit IS 'Ounces' AND form.ToUnit IS 'Pounds'>
      <cfset FinalFigure = form.FromWeight / 16>
    </cfif>
    <cfif form.FromUnit IS 'Ounces' AND form.ToUnit IS 'Grams'>
      <cfset FinalFigure = form.From/Weight * 0.0352739619>
    </cfif>
    <cfif form.FromUnit IS 'Ounces' AND form.ToUnit IS 'KiloGrams'>
      <cfset FinalFigure = form.FromWeight * 35.2739619>
    </cfif>
    <!---Pounds to something--->
    <cfif form.FromUnit IS 'Pounds' AND form.ToUnit IS 'Ounces'>
      <cfset FinalFigure = form.FromWeight * 16>
    </cfif>
    <cfif form.FromUnit IS 'Pounds' AND form.ToUnit IS 'Kilograms'>
      <cfset FinalFigure = form.FromWeight / 2.20462262 >
    </cfif>
    <cfif form.FromUnit IS 'Pounds' AND form.ToUnit IS 'grams'>
      <cfset FinalFigure = form.FromWeight * 0.00220462262>
    </cfif>
    <!---Grams to something--->
    <cfif form.FromUnit IS 'Grams' AND form.ToUnit IS 'Kilograms'>
      <cfset FinalFigure = form.FromWeight / 1000 >
    </cfif>
    <cfif form.FromUnit IS 'Grams' AND form.ToUnit IS 'Pounds'>
      <cfset FinalFigure = form.FromWeight / 0.00220462262>
    </cfif>
    <cfif form.FromUnit IS 'Grams' AND form.ToUnit IS 'Ounces'>
      <cfset FinalFigure = form.FromWeight / 0.0352739619>
    </cfif>
    <!---Kilograms to something--->
    <cfif form.FromUnit IS 'Kilograms' AND form.ToUnit IS 'Grams'>
      <cfset FinalFigure = form.FromWeight * 1000>
    </cfif>
    <cfif form.FromUnit IS 'Kilogram' AND form.ToUnit IS 'Pounds'>
      <cfset FinalFigure = form.FromWeight * 2.20462262 >
    </cfif>
    <cfif form.FromUnit IS 'Kilogram' AND form.ToUnit IS 'Ounces'>
      <cfset FinalFigure = form.FromWeight / 35.2739619>
    </cfif>
    <cfoutput>#form.FromWeight# #form.FromUnit# = #FinalFigure# #form.ToUnit#</cfoutput></font> </p>
</cfif>
</cfif>  
</body>
</html>










