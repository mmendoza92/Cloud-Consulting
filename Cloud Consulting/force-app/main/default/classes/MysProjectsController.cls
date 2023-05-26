public with sharing class MysProjectsController {
    @AuraEnabled(cacheable=true)
     public static string getProjects() {
        /*  return [SELECT Id, Name, Status__c, Start_Date__c, End_Date__c, Squad_Lead__r.Name, Sold_Hours__c 
        FROM Project__c   
       ];   */
     
    
     List<Project_Resources__c> PRO = [SELECT Id,Project__c FROM Project_Resources__c WHERE Resource__c =: UserInfo.getUserId()];
    Set<Id> projectIds = new Set<Id>();
    for(Project_Resources__c pr : PRO){
        projectIds.add(pr.Project__c);
    }


    List<Project__c> projects = 
        [SELECT Id, Name, Status__c, Start_Date__c, End_Date__c, Squad_Lead__r.FullName__c, Sold_Hours__c 
        FROM Project__c WHERE Id IN :projectIds 
        ];

    List<ProjectDataTable> projectDataTables = new List<ProjectDataTable>();
    for(Project__c project : projects){
        system.debug('project'+new ProjectDataTable(project));
        projectDataTables.add(new ProjectDataTable(project));
    }
      
    system.debug('projectDataTables'+projectDataTables);
    
    return JSON.serialize(projectDataTables);


 

    

    } 

    public class ProjectDataTable{
        String name;
        String status;
        String squadLeadName;
        Date startDate;
        Date endDate;
        Decimal soldHours;
        Id id;
    
        public ProjectDataTable(Project__c project){
            this.name = project.Name;
            this.status = project.Status__c;
            this.squadLeadName = project.Squad_Lead__r.FullName__c;
            this.startDate = project.Start_Date__c + 1;
            this.endDate = project.End_Date__c + 1;
            this.soldHours = project.Sold_Hours__c;
            this.id = project.Id;
        }
    }



}