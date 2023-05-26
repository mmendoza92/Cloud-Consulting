trigger validateProjectTrigger on Project__c (before update, before insert) {
    if(trigger.isBefore) {
        if(trigger.isUpdate)
        {
            validateProjectHandler.validateProjectCompletion(Trigger.new);
            validateProjectHandler.assignSquadLead(Trigger.new,Trigger.oldMap);
            system.debug('estoy aca trigger');
           
            
        }
            
            
        }

       /*  if(trigger.isInsert) {
            if(trigger.isUpdate)
            {
                validateProjectHandler.statusLoss(Trigger.new);
            }
            
        } */


    }