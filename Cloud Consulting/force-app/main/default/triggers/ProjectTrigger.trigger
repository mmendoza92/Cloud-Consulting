trigger ProjectTrigger on Project__c (before update) {
    for (Project__c project : Trigger.new) {
        if (project.Status__c == 'In Progress') {
            for (String field : project.getPopulatedFieldsAsMap().keySet()) {
                if (project.get(field) != Trigger.oldMap.get(project.Id).get(field)) {
                    project.addError('Cannot modify fields while Status is "In Progress".');
                }
            }
        }
    }
}