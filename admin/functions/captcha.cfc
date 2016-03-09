<!---Creates Captcha String--->
<cfcomponent>
<!---LoginCheck: check login credentials and creates cookies Passes back yes/no/failed if logged in. --->
   	<cffunction name="create" access="public" returntype="string" description="Creates a captcha string">
    <cfargument default="3" required="no" name="characters" type="numeric" hint="Number of characters to use for captcha">
		<!---create the array for CAPTCHA--->
        <cfset arrValidChars = ListToArray("A,B,C,D,E,F,G,H,J,K,L,M,N,O,P,Q,R,S,T,U,V,W,X,Y,Z," & "2,3,4,5,6,7,8,9" ) />
        
        <!---shuffle the array--->
        <cfset CreateObject("java", "java.util.Collections").Shuffle(arrValidChars) />
        
        <!---grap the first 5 characters of the array--->
        <cfset strCaptcha = "">
        
        <cfloop from = "1" to = "#characters#" index="i">
        
			<cfset strCaptcha = strCaptcha & (arrValidChars[ #i# ])>
   		
        </cfloop>
        
        <cfreturn strCaptcha>
    </cffunction>              
</cfcomponent>