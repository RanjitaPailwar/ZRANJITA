@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'BOOKING PROJECTION'
@Metadata.ignorePropagatedAnnotations: true
@Metadata.allowExtensions: true
define view entity ZRP_XX_PROJ_BOOKING 
as projection on ZRP_XX_BOOKING
{
    key TravelId,
    key BookingId,
    BookingDate,
    CustomerId,
    CarrierId,
    ConnectionId,
    FlightDate,
    @Semantics.amount.currencyCode: 'CurrencyCode'
    FlightPrice,
    CurrencyCode,
    BookingStatus,
    LastChangedAt,
    /* Associations */
    _BookingStatus,
    _BookingSupplement:redirected to composition child ZRP_XX_PROJ_BOOKSUP,
    _Carrier,
    _Connection,
    _Customer,
    _Travel : redirected to parent ZRP_XX_PROJ_TRAVEL
}
