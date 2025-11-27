@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Travel Projection'
@Metadata.ignorePropagatedAnnotations: true
@Metadata.allowExtensions: true
define root view entity ZRP_XX_PROJ_TRAVEL 
as projection on ZRP_XX_TRAVEL
{
@ObjectModel.text.element: [ 'Description' ]
 key TravelId,
 @ObjectModel.text.element: [ 'AgencyName' ]
 @Consumption.valueHelpDefinition: [{ 
                  entity.name: '/DMO/I_Agency',
                  entity.element: 'AgencyID' }]
 AgencyId,
// Since we are using this AgencyName we allow semantics for this
@Semantics.text: true
 _Agency.Name as AgencyName,
 @ObjectModel.text.element: [ 'CustomerName' ]
  @Consumption.valueHelpDefinition: [{ 
                  entity.name: '/DMO/I_Customer',
                  entity.element: 'CustomerID' }]
 CustomerId,
 // Since we are using this CustomerName we allow semantics for this
@Semantics.text: true
 _Customer.LastName as CustomerName,
 BeginDate,
 EndDate,
 @Semantics.amount.currencyCode: 'CurrencyCode'
 BookingFee,
 @Semantics.amount.currencyCode: 'CurrencyCode'
 TotalPrice,
 CurrencyCode,
 // Since we are using this Description we allow semantics for this
@Semantics.text: true
 Description,
// I want to display label text instead of overallstatus, use below annotation
@ObjectModel.text.element: [ 'StatusText' ]
 @Consumption.valueHelpDefinition: [{ 
                  entity.name: '/DMO/I_Travel_Status_VH',
                  entity.element: 'TravelStatus' }]
 OverallStatus,
 CreatedBy,
 CreatedAt,
 LastChangedBy,
 LastChangedAt,
 @Semantics.text: true
StatusText,
Criticality, 
 /* Associations */
 _Agency,
 _Booking : redirected to composition child ZRP_XX_PROJ_BOOKING,
 _Currency,
 _Customer,
 _OverallStatus   
}
