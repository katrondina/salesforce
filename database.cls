//Create list of contacts
List<Contact> conList = new List<Contact>{
    new Contact(FirstName='Joe',LastName='Smith',Department='Finance'),
    new Contact(FirstName='Kathy',LastName='Smith',Department='Technology'),
    new Contact(FirstName='Caroline',LastName='Roth',Department='Finance'),
    new Contact();}

//Bulk insert all contacts with one DML call
Database.SaveResult[] srList = Database.insert(conList, false);
//Iterate thru each returned result
for (Database.SaveResult sr : srList) {
    if (sr.isSuccess()){
        //Operation was successful, so get the ID of the record that was processed
        System.debug('Successfully inserted contact. Contact ID: ' + sr.getId());
    } else{
        //Operation failed, so get all errors
        for(Database.Error err : sr.getErrors()) {
            System.debug('The following error has occurred.');
            System.debug(err.getStatusCode() + ': ' + err.getMessage());
            System.debug('Contact fields that affected this error: ' + err.getFields());
        }
    }
}
////////////////////////////////////////////////
// inserting related records
Account acct = new Account(Name='SFDC Account');
insert acct;
// Once the account is inserted, the sObject will be
// populated with an ID.
// Get this ID.
ID acctID = acct.ID;
// Add a contact to this account.
Contact mario = new Contact(
    FirstName = 'Mario',
    LastName = 'Ruiz',
    Phone='415.555.1212',
    AccountId=acctID);
insert mario;
////////////////////////////////////////////////
// Updating related records
// Query for the contact, which has been associated with an account.
Contact queriedContact = [Select Account.Name
                          From Contact
                          Where FirstName='Mario' and LastName='Ruiz'
                          LIMIT 1];
// Update the contact's phone number
queriedContact.Phone='(415)555-1213';
// Update the related account industry
queriedContact.Account.Industry='Technology';
// Make two separate calls
// 1. This call is to update the contact's phone.
update queriedContact;
// 2. This call is to update the related account's Industry field.
update queriedContact.Account;
/////////////////////////////////////////////////
// Deleting related records
Account[] queriedAccounts = [Select Id from Account where Name='SFDC Account'];
delete queriedAccounts;