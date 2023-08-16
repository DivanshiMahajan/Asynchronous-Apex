public class LeadToAccount implements Database.Batchable<SObject>, Database.AllowsCallouts {
    public Database.QueryLocator start(Database.BatchableContext BC) {
        String query = 'SELECT Id FROM Lead';
        return Database.getQueryLocator(query);
    }
    
    public void execute(Database.BatchableContext BC, List<SObject> scope) {
        List<Database.LeadConvert> leadConverts = new List<Database.LeadConvert>();
        
        for (SObject sObj : scope) {
            Lead lead = (Lead)sObj;
            Database.LeadConvert lc = new Database.LeadConvert();
            lc.setLeadId(lead.Id);
            lc.setDoNotCreateOpportunity(true);
            lc.setConvertedStatus('Qualified');
            leadConverts.add(lc);
        }
        
        if (!leadConverts.isEmpty()) {
            List<Database.LeadConvertResult> convertResults = Database.convertLead(leadConverts);
          
        }
    }
    
    public void finish(Database.BatchableContext BC) {
       
        sendEmailNotification();
    }
    
    private void sendEmailNotification() {
       
        String recipientEmail = 'divanshimahajan@gmail.com';
        String subject = 'Lead Conversion Process Completed';
        String body = 'The lead conversion process has been completed successfully.';
        
        Messaging.SingleEmailMessage email = new Messaging.SingleEmailMessage();
        email.setToAddresses(new List<String>{recipientEmail});
        email.setSubject(subject);
        email.setPlainTextBody(body);
        
        Messaging.sendEmail(new List<Messaging.Email>{email});
    }
}