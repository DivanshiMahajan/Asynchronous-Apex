public class FutureMethod {

    @future
    public static void createAccountsForContacts(List<Id> contactIds) {
        List<Contact> contacts = [SELECT Id, LastName FROM Contact WHERE Id IN :contactIds];
        List<Account> newAccounts = new List<Account>();
        
        for (Contact contact : contacts) {
            Account acc = new Account(Name = 'Account for ' + contact.LastName);
            newAccounts.add(acc);
        }
        
        insert newAccounts;
    }
}