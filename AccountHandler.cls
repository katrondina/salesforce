public class AccountHandler {
    public static Account insertNewAccount (String n){
        Account acct = new Account(Name=n);
        try{
            insert acct;
            String nme = acct.Name;       //for debugging
            System.debug('Name: ' + nme); //for debugging
            return acct;
        } catch (DmlException e){
            System.debug('name is null'); //for debugging
            return null;
        }
    }
}