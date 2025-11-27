@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Sales and BPA'
@Metadata.ignorePropagatedAnnotations: true
define view entity ZI_RP_SALES_CUBE 
as select from ZI_RP_SALES as Sales
association[1] to ZI_RP_BPA as _BusinessPartner
on $projection.Buyer = _BusinessPartner.BpId
association[1] to ZI_RP_PRODUCT as _Product
on $projection.Product = _Product.ProductId
{
   key Sales.OrderId,
   Sales.OrderNo,
   Sales.Buyer,
   Sales.CreatedBy,
   Sales.CreatedOn,
   /* Associations */
   Sales._Item.product as Product,
   @Semantics.amount.currencyCode: 'CurrencyCode'
   Sales._Item.gross_amount as GrossAmount,
   Sales._Item.currency_code as CurrencyCode,
   @Semantics.quantity.unitOfMeasure: 'UnitOfMeasure'
   Sales._Item.qty as Qty,
   Sales._Item.uom as UnitOfMeasure,
   _Product,
   _BusinessPartner
}
