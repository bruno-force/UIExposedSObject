/**
 * @author            : Bruno Diaz
 * @lastModifiedDate  : 04-15-2021
 **/
import { LightningElement } from 'lwc';

class ExposedObject {
    constructor(exposedObject) {
        Object.assign(this, exposedObject);
    }

    getFieldLabel(field) {
        return this.fields[field.fieldApiName.toLowerCase()].label;
    }

    getType(field) {
        return this.fields[field.fieldApiName.toLowerCase()].fieldType;
    }

    getColumnDefinition(field, options = {}) {
        return {
            label: this.getFieldLabel(field),
            fieldName: field.fieldApiName,
            ...options
        };
    }
}

export { ExposedObject };
