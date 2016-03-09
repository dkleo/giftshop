/**
 * Created by Derek on 3/6/16.
 */
component {
    this.name = 'giftshop';
    this.datasource = 'giftshop';
    this.applicationTimeout = CreateTimeSpan(10, 0, 0, 0);
    this.sessionManagement = true;
    this.sessionTimeout = CreateTimeSpan(0, 0, 30, 0);
    this.sessioncookie.httponly = true;
    this.sessioncookie.timeout = "10";
    this.sessioncookie.disableupdate = true;

    function onApplicationStart()
    {
        application.seoPageTitle = 'Treasures Gift Shop | Same Day Hospital Delivery of Get Well Gifts and Flowers';
        return true;
    }

    function onRequestStart(String targetPage)
    {
        if (structKeyExists(url, 'reload')) {
            onApplicationStart();
        }


    }

    function onSessionStart()
    {
        spService = new storedproc();
        spService.setDatasource("giftshop");
        spService.setProcedure("initCart");
        spService.addParam(cfsqltype = "cf_sql_numeric", type = "in", value = session.cfid);
        spService.addParam(cfsqltype = "cf_sql_numeric", type = "out", variable = "CARTID");
        result = spService.execute();
        session.cartID = result.getprocOutVariables().CARTID;
    }

}