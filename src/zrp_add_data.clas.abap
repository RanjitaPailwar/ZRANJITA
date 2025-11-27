CLASS zrp_add_data DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
    CLASS-METHODS create_add_data.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zrp_add_data IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.
  DATA:lt_bpa     TYPE STANDARD TABLE OF zrp_table_bpa,
         lt_product TYPE STANDARD TABLE OF zrp_table_produc,
         lt_head    TYPE STANDARD TABLE OF zrp_tab_sal_head,
         lt_item    TYPE STANDARD TABLE OF zrp_tab_sal_item.

    lt_bpa = VALUE #( ( client       = sy-mandt
                      bp_id        = 'BP0001'
                      bp_role      = 'CUST'
                      company_name = 'ABC Industries'
                      street       = 'Main Street 1'
                      country      = 'US'
                      region       = 'TX'
                      city         = 'Dallas'

                        )
                        ( client       = sy-mandt
                      bp_id        = 'BP0002'
                      bp_role      = 'CUST'
                      company_name = 'XYZ Trading'
                      street       = 'Market Road 10'
                      country      = 'US'
                      region       = 'CA'
                      city         = 'San Jose'

                        ) )   .
    INSERT zrp_table_bpa FROM TABLE @lt_bpa.


    lt_product = VALUE #( ( client       = sy-mandt
                    product_id   = 'PRD0001'
                    name         = 'Laptop 15 inch'
                    category     = 'ELECTRONICS'
                    price        = '1200.00'
                    currency_code = 'USD'
                    discount     = 10
                        )
                     ( client       = sy-mandt
                    product_id   = 'PRD0002'
                    name         = 'Wireless Mouse'
                    category     = 'ACCESSORY'
                    price        = '25.00'
                    currency_code = 'USD'
                    discount     = 5
                        )
                        ).

    INSERT zrp_table_produc FROM TABLE @lt_product.

lt_head = vALUE #( ( client       = sy-mandt
                    order_id     = 'SO0001'
                    order_no     = 1001
                    buyer        = 'BP0001'
                    gross_amount = '1250.00'
                    currency_code = 'USD'
                    " fields from zrp_struc_admin – adapt to your structure
                    created_by   = sy-uname
                    )
                    ( client       = sy-mandt
                    order_id     = 'SO0002'
                    order_no     = 1002
                    buyer        = 'BP0002'
                    gross_amount = '1200.00'
                    currency_code = 'USD'
                    created_by   = sy-uname
                     ) ).

 INSERT zrp_tab_sal_head FROM TABLE @lt_head.

 lt_item = VaLUE #( ( client       = sy-mandt
                    item_id      = 'IT0001'
                    order_id     = 'SO0001'
                    product      = 'PRD0001'
                    gross_amount = '1200.00'
                    currency_code = 'USD'
                    qty          = '1.00'
                    uom          = 'EA'
                    created_by   = sy-uname )
                    ( client       = sy-mandt
                    item_id      = 'IT0002'
                    order_id     = 'SO0001'
                    product      = 'PRD0002'
                    gross_amount = '50.00'
                    currency_code = 'USD'
                    qty          = '2.00'
                    uom          = 'EA'
                    created_by   = sy-uname )  ).
  ENDMETHOD.
  METHOD create_add_data.




  ENDMETHOD.

ENDCLASS.
