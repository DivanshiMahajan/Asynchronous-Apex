public class Queueablemethod implements Queueable {
    
    List<Contact> contacts;
    
    public Queueablemethod(List<Contact> contacts) {
        this.contacts = contacts;
    }
    
    public void execute(QueueableContext context) {
        List<Account> newAccounts = new List<Account>();
        
        for (Contact contact : contacts) {
            Account acc = new Account(Name = 'Account for ' + contact.LastName);
            newAccounts.add(acc);
        }
        
        insert newAccounts;
    }
}