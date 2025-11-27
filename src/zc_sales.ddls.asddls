@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Consumption View'
@Metadata.ignorePropagatedAnnotations: false
define view entity ZC_SALES 
as select from ZI_RP_SALES_CUBE
{
    key _BusinessPartner.CompanyName,
    key _BusinessPartner.CountryName,
    GrossAmount,
    CurrencyCode,
    Qty,
    UnitOfMeasure

}
