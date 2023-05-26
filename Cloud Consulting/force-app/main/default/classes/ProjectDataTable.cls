public class ProjectDataTable{
        String name;
        String status;
        String squadLeadName;
        Date startDate;
        Date endDate;
        Decimal soldHours;
    
        public ProjectDataTable(Project__c project){
            this.name = project.Name;
            this.status = project.Status__c;
            this.squadLeadName = project.Squad_Lead__r.FullName__c;
            this.startDate = project.Start_Date__c;
            this.endDate = project.End_Date__c;
            this.soldHours = project.Sold_Hours__c;
        }
    }