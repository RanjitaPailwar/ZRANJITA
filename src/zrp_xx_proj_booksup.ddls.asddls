@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'BOOKING SUPPL. PROJECTION'
@Metadata.ignorePropagatedAnnotations: true
@Metadata.allowExtensions: true
define view entity ZRP_XX_PROJ_BOOKSUP 
as projection on ZRP_XX_BOOKSUPPL

{
    key TravelId,
    key BookingId,
    key BookingSupplementId,
    SupplementId,
    @Semantics.amount.currencyCode: 'CurrencyCode'
    Price,
    CurrencyCode,
    LastChangedAt,
    /* Associations */
    _Booking : redirected to parent ZRP_XX_PROJ_BOOKING,
    _Product,
    _SupplementText,
    _Travel : redirected to  ZRP_XX_PROJ_TRAVEL
}
