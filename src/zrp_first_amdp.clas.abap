CLASS zrp_first_amdp DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_amdp_marker_hdb .
    INTERFACES if_oo_adt_classrun .
    "Then I will defined static method for us
    "This method only have the import and export parameters and all these parameter must be passed by Value.
    CLASS-METHODS : add_two_number
      AMDP OPTIONS CDS SESSION CLIENT DEPENDENT
      IMPORTING VALUE(num1)   TYPE i
                VALUE(num2)   TYPE i
      EXPORTING VALUE(result) TYPE i.

    CLASS-METHODS : get_custom_id
      AMDP OPTIONS CDS SESSION CLIENT DEPENDENT
      IMPORTING VALUE(bp_id)  TYPE zrp_dte_id
      EXPORTING VALUE(result) TYPE zrp_dte_id.

   CLASS-METHODS : get_total_sales
                for tABLE FUNCTION ZRP_CDS_TABLE_FUN.



  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zrp_first_amdp IMPLEMENTATION.
  METHOD if_oo_adt_classrun~main.
    zrp_first_amdp=>get_custom_id(
      EXPORTING
        bp_id  = 'BP0001'
     IMPORTING
        result = DATA(lv_customer)
    ).
    out->write(
      EXPORTING
        data   = lv_customer
*         name   =
*       RECEIVING
*         output =

  ).
  ENDMETHOD.
  METHOD add_two_number BY DATABASE PROCEDURE FOR HDB LANGUAGE SQLSCRIPT
                        OPTIONS READ-ONLY.

*declare a variable

    deCLARE X integer;
    declare Y integer;

    X := :num1;
    Y := :num2;

    result := :x + :y;

  ENDMETHOD.

  METHOD get_custom_id BY DATABASE PROCEDURE FOR HDB LANGUAGE SQLSCRIPT
                        OPTIONS READ-ONLY USING zrp_table_bpa .

    SELECT company_name INTO result
    FROM zrp_table_bpa
    WHERE bp_id = :bp_id;

  ENDMETHOD.

METHOD get_total_sales by DATABASE FUNCTION FOR HDB LANGUAGE SQLSCRIPT
                          oPTIONS rEAD-ONLY usING ZRP_TAB_SAL_HEAD ZRP_TAB_SAL_ITEM ZRP_TABLE_BPA.

     retURN selECT BPA.client,
             BPA.company_name,
            sum( item.gross_amount ) as total_sales,
            item.currency_code as currency_code,
            rANK ( ) OVER( order BY sum( item.gross_amount ) desc ) as customer_rank
            frOM zrp_table_bpa as BPA
            INNER JOIN ZRP_TAB_SAL_HEAD as sales_header
            on bpa.bp_id = sales_header.buyer
            iNNER jOIN zrp_tab_sal_item as item
            on sales_header.order_id = item.order_id
            grOUP BY  BPA.client,
                     bpa.company_name,
                     item.currency_code;
  ENDMETHOD.







ENDCLASS.
