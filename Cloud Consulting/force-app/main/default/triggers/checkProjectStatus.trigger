trigger checkProjectStatus on Project__c (before update) {
    for(Project__c p : Trigger.new) {
        if(p.Status__c == 'In Progress') {
            Project__c oldP = Trigger.oldMap.get(p.Id);
            if(p.Description__c != oldP.Description__c || p.Start_Date__c != oldP.Start_Date__c || p.End_Date__c != oldP.End_Date__c ||
               p.Revenue__c != oldP.Revenue__c || p.Estimated_Cost__c != oldP.Estimated_Cost__c ||/* p.Real_Cost__c != oldP.Real_Cost__c ||*/
               p.Opportunity__c != oldP.Opportunity__c || p.Client__c != oldP.Client__c || p.Squad_Lead__c != oldP.Squad_Lead__c ||
               p.Project_Manager__c != oldP.Project_Manager__c || p.Sold_Hours__c != oldP.Sold_Hours__c) {
                p.addError('No se puede modificar un proyecto en progreso.');
            }
        }
    }
}

/*
 Comentamos p.Real_Cost__c != oldP.Real_Cost__c , porque este campo si queremos que cambie.
 A futuro lo editamos para que no sea editable para ciertos recursos.
*/