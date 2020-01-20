// -------------------------------------------- 
// activity Write SOSL Queries:                 
// Create an Apex class that returns both contacts and leads based on parameter.
// To pass this challenge, create an Apex class that returns both contacs and
// leads that have first or last name matching the incoming parameter.
//
// The Apex class must be called ContactAndLeadSearch and be in the public scope.
// The Apex class must have a public static method called searchContactsAndLeads
//   The method must accept an incoming string parameter.
//   The method should then find any contact or lead that matches the string as part of
//   either the first or last name.
//   The method should finally use a return type of List<List<SObject>>
// Note: Because SOSL indexes data for searching, you must create a Contact record and Lead record
//       before checking this challenge.
// Both records must have the name Smith. The challenge uses these records for the SOSL search.
// -------------------------------------------- 
public class ContactAndLeadSearch{
    public static List<List<SObject>> searchContactsAndLeads(String vname){
        List<List<SObject>> srchList = [Find :vname in Lead.FirstName, Lead.LastName, Contact.FirstName, Contact.LastName
                                        returning Contact(FirstName,LastName), Lead(FirstName,LastName)];
        Contact[] srchContact = (Contact[])srchList[0];
        Lead[] srchLead = (Lead[])srchList[1];
        for (Contact c : srchContact){
            System.debug('Contact:' + ' ' + c.LastName + ','+c.FirstName);
        }
        for (Lead c : srchLead){
            System.debug('Lead:' + ' ' + l.LastName + ','+l.FirstName);
        }
        return srchList;
    }
}