public class CartDetailsAuraServices {
    
    private static List<Coupon__c> getCoupon(String Name){
        List<Coupon__c> coupon = [Select Id,Name, Price__c,Coupon_Name__c From Coupon__c Where Coupon_Name__c =: Name];
        return coupon;
    }
    
    @AuraEnabled
    public static Decimal checkCoupon(String Name, String CartId){
        List<Coupon__c> couponList =  getCoupon(Name);
        if(couponList !=null && couponList.size() > 0 && couponList[0].Expired__c == False && couponList[0].Remaining_Quantity__c >0){
            Cart__c cart = new Cart__c(Id = cartId, Coupon__c =couponList[0].Id );
            update cart;
            return couponList[0].Price__c;
        }else{
            return null;
        }
    }
    //Cart Items api name  - Cart_Items__c
    @AuraEnabled
    public static String createCartItems(List<String> beerList, String cartId){
        System.debug('#### beerList '+ beerList);
        List<Cart_Items__c> cartItemList = new List<Cart_Items__c>();
        List<Cart_Items__c> cartItemToUpdate = new List<Cart_Items__c>();
        Map<Id, Cart_Items__c> beerQntyMap = getCartItems(cartId);
        For(String beer : beerList){
            if(beerQntyMap != null && beerQntyMap.containsKey(beer)){
                Cart_Items__c it = beerQntyMap.get(beer);
                Cart_Items__c item = new Cart_Items__c(
                    Item_Quantity__c = it.Item_Quantity__c+1,
                    Id = it.Id
                );
                cartItemToUpdate.add(item);
            }else{
                Integer Qty = 1;
                Cart_Items__c item = new Cart_Items__c(
                    Cart__c = cartId,
                    Beer__c = beer,
                    Item_Quantity__c = Qty
                );
                cartItemList.add(item);
            }
        }
        insert cartItemList;
        if(cartItemToUpdate != null && cartItemToUpdate.size() > 0)
            update cartItemToUpdate;
        return cartId;
    }
    
    @AuraEnabled 
    public static String getCartId(List<String> beerList){
        List<Cart__c> cartList = getCart();
        if(cartList != null && cartList.size() > 0){
            createCartItems(beerList, cartList[0].Id);
            system.debug('cartlist1:'+cartList[0].Id);
            
            return cartList[0].Id;
            
            
        }else{
            Cart__c cart = new Cart__c(Coupon__c = getCoupon('Default')[0].Id,Cart_Id__c=String.valueOf(Math.random()),
                                       Cart_Status__c='Open', Is_Active__c=true, User__c = UserInfo.getUserId());
            insert cart;
            createCartItems(beerList, cart.Id);
            return  cart.Id;
        }
    }
    private static List<Cart__c> getCart(){
        List<Cart__c> cartList = [Select Id, Name From Cart__c Where User__c=: UserInfo.getUserId() AND Is_Active__c = true];
        system.debug('cartlist:'+cartList);
        return cartList;
        
    }
    
    @AuraEnabled
    public static Map<Id, Cart_Items__c> getCartItems(String CartId){
        system.debug('CartId -'+CartId);
        //Total_Amount__c formula field
        List<Cart_Items__c> existingItemList = [Select Id, Name, Item_Quantity__c,Total_Amount__c, Beer__c, Beer__r.Name From Cart_Items__c 
                                                Where Cart__c =: cartId];
        system.debug('existingItemList -'+existingItemList);
        
        Map<Id, Cart_Items__c> beerQntyMap = new Map<Id, Cart_Items__c>();
        For(Cart_Items__c item : existingItemList){
            if(!beerQntyMap.containsKey(item.Beer__c)){
                beerQntyMap.put(item.Beer__c, item);
            }
        }
        return beerQntyMap;
    }
    
    @AuraEnabled
    public static void deleteItem(String CartItemId){
        Database.delete(CartItemId);
    }
    
    // When we have any JS action is setStorable() , "Apex methods that are to be cached must be marked as @AuraEnabled(cacheable=true)"
    @AuraEnabled(cacheable=true)
    public static String fetchAddressBook(){
        List<Address_Book__c> addressList = [Select Id,Name,Street__c,State__c,Postal_Code__c,Country__c,City__c from Address_Book__c where User__c =: UserInfo.getUserId()];
        //This will convert List into JSON String
        return JSON.serialize(addressList);
    }
    
    
    /*addressId : selectedAdd.Id,
cartId : component.get('v.CartId'),
UserId : userId,
subTotal : component.get('v.subTotal') */
    
    @AuraEnabled
    public static String createOrder(Id addressId ,Id cartId,Id UserId,Integer subTotal){
        system.debug('Create Order method');
        Order__c ord = new Order__c(subTotal__c=subTotal, Cart__c=cartId,User__c=UserId,Shipping_Address__c=addressId);
        insert ord;
        Cart__c cart = new Cart__c(Id = cartId, Cart_Status__c ='Closed',Is_Active__c=false);
        update cart;
        Order__c getOrd = [Select id, Name from Order__c where id =: ord.Id];
        return getOrd.Name+'####'+getOrd.Id;
    }
    
}