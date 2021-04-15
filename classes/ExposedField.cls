/**
 * @author            : Bruno Diaz
 * @lastModifiedDate  : 04-06-2021
**/
public inherited sharing class ExposedField {
    @AuraEnabled
    public String apiName;
    @AuraEnabled
    public String label;
    @AuraEnabled
    public String fieldType;

    public ExposedField(Schema.DescribeFieldResult fieldDescribe) {
        this.apiName = fieldDescribe.getName();
        this.label = fieldDescribe.getLabel();
        this.fieldType = fieldDescribe.getType().name();
    }
}
