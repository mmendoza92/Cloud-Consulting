import { LightningElement, wire } from 'lwc';
import { NavigationMixin } from 'lightning/navigation';
import getProjects from '@salesforce/apex/MysProjectsController.getProjects';


const COLUMNS = [
    { label: 'Name', fieldName: 'name', type: 'button', typeAttributes: {label: {fieldName: 'name'}, name: 'view_details'} },
    { label: 'Status', fieldName: 'status', type: 'text' },
    { label: 'Project Start Date   ', fieldName: 'startDate', type: 'date' },
    { label: 'Project End Date ', fieldName: 'endDate', type: 'date' },
    { label: 'Squad Lead', fieldName: 'squadLeadName', type: 'text' }, 
    
   { label: 'Sold Hours', fieldName: 'soldHours', type: 'number', cellAttributes: { alignment: 'center' } },



];

export default class MysProjects extends NavigationMixin(LightningElement) {
    projects;
    columns = COLUMNS;

    @wire(getProjects)
    
   

    wiredProjects({ error, data }) {
        
        if (data) {
            this.projects = JSON.parse(data);
            console.log('data', JSON.parse(data));
            this.error = undefined;
        } else if (error) {
            this.error = error;
            this.projects = undefined;
        }
    }

    handleRowAction(event) {
        const row = event.detail.row;
        if (event.detail.action.name === 'view_details') {
            this[NavigationMixin.Navigate]({
                type: 'standard__recordPage',
                attributes: {
                    recordId: row.id,
                    objectApiName: 'Project__c',
                    actionName: 'view'
                }
            });
        }
    }
}