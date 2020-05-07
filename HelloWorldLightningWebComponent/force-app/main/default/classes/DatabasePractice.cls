public with sharing class InsertAccountRecords {
    public Static void insertAccounts() {
        List<Account> accts = new List<Account>( );
        Account acc1 = new Account( Name = 'Account001');
        Account acc2 = new Account( );
        accts.add(acc1);
        accts.add(acc2);
        Database.SaveResult[] results = Database.insert(accts, false);
        for (Database.SaveResult rs : results) {
            if(rs.isSuccess()) {
                System.debug('Successfully inserted account. Account ID: ' + sr.getId());
            }
            else {
                for(Database.Error err : sr.getErrors()) {
                    Error_Log__c error = new Error_Log__c();
                    error.Error_Fields__c = err.getFields();
                    error.Error_Message__c = err.getMessage();
                    error.Error_Status_Code__c = err.getStatusCode();
                    System.debug('The following error has occurred.');                    
                    System.debug(err.getStatusCode() + ': ' + err.getMessage());
                    System.debug('Account fields that affected this error: ' + err.getFields());
                }
            }
        }
    }
}