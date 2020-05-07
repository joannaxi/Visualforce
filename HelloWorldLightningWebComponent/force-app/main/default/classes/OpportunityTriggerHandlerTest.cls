@isTest
public with sharing class OpportunityTriggerHandlerTest {
    @isTest
    public static void oddEvenOpportunityTest() {
        List<Opportunity> opportunities = new List<Opportunity>();
        Date mydate = Date.newInstance(2020, 6, 25);

        Opportunity opp1 = new Opportunity();
        
        opp1.Name = 'Opp1';
        opp1.StageName = 'Prospecting';
        opp1.CloseDate = mydate;
        opp1.Amount = 12;

        opportunities.add(opp1);

        Opportunity opp2 = new Opportunity();

        opp2.Name = 'Opp2';
        opp2.StageName = 'Prospecting';
        opp2.CloseDate = mydate;
        opp2.Amount = 33;

        opportunities.add(opp2);

        Test.startTest();

        insert opportunities;
        UpdateAmountActionOfOpportunity.updateAmount(opportunities);

        Test.stopTest();
    }
}
