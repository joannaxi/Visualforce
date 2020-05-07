public with sharing class CreateNewContactsController {
    public Contact contact{get; set;}
    public CreateNewContactsController() {
        contact = new Contact();
    }
    public PageReference insertContact(){
        insert contact;
        Pagereference pageref = new Pagereference('https://na174.lightning.force.com/lightning/r/Contact/' +  contact.Id + '/view');
        pageref.setRedirect(true);
        return pageref;
    }
}
