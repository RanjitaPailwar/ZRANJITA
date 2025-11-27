@EndUserText.label: 'CDS Table Function'
@ClientHandling.algorithm:#SESSION_VARIABLE
@ClientHandling.type: #CLIENT_DEPENDENT
define table function ZRP_CDS_TABLE_FUN
returns {
 client : abap.clnt;
 company_name : abap.char( 256 );
 total_sales : abap.curr( 15, 2 );
 currency_code : abap.cuky;
 customer_rank : abap.int4;
  
}
implemented by method ZRP_FIRST_AMDP=>get_total_sales;