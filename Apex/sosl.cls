List<List<sObject>> searchList = [Find 'Wingo OR SFDC' in all fields
                                returning Account(Name),Contact(FirstName,LastName,Department)];
Account[] searchAccounts = (Account[])searchList[0];
Contact[] searchContacts = (Contact[])searchList[1];
System.debug('Found the following accounts.');
for (Account a : searchAccounts){
    System.debug(a.Name);
}
System.debug('Found the following Contacts');
for(Contact c : searchContacts){
    System.debug(c.LastName + ', ' + c.FirstName);
}