// Create an Apex trigger for Account that matches Shipping Address Postal Code with Billing Address Postal Code
// based on a custom field.
// For this challenge, you need to create a trigger that, before insert and update,
// checks for a checkbox, and if the checkbox field is true, sets the Shipping Postal Code
// (whose API name is ShippingPostalCode) to be the same as Billing Postal Code (BillingPostalCode).
//
// The Apex trigger must be called 'AccountAddressTrigger'.
// The Account object will need a new custom checkbox that should have the Field Label 'Match Billing Address' and
// Field Name 'Match_Billing_Address'. The resulting API Name should be 'Match_Billing_Address__c'.
// With 'AccountAddressTrigger' active, if an Account has a Billing Postal Code and 'Match_Billing_Address__c' is true,
// the record should have the Shipping Postal Code set to match on insert or update.
//
trigger AccountAddressTrigger on Account (before insert, before update){
    if (Trigger.isInsert){
        for(Account a : Trigger.new){
            System.debug(a.Match_Billing_Address__c);
            if(a.Match_Billing_Address__c == true){
                System.debug('Shipping: ' + a.ShippingPostalCode + ' ' + 'Billing: ' + a.BillingPostalCode);
                a.ShippingPostalCode = a.BillingPostalCode;
            }
        }
    }
    else if (Trigger.isUpdate){
        for(Account b : Trigger.old){
            System.debug(b.Match_Billing_Address__c);
            if(b.Match_Billing_Address__c == true){
                for(Account c : Trigger.new){
                    c.ShippingPostalCode = c.BillingPostalCode;
                }
            }
        }
    }
}
// to test in debug code for insert
//Account b = new Account(Name='Paulina',
//                       Match_Billing_Address__c=true,
//                       ShippingPostalCode='1121');
//insert b;
// to test for update
// Account kwery = [SELECT Name,ShippingPostalCode,BillingPostalCode
//                  FROM Accounts WHERE Name='Paulina' and
//                  ShippingPostalCode=''];
// kwery.Match_Billing_Address__c=true;
// kwery.BillingPostalCode='1211';
//update kwery;
