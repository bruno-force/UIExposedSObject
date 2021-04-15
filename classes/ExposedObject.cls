/**
 * @author            : Bruno Diaz
 * @lastModifiedDate  : 04-06-2021
**/
public inherited sharing class ExposedObject {
    // Private
    private SObjectType objectType;
    // Public Exposed
    @AuraEnabled
    public String apiName;
    @AuraEnabled
    public String label;
    @AuraEnabled
    public String pluralLabel;
    @AuraEnabled
    public Boolean isCustom;
    @AuraEnabled
    public Map<String, ExposedField> fields;
    @AuraEnabled
    public List<SObject> records = new List<SObject>();

    public ExposedObject(SObjectType objectType) {
        this.objectType = objectType;
        Schema.DescribeSObjectResult objectDescription = this.objectType.getDescribe();
        this.apiName = objectDescription.getName();
        this.label = objectDescription.getLabel();
        this.pluralLabel = objectDescription.getLabelPlural();
        this.isCustom = objectDescription.isCustom();
        this.fields = instanceFields(objectDescription);
    }

    /**
     * Instance Methods
     */
    public ExposedObject addRecords(List<SObject> records) {
        for(SObject record : records) {
            if(record.getSObjectType() != this.objectType) {
                throw new ExposedObjectException('record SObject type incompatible');
            }
        }
        this.records.addAll(records);
        return this;
    }

    /**
     * Class Methods
     */

    private static Map<String, ExposedField> instanceFields(DescribeSObjectResult objectDescription) {
        Map<String, ExposedField> fields = new Map<String, ExposedField>();
        Map<String,SObjectField> fieldsDescriptionMap = objectDescription.fields.getMap();
        for(String key : fieldsDescriptionMap.keySet()) {
            ExposedField exposedField = new ExposedField(fieldsDescriptionMap.get(key).getDescribe());
            fields.put(key, exposedField);
        }
        return fields;
    }

    /**
     * Custom Exceptions
     */

    public class ExposedObjectException extends Exception {}
}