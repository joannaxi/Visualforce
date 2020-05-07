public with sharing class ContactTriggerHandler {
    public static void countNewContacts(List<Contact> newContactsFromTrigger, List<Contact> oldCntactsFromTrigger){

        Map<String,Integer> accountIdContactNum = new Map<String, Integer>(); 
        List<String> accountIds = new List<String>();
        List<String> oldAccountIds = new List<String>(); 
        ​
                
        for(Contact contact : newContactsFromTrigger){
            if(contact.AccountId != null){
                accountIds.add(contact.AccountId); 
            }
        }
        ​
        List<Account> accountList = [SELECT Id, (SELECT Id FROM Contacts) FROM Account WHERE Id IN: accountIds];
        ​
        for(Account account : accountList){
            if(!account.Contacts.isEmpty()){
                accountIdContactNum.put(account.Id, account.Contacts.size());   
            }        
        } 
        System.debug(accountIdContactNum);        
                
                for(Contact contact : newContactsFromTrigger){            
                    if(!accountIdContactNum.containsKey(contact.AccountId) || accountIdContactNum.get(contact.AccountId) == null){
                        accountIdContactNum.put(contact.AccountId, 1);
                    }
                    else{
                        Integer count = accountIdContactNum.get(contact.AccountId); 
                        count++; 
                        accountIdContactNum.put(contact.AccountId, count);           
                    }
                    if(Trigger.Old != null){  
                    for(Contact oldContact : oldCntactsFromTrigger){
                        if(oldContact.AccountId != contact.AccountId){
                            oldAccountIds.add(oldContact.AccountId);
                        }
                    }      
                    }       
                } 
                if(!oldAccountIds.isEmpty()){
                    List<Account> oldAccountList = [SELECT Id, Number_of_Contacs__c FROM Account WHERE Id IN: oldAccountIds] ;
                    for(Account account : oldAccountList){
                        if(account.Number_of_Contacs__c != null){
                            account.Number_of_Contacs__c--; 
                        }
                        else{
                            account.Number_of_Contacs__c = 0; 
                        }                                  
                    }
                    update oldAccountList; 
                }       
                if(!accountIdContactNum.isEmpty()){
                    List<Account> accounts = [SELECT Id, Number_of_Contacs__c FROM Account WHERE Id IN: accountIdContactNum.keySet()];
                    for(Account account : accounts){
                        if(accountIdContactNum.containsKey(account.Id)){
                            account.Number_of_Contacs__c = accountIdContactNum.get(account.Id); 
                        }
                    }
                    update accounts;  
                }  
            }
        ​
            public static void updateAccountForDeletedContact(List<Contact> contactsFromTrigger){
        ​
                List<String> accountIds = new List<String>();
        ​
                for(Contact contact : contactsFromTrigger){
                    if(contact.AccountId != null){
                        accountIds.add(contact.AccountId); 
                    }
                }
        ​
                if(!accountIds.isEmpty()){
                    List<Account> accounts = [SELECT Id, Number_of_Contacs__c FROM Account WHERE Id IN: accountIds];
                    for(Account account : accounts){
                        if(account.Number_of_Contacs__c != null){
                            account.Number_of_Contacs__c--; 
                        }
                        else{
                            account.Number_of_Contacs__c = 0; 
                        }  
                    }
                    update accounts;  
                }
            }
        
}
