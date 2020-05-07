public with sharing class SearchOpportunityController {
    public String searchText {get;set;}
    public String searchField {get;set;}
    public List<Opportunity> opportunities {get; set;}
    public SearchOpportunityController() {
        searchText = '';
        searchField = ''; 
        opportunities = new List<Opportunity>(); 
    }

    public void searchOpportunity(){
        if(searchField == 'Name') {
            opportunities = [SELECT Id, Name, Account.Name, StageName FROM Opportunity WHERE Name LIKE: searchText];
        }
        else if(searchField == 'Account') {
            opportunities = [SELECT Id, Name, Account.Name, StageName FROM Opportunity WHERE Account.Name LIKE: searchText];
        }
        else {
            opportunities = [SELECT Id, Name, Account.Name, StageName FROM Opportunity WHERE StageName LIKE: searchText];
        }
    }
}
