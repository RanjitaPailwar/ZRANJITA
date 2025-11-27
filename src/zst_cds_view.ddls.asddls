@AbapCatalog.sqlViewName: 'ZVIEW_DDIC'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'CDS View'
@Metadata.ignorePropagatedAnnotations: true
define view ZST_CDS_VIEW as select from zrp_table_bpa
{
    key bp_id as BpId,
    bp_role as BpRole,
    company_name as CompanyName,
    street as Street,
    country as Country,
    region as Region,
    city as City
}
