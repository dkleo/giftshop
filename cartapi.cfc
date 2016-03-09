/**
 * Created by Derek on 3/8/16.
 */
component {
  function addToCart(String productID, String quantity) access="remote" {
      var query = new Query();
      query.setSQL("INSERT INTO CartItem (CartID, ProductID, Quantity) VALUES (:CartID, :ProductID, :Quantity)");
      query.addParam(name: "CartID", value: session.cartID, cfsqltype: "CF_SQL_INT");
      query.addParam(name: "ProductID", value: productID, cfsqltype: "CF_SQL_INT");
      query.addParam(name: "Quantity", value: quantity, cfsqltype: "CF_SQL_INT");
      query.execute();
  }

    function removeFromCart(String itemID) access="remote" {
        var query = new Query();
        query.setSQL("DELETE FROM CartItem WHERE ID = :ItemID");
        query.addParam(name: "ItemID", value: itemID, cfsqltype: "CF_SQL_INT");
        query.execute();
    }
}
