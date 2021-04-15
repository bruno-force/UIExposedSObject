# UIExposedSObject
Fetch and Expose SObjects to the UI and avoid extra SObject/Field Descriptions

## Apex
```java
@AuraEnabled
public static ExposedObject getRecords(Id orderId){
    return new ExposedObject(Account.sObjectType).addRecords([SELECT ID FROM Account LIMIT 5]);
}
```

## LWC | Fetch
````javascript 
import { ExposedObject } from 'c/exposedObject';

async fetchRecords() {
    try {
        this.exposedContainer = new ExposedObject(
            await getRecords()
        );
        this.records = this.exposedContainer.records;
    } catch (e) {
        console.error(e);
    }
}
```` 

## LWC | Get Column Definition for Lighning-Datatable
```javascript
import ACCOUNT_NAME from '@salesforce/schema/Account.Name';
this.exposedContainer.getColumnDefinition(ACCOUNT_NAME);
```

## LWC | Get Column Definition for Lighning-Datatable EXTENDED
```javascript
this.exposedContainer.getColumnDefinition(URL_FIELD, {
    fieldName: 'url',
    type: 'url',
    typeAttributes: {
        label: { fieldName: URL_FIELD.fieldApiName },
        target: '_blank'
    }
})
```

## LWC | Get Field Label
```javascript
this.exposedContainer.getFieldLabel(URL_FIELD)
```
