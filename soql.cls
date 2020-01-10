// add account and related contact
Account acct = new Account(
    Name='SFDC Computing',
    Phone='(415)555-1212',
    NumberOfEmployees=50,
    BillingCity='San Francisco');
insert acct;
// Once the account is inserted, the sObject will be
// populated with an ID.
// Get this ID.
ID acctID = acct.ID;
// Add a contact to this account.
Contact con = new Contact(
    FirstName='Carol',
    Lastname='Ruiz',
    Phone='(415)555-1212',
    Department='Wingo',
    AccountID=acctID);
insert con;
// Add account with no contact
Account acct2 = new Account(
    Name='The SFDC Query Man',
    Phone='(310)555-1213',
    NumberOfEmployees=50,
    BillingCity='Los Angeles',
    Description='Expert in wing technologies.');
insert acct2;
////////////////////////////////////////////////////
// sample
///////////////////////////////////////////////////
Account[] accts = [Select Name,Phone From Account
where (Name='SFDC Computing' and NumberOfEmployees>25)
order by Name
limit 10];
System.debug(accts.size() + 'account(s) returned.');
// Write all account array info
System.debug(accts);
//////////////////////////////////////////////////
// for loop in soql
/////////////////////////////////////////////////
insert new Account[]{new Account(Name='for loop 1'),
new Account(Name='for loop 2'),
new Account(Name='for loop 3');}
// The sObject list formart executes the for loop once per returned batch
// of records
integer i=0;
integer j=0;
for (Account[] tmp : [Select Id from Account where Name Like 'for loop _']){
    j=tmp.size();
    i++;
}
System.assertEquals(3,j); // The list should have contained the three accounts named 'yyy'
System.assertEquals(1,i); // Since a single batch can hold up to 200 records and,
                          // only three records should have been returned, the 
                          // loop should have executed only once