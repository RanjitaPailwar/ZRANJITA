@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Sales Order'
@Metadata.ignorePropagatedAnnotations: true
define view entity ZI_RP_SALES 
as select from zrp_tab_sal_head as hdr
association [1..*] to zrp_tab_sal_item as _Item
on $projection.OrderId = _Item.order_id
{
    key hdr.order_id as OrderId,
    hdr.order_no as OrderNo,
    hdr.buyer as Buyer,
    hdr.created_by as CreatedBy,
    hdr.created_on as CreatedOn,
    _Item
}
