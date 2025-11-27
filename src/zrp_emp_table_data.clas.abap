CLASS zrp_emp_table_data DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zrp_emp_table_data IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.

    DATA: lt_employee TYPE TABLE OF zrp_emp_table.

    lt_employee = VALUE #( ( empid = '101'
                             empname = 'EMP01'
                             department = 'ABAP'
                             manager = 'Ranjita'
                             Salary = '500000'
                             currency = 'usd' )

                             ( empid = '102'
                             empname = 'EMP02'
                             department = 'ABAP'
                             manager = 'Ranjita'
                             Salary = '900000'
                             currency = 'EURO' )

                             ( empid = '103'
                             empname = 'EMP02'
                             department = 'ABAP'
                             manager = 'Ranjita'
                             Salary = '7000000'
                             currency = 'usd' )

                             ( empid = '104'
                             empname = 'EMP03'
                             department = 'ABAP'
                             manager = 'Ranjita'
                             Salary = '900000'
                             currency = 'usd' )

                           ).
    INSERT zrp_emp_table  FROM TABLE @lt_employee.

    select * froM zrp_emp_table
    into tabLE @DATA(lt_result).

    out->write(
      EXPORTING
        data   = lt_result

    ).

  ENDMETHOD.
ENDCLASS.
