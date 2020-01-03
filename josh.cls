//insert the Josh contact
Contact josh= new Contact(FirstName='Josh',LastName='Kaplan',Department='Finance');
insert josh;
//Josh's record has been inserted
//so the variable josh has now an ID
//which will be used to match the records by upsert
josh.Description = 'Josh\'s record has been updated by the upsert operation.';
//create the Kathy contact, but don't persist it in the database
Contact kathy = new Contact(FirstName='Kathy',LastName='Brown',Department='Technology');
//List to hold the new contacts to upsert
List<Contact> contacts = new List<Contact> {josh, kathy};
//call upsert
upsert contacts;
//Result: Josh is updated and Kathy is created.
//****** */
//******* another activity below*/
Contact jane=new Contact(FirstName='Jane',
                         LastName='Smith',
                         Email='jane.smith@example.com',
                         Description='Contact of the day');
insert jane;
//1. upsert using an idLookup field
//create a second sObject variable.
//This variable doesn't have any ID set.
Contact jane2 = new Contact(FirstName='Jane',
                            LastName='Smith',
                            email='jane.smith@example.com',
                            Description='Prefers to be contacted by email');
//upsert the contact by using the idLoopkup field for matching.
upsert jane2 Contact.fields.Email;
//verify that the contact has been updated
System.assertEquals('Prefers to be contacted by email.',
                [SELECT Description FROM Contact WHERE Id=:jane.Id].Description);