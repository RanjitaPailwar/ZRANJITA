@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'USING CDS TABLE FUNCTION IN OTHER VIEW'
@Metadata.ignorePropagatedAnnotations: true
define view entity ZRP_CDS_TABLE 
as select from ZRP_CDS_TABLE_FUN
{
   key  company_name,
    @Semantics.amount.currencyCode: 'currency_code'
    total_sales,
    currency_code,
    customer_rank
}
