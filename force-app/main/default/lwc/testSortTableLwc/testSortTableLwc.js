import { LightningElement, wire, track } from 'lwc';
import getContacts from '@salesforce/apex/TEST_SortTableController.getTrackingCovid';
import deleteTC from '@salesforce/apex/TEST_SortTableController.deleteTC';

// datatable columns with row actions. Set sortable = true
const COLUMNS = [ { label: 'Date Checked', fieldName: 'Date_Checked__c', type: 'datetime', sortable: "true"},
                  { label: 'Positive', fieldName: 'Positive__c', type: 'number'},
                  { label: 'Negative', fieldName: 'Negative__c', type: 'number'},
                  { label: 'Hospitalized Currently', fieldName: 'Hospitalized_Currently__c', type: 'number'},
                  { type: "button", typeAttributes: {  
                    label: 'Eliminar',  
                    name: 'daleted',  
                    title: 'Eliminar',  
                    disabled: false,  
                    value: 'daleted',  
                    iconPosition: 'center'  
                } }];

export default class TestSortTableLwc extends LightningElement {

    @track data;
    @track columns = COLUMNS;
    @track sortBy;
    @track sortDirection;
    @track error;
    spinnerActive = false;
 
    @wire(getContacts)
    contacts(result) {
        if (result.data) {
            this.data = result.data;
            this.error = undefined;
        } else if (result.error) {
            this.error = result.error;
            this.data = undefined;
        }
    }

    doSorting(event) {
        this.sortBy = event.detail.fieldName;
        this.sortDirection = event.detail.sortDirection;
        this.sortData(this.sortBy, this.sortDirection);
    }

    sortData(fieldname, direction) {
        let parseData = JSON.parse(JSON.stringify(this.data));
        // Return the value stored in the field
        let keyValue = (a) => {
            return a[fieldname];
        };
        // cheking reverse direction
        let isReverse = direction === 'asc' ? 1: -1;
        // sorting data
        parseData.sort((x, y) => {
            x = keyValue(x) ? keyValue(x) : ''; // handling null values
            y = keyValue(y) ? keyValue(y) : '';
            // sorting values based on direction
            return isReverse * ((x > y) - (y > x));
        });
        this.data = parseData;
    }  

    callRowAction(event){ 
        this.spinnerActive = true;
        const actionName = event.detail.action.name;  
        console.log('event.detail.row: ' + JSON.stringify(event.detail.row));
        if ( actionName === 'daleted' ) {  
  
             
            deleteTC({Id : event.detail.row.Id}).then((result) => {
                if(result === 'EXITO'){
                    alert('Se elimino con exito el regsitro');
                }else{
                    alert('Ocurrio un error al eliminar el registro: ' + result);
                }
                this.spinnerActive = false;
            }).catch((error) => {
                this.error = error;
            });
  
        }
    }

}